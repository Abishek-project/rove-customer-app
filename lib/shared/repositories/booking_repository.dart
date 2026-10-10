import 'package:equatable/equatable.dart';

import '../models/booking.dart';
import '../models/enums.dart';
import '../models/pricing.dart';
import '../models/reference.dart';

class QuoteRequest extends Equatable {
  const QuoteRequest({
    required this.vehicleId,
    required this.pickupAt,
    required this.returnAt,
    this.delivery = false,
    this.deliveryAddress,
  });

  final String vehicleId;
  final DateTime pickupAt;
  final DateTime returnAt;
  final bool delivery;
  final String? deliveryAddress;

  @override
  List<Object?> get props => [
    vehicleId,
    pickupAt,
    returnAt,
    delivery,
    deliveryAddress,
  ];
}

class DriverDetails extends Equatable {
  const DriverDetails({
    required this.fullName,
    required this.phone,
    required this.dateOfBirth,
  });

  final String fullName;
  final String phone;

  /// A calendar date (no time zone); sent as `YYYY-MM-DD`.
  final DateTime dateOfBirth;

  String get dateOfBirthIso =>
      '${dateOfBirth.year.toString().padLeft(4, '0')}-'
      '${dateOfBirth.month.toString().padLeft(2, '0')}-'
      '${dateOfBirth.day.toString().padLeft(2, '0')}';

  @override
  List<Object?> get props => [fullName, phone, dateOfBirth];
}

abstract interface class BookingRepository {
  /// `POST /bookings/quote` — the backend's price is the only price.
  Future<Quote> quote(QuoteRequest request);

  /// `POST /bookings` with an Idempotency-Key reused on retry.
  Future<BookingCreation> create({
    required String quoteId,
    required DriverDetails driver,
    required String idempotencyKey,
  });

  Future<Paged<BookingSummary>> list(BookingGroup group, {int page = 1});

  Future<Booking> get(String bookingId);

  Future<CancellationPreview> cancellationPreview(String bookingId);

  Future<Booking> cancel(
    String bookingId, {
    String? reason,
    required String idempotencyKey,
  });
}
