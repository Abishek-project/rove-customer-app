import 'package:equatable/equatable.dart';

import '../../../core/errors/api_failure.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/pricing.dart';

enum ResultKind {
  confirmed,
  pending,
  held,
  declined,
  expired,
  rejected,
  cancelled,
  unavailable,
  unknown,
}

/// What the result screen shows, derived only from what the backend
/// returned (a booking and/or a failure) — never from the fact that the
/// customer tapped "Pay".
class CheckoutResult extends Equatable {
  const CheckoutResult({this.booking, this.intent, this.failure});

  final Booking? booking;

  /// The open payment intent, kept so payment can be retried.
  final PaymentIntent? intent;
  final ApiFailure? failure;

  ResultKind get kind => resolveResultKind(booking, failure);

  PaymentIntent? get retryIntent => intent ?? booking?.payment;

  CheckoutResult copyWith({
    Booking? booking,
    PaymentIntent? intent,
    ApiFailure? Function()? failure,
  }) => CheckoutResult(
    booking: booking ?? this.booking,
    intent: intent ?? this.intent,
    failure: failure != null ? failure() : this.failure,
  );

  @override
  List<Object?> get props => [booking, intent, failure];
}

ResultKind resolveResultKind(Booking? booking, ApiFailure? failure) {
  if (booking == null) {
    return switch (failure?.code) {
      ErrorCodes.vehicleUnavailable => ResultKind.unavailable,
      ErrorCodes.holdExpired => ResultKind.expired,
      _ => ResultKind.unknown,
    };
  }
  if (failure?.code == ErrorCodes.holdExpired) return ResultKind.expired;
  return switch (booking.status) {
    BookingStatus.confirmed ||
    BookingStatus.active ||
    BookingStatus.completed => ResultKind.confirmed,
    BookingStatus.pendingPartner => ResultKind.pending,
    BookingStatus.held =>
      booking.paymentStatus == PaymentStatus.failed
          ? ResultKind.declined
          : ResultKind.held,
    BookingStatus.expired => ResultKind.expired,
    BookingStatus.rejected => ResultKind.rejected,
    BookingStatus.cancelled => ResultKind.cancelled,
    BookingStatus.unknown => ResultKind.unknown,
  };
}
