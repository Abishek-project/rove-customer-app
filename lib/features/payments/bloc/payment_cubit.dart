import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/api_failure.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/pricing.dart';
import '../../../shared/repositories/payment_repository.dart';

enum PaymentFlowStatus { idle, processing, succeeded, declined, failed }

class PaymentState extends Equatable {
  const PaymentState({
    required this.bookingId,
    required this.intent,
    this.status = PaymentFlowStatus.idle,
    this.booking,
    this.failure,
    this.method,
    this.simulateDecline = false,
    this.idempotencyKey,
  });

  final String bookingId;
  final PaymentIntent intent;
  final PaymentFlowStatus status;

  /// The booking as the backend returned it after the attempt.
  final Booking? booking;
  final ApiFailure? failure;
  final String? method;
  final bool simulateDecline;
  final String? idempotencyKey;

  bool get isMockProvider => intent.provider == 'mock';

  PaymentState copyWith({
    PaymentFlowStatus? status,
    Booking? Function()? booking,
    ApiFailure? Function()? failure,
    String? method,
    bool? simulateDecline,
    String? Function()? idempotencyKey,
  }) => PaymentState(
    bookingId: bookingId,
    intent: intent,
    status: status ?? this.status,
    booking: booking != null ? booking() : this.booking,
    failure: failure != null ? failure() : this.failure,
    method: method ?? this.method,
    simulateDecline: simulateDecline ?? this.simulateDecline,
    idempotencyKey: idempotencyKey != null
        ? idempotencyKey()
        : this.idempotencyKey,
  );

  @override
  List<Object?> get props => [
    bookingId,
    intent,
    status,
    booking,
    failure,
    method,
    simulateDecline,
    idempotencyKey,
  ];
}

/// Confirms a payment intent with the backend. The outcome shown to the
/// customer is always the booking the backend returns — never the fact
/// that confirm was called.
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required PaymentRepository repository,
    required String bookingId,
    required PaymentIntent intent,
    String? defaultMethod,
    Uuid? uuid,
  }) : _repository = repository,
       _uuid = uuid ?? const Uuid(),
       super(
         PaymentState(
           bookingId: bookingId,
           intent: intent,
           method: defaultMethod,
         ),
       );

  final PaymentRepository _repository;
  final Uuid _uuid;

  void selectMethod(String method) => emit(state.copyWith(method: method));

  void setSimulateDecline(bool value) =>
      emit(state.copyWith(simulateDecline: value));

  Future<void> confirm() async {
    if (state.status == PaymentFlowStatus.processing) return;
    // Reuse the key only when the previous attempt's outcome is unknown
    // (network failure); a definite decline starts a new attempt.
    final key =
        state.status == PaymentFlowStatus.failed &&
            (state.failure?.isNetwork ?? false)
        ? (state.idempotencyKey ?? _uuid.v4())
        : _uuid.v4();
    emit(
      state.copyWith(
        status: PaymentFlowStatus.processing,
        failure: () => null,
        idempotencyKey: () => key,
      ),
    );
    try {
      final booking = await _repository.confirm(
        bookingId: state.bookingId,
        intentId: state.intent.intentId,
        idempotencyKey: key,
        simulateOutcome: state.isMockProvider && state.simulateDecline
            ? SimulatedOutcome.fail
            : null,
      );
      emit(
        state.copyWith(
          status: PaymentFlowStatus.succeeded,
          booking: () => booking,
        ),
      );
    } on PaymentDeclined catch (d) {
      emit(
        state.copyWith(
          status: PaymentFlowStatus.declined,
          booking: () => d.booking,
          failure: () => d.failure,
        ),
      );
    } on ApiFailure catch (f) {
      emit(state.copyWith(status: PaymentFlowStatus.failed, failure: () => f));
    }
  }
}
