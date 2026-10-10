import '../../core/errors/api_failure.dart';
import '../models/booking.dart';

/// The provider declined the payment (`402 PAYMENT_FAILED`). The booking in
/// [booking] is the authoritative state after the attempt.
class PaymentDeclined implements Exception {
  const PaymentDeclined(this.failure, this.booking);
  final ApiFailure failure;
  final Booking? booking;
}

enum SimulatedOutcome { success, fail }

abstract interface class PaymentRepository {
  /// `POST /bookings/:id/payment/confirm`. Returns the booking as the backend
  /// sees it after verifying the intent with the provider. Throws
  /// [PaymentDeclined] on 402.
  Future<Booking> confirm({
    required String bookingId,
    required String intentId,
    required String idempotencyKey,
    SimulatedOutcome? simulateOutcome,
  });
}
