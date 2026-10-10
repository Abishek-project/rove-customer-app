import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/features/booking/bloc/checkout_result.dart';
import 'package:rove_customer_app/features/payments/bloc/payment_cubit.dart';
import 'package:rove_customer_app/features/trips/bloc/booking_detail_cubit.dart';
import 'package:rove_customer_app/shared/models/booking.dart';
import 'package:rove_customer_app/shared/models/enums.dart' hide PaymentStatus;
import 'package:rove_customer_app/shared/models/enums.dart'
    as e
    show PaymentStatus;
import 'package:rove_customer_app/shared/repositories/booking_repository.dart';
import 'package:rove_customer_app/shared/repositories/payment_repository.dart';

import '../helpers/helpers.dart';

class _MockPayments extends Mock implements PaymentRepository {}

void main() {
  late MockStack stack;
  late BookingCreation creation;

  Future<BookingCreation> holdBooking(String vehicleId) async {
    final p = testPeriod(inDays: 20);
    final quote = await stack.bookings.quote(
      QuoteRequest(
        vehicleId: vehicleId,
        pickupAt: p.pickupAt,
        returnAt: p.returnAt,
      ),
    );
    return stack.bookings.create(
      quoteId: quote.id,
      driver: DriverDetails(
        fullName: 'Aisha Rahman',
        phone: '+971501234567',
        dateOfBirth: DateTime(1990),
      ),
      idempotencyKey: 'k-$vehicleId',
    );
  }

  setUp(() async {
    stack = MockStack();
    await stack.signInAe();
  });

  group('PaymentCubit', () {
    blocTest<PaymentCubit, PaymentState>(
      'request-mode booking → pending partner, authorised (not "paid")',
      setUp: () async => creation = await holdBooking(MockStack.aeEconomyId),
      build: () => PaymentCubit(
        repository: stack.payments,
        bookingId: creation.booking.id,
        intent: creation.payment,
        defaultMethod: 'card',
      ),
      act: (c) => c.confirm(),
      verify: (c) {
        expect(c.state.status, PaymentFlowStatus.succeeded);
        expect(c.state.booking!.status, BookingStatus.pendingPartner);
        expect(c.state.booking!.paymentStatus, e.PaymentStatus.authorized);
        expect(resolveResultKind(c.state.booking, null), ResultKind.pending);
      },
    );

    blocTest<PaymentCubit, PaymentState>(
      'instant booking → confirmed and captured',
      setUp: () async => creation = await holdBooking(MockStack.aeSuvInstantId),
      build: () => PaymentCubit(
        repository: stack.payments,
        bookingId: creation.booking.id,
        intent: creation.payment,
      ),
      act: (c) => c.confirm(),
      verify: (c) {
        expect(c.state.booking!.status, BookingStatus.confirmed);
        expect(c.state.booking!.paymentStatus, e.PaymentStatus.captured);
        expect(resolveResultKind(c.state.booking, null), ResultKind.confirmed);
      },
    );

    blocTest<PaymentCubit, PaymentState>(
      'declined payment keeps the booking held with payment failed',
      setUp: () async => creation = await holdBooking(MockStack.aeSuvInstantId),
      build: () => PaymentCubit(
        repository: stack.payments,
        bookingId: creation.booking.id,
        intent: creation.payment,
      ),
      act: (c) {
        c.setSimulateDecline(true);
        return c.confirm();
      },
      verify: (c) {
        expect(c.state.status, PaymentFlowStatus.declined);
        expect(c.state.booking!.status, BookingStatus.held);
        expect(c.state.booking!.paymentStatus, e.PaymentStatus.failed);
        expect(
          resolveResultKind(c.state.booking, c.state.failure),
          ResultKind.declined,
        );
      },
    );

    test('an unknown outcome (network) retries with the same key', () async {
      creation = await holdBooking(MockStack.aeSuvInstantId);
      final repo = _MockPayments();
      final keys = <String>[];
      var calls = 0;
      when(
        () => repo.confirm(
          bookingId: any(named: 'bookingId'),
          intentId: any(named: 'intentId'),
          idempotencyKey: any(named: 'idempotencyKey'),
          simulateOutcome: any(named: 'simulateOutcome'),
        ),
      ).thenAnswer((inv) async {
        keys.add(inv.namedArguments[#idempotencyKey] as String);
        if (calls++ == 0) throw const ApiFailure.network();
        return creation.booking;
      });
      final cubit = PaymentCubit(
        repository: repo,
        bookingId: creation.booking.id,
        intent: creation.payment,
      );
      await cubit.confirm();
      expect(cubit.state.status, PaymentFlowStatus.failed);
      expect(resolveResultKind(null, cubit.state.failure), ResultKind.unknown);
      await cubit.confirm();
      expect(keys, hasLength(2));
      expect(keys[0], keys[1]);
    });
  });

  group('BookingDetailCubit cancellation', () {
    late String bookingId;
    setUp(() async {
      final c = await holdBooking(MockStack.aeSuvInstantId);
      await stack.payments.confirm(
        bookingId: c.booking.id,
        intentId: c.payment.intentId,
        idempotencyKey: 'pay-1',
      );
      bookingId = c.booking.id;
    });

    blocTest<BookingDetailCubit, BookingDetailState>(
      'preview from the backend, then confirm → cancelled with refund',
      build: () => BookingDetailCubit(stack.bookings, bookingId),
      act: (c) async {
        await c.load();
        expect(c.state.booking!.can(CustomerActions.cancel), isTrue);
        await c.previewCancellation();
        expect(c.state.cancelStatus, CancelStatus.ready);
        expect(c.state.preview!.eligible, isTrue);
        expect(c.state.preview!.free, isTrue); // 20 days ahead, moderate policy
        await c.confirmCancellation(reason: 'Plans changed');
      },
      verify: (c) {
        expect(c.state.cancelStatus, CancelStatus.cancelled);
        expect(c.state.booking!.status, BookingStatus.cancelled);
        expect(
          c.state.booking!.refund!.amountMinor,
          c.state.booking!.total.amountMinor,
        );
        expect(c.state.booking!.can(CustomerActions.cancel), isFalse);
      },
    );

    blocTest<BookingDetailCubit, BookingDetailState>(
      'a completed booking cannot be cancelled',
      build: () => BookingDetailCubit(stack.bookings, bookingId),
      act: (c) async {
        final completed = await stack.bookings.list(BookingGroup.completed);
        final cubit = BookingDetailCubit(
          stack.bookings,
          completed.items.first.id,
        );
        await cubit.load();
        await cubit.previewCancellation();
        expect(cubit.state.preview!.eligible, isFalse);
        expect(cubit.state.booking!.can(CustomerActions.cancel), isFalse);
      },
    );
  });

  group('result screen kinds come only from backend state', () {
    test('no booking and a VEHICLE_UNAVAILABLE failure → unavailable', () {
      expect(
        resolveResultKind(
          null,
          const ApiFailure(code: ErrorCodes.vehicleUnavailable),
        ),
        ResultKind.unavailable,
      );
      expect(
        resolveResultKind(null, const ApiFailure(code: ErrorCodes.holdExpired)),
        ResultKind.expired,
      );
      expect(resolveResultKind(null, null), ResultKind.unknown);
    });
  });
}
