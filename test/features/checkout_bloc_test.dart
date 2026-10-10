import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/features/booking/bloc/checkout_bloc.dart';
import 'package:rove_customer_app/shared/models/enums.dart';
import 'package:rove_customer_app/shared/repositories/booking_repository.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(setUpTimeZones);

  late MockStack stack;
  final period = testPeriod();
  final driver = DriverDetails(
    fullName: 'Aisha Rahman',
    phone: '+971501234567',
    dateOfBirth: DateTime(1990, 5, 1),
  );

  CheckoutBloc build(String vehicleId, {DateTime Function()? clock}) =>
      CheckoutBloc(
        vehicleId: vehicleId,
        vehicles: stack.vehicles,
        bookings: stack.bookings,
        profiles: stack.profile,
        clock: clock ?? testClock,
      );

  /// Drives the bloc to a ready quote with the terms accepted.
  Future<void> toReview(CheckoutBloc b) async {
    b.add(
      CheckoutStarted(pickupAt: period.pickupAt, returnAt: period.returnAt),
    );
    await Future<void>.delayed(Duration.zero);
    b
      ..add(const CheckoutTripConfirmed())
      ..add(CheckoutDriverSubmitted(driver));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    b.add(const CheckoutTermsChanged(true));
    await Future<void>.delayed(Duration.zero);
  }

  setUp(() async {
    stack = MockStack();
    await stack.signInAe();
  });

  blocTest<CheckoutBloc, CheckoutState>(
    'verified customer: trip → driver → review with the backend quote',
    build: () => build(MockStack.aeEconomyId),
    act: toReview,
    verify: (b) {
      final s = b.state;
      expect(s.step, CheckoutStep.review);
      expect(s.verificationRequired, isFalse);
      expect(s.steps, hasLength(3));
      expect(s.quoteStatus, QuoteStatus.ready);
      expect(s.quote!.total.currency, 'AED');
      expect(s.quote!.lineItems.first.code, 'rental_fee');
      expect(s.idempotencyKey, isNotNull);
    },
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'booking creates exactly one held booking even when tapped twice',
    build: () => build(MockStack.aeEconomyId),
    act: (b) async {
      await toReview(b);
      b
        ..add(const CheckoutBookingRequested())
        ..add(const CheckoutBookingRequested());
      await Future<void>.delayed(const Duration(milliseconds: 5));
      b.add(const CheckoutBookingRequested());
    },
    wait: const Duration(milliseconds: 20),
    verify: (b) async {
      expect(b.state.creation, isNotNull);
      expect(b.state.creation!.booking.status, BookingStatus.held);
      expect(b.state.creation!.payment.status, 'requires_confirmation');
      final pending = await stack.bookings.list(BookingGroup.pending);
      expect(pending.items, hasLength(1));
    },
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'customer without documents must upload them before the quote',
    build: () => build(MockStack.inSwiftId),
    setUp: () async => stack.signInIn(),
    act: toReview,
    verify: (b) {
      expect(b.state.step, CheckoutStep.verification);
      expect(b.state.verificationRequired, isTrue);
      expect(b.state.steps, contains(CheckoutStep.verification));
      expect(b.state.quote, isNull);
    },
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'an expired quote is refreshed instead of booked',
    build: () {
      var now = testNow;
      final bloc = build(MockStack.aeEconomyId, clock: () => now);
      // Advance the bloc's clock past the 15-minute quote validity.
      addTearDown(() => now = testNow);
      Future<void>.delayed(const Duration(milliseconds: 15), () {
        now = testNow.add(const Duration(minutes: 16));
      });
      return bloc;
    },
    act: (b) async {
      await toReview(b);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      b.add(const CheckoutBookingRequested());
    },
    wait: const Duration(milliseconds: 40),
    verify: (b) {
      expect(b.state.creation, isNull);
      expect(b.state.failure?.code, ErrorCodes.quoteExpired);
    },
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'a car booked by someone else stops the checkout as unavailable',
    build: () => build(MockStack.aeEconomyId),
    act: (b) async {
      await toReview(b);
      // Another customer takes the car for overlapping dates.
      final other = MockStack();
      await other.signInAe();
      final quote = await stack.bookings.quote(
        QuoteRequest(
          vehicleId: MockStack.aeEconomyId,
          pickupAt: period.pickupAt,
          returnAt: period.returnAt,
        ),
      );
      await stack.bookings.create(
        quoteId: quote.id,
        driver: driver,
        idempotencyKey: 'someone-else',
      );
      b.add(const CheckoutBookingRequested());
    },
    wait: const Duration(milliseconds: 20),
    verify: (b) {
      expect(b.state.stop, CheckoutStop.vehicleUnavailable);
      expect(b.state.creation, isNull);
    },
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'invalid trip dates cannot be confirmed',
    build: () => build(MockStack.aeEconomyId),
    act: (b) async {
      b.add(
        CheckoutStarted(
          pickupAt: testNow.add(const Duration(hours: 1)),
          returnAt: testNow.add(const Duration(days: 2)),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      b.add(const CheckoutTripConfirmed());
    },
    verify: (b) => expect(b.state.step, CheckoutStep.trip),
  );
}
