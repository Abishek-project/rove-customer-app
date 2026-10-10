import 'package:json_annotation/json_annotation.dart';

// Enum wire values are lowercase snake_case and identical across all Rove
// projects (CONTRACTS §10). `unknown` absorbs values added later.

@JsonEnum(fieldRename: FieldRename.snake)
enum VehicleCategory { economy, suv, sedan, luxury, electric, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum Transmission { automatic, manual, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum FuelType { petrol, diesel, hybrid, electric, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum FuelPolicy { fullToFull, sameToSame, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum BookingMode { instant, request, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum BookingStatus {
  held,
  pendingPartner,
  confirmed,
  active,
  completed,
  rejected,
  cancelled,
  expired,
  unknown,
}

@JsonEnum(fieldRename: FieldRename.snake)
enum PaymentStatus {
  unpaid,
  authorized,
  captured,
  partiallyRefunded,
  refunded,
  failed,
  voided,
  unknown,
}

@JsonEnum(fieldRename: FieldRename.snake)
enum DepositStatus { notHeld, held, released, partiallyReleased, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum VerificationStatus { notStarted, submitted, verified, rejected, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum DocumentStatus { missing, submitted, approved, rejected, expired, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum SupportStatus { open, inProgress, resolved, unknown }

/// `GET /bookings?group=` values.
enum BookingGroup { upcoming, pending, active, completed, cancelled }

enum VehicleSort {
  relevance('relevance'),
  priceAsc('price_asc'),
  priceDesc('price_desc'),
  category('category');

  const VehicleSort(this.wire);
  final String wire;
}

/// Customer `allowedActions` (CONTRACTS §6).
abstract final class CustomerActions {
  static const pay = 'pay';
  static const cancel = 'cancel';
  static const contactSupport = 'contact_support';
}

extension BookingStatusX on BookingStatus {
  bool get isTerminal => switch (this) {
    BookingStatus.completed ||
    BookingStatus.rejected ||
    BookingStatus.cancelled ||
    BookingStatus.expired => true,
    _ => false,
  };

  /// The group a booking with this status is listed under.
  BookingGroup get group => switch (this) {
    BookingStatus.held || BookingStatus.pendingPartner => BookingGroup.pending,
    BookingStatus.confirmed => BookingGroup.upcoming,
    BookingStatus.active => BookingGroup.active,
    BookingStatus.completed => BookingGroup.completed,
    _ => BookingGroup.cancelled,
  };
}

extension VehicleCategoryWire on VehicleCategory {
  String get wire => switch (this) {
    VehicleCategory.economy => 'economy',
    VehicleCategory.suv => 'suv',
    VehicleCategory.sedan => 'sedan',
    VehicleCategory.luxury => 'luxury',
    VehicleCategory.electric => 'electric',
    VehicleCategory.unknown => 'unknown',
  };

  static const browsable = [
    VehicleCategory.economy,
    VehicleCategory.suv,
    VehicleCategory.sedan,
    VehicleCategory.luxury,
    VehicleCategory.electric,
  ];
}

extension TransmissionWire on Transmission {
  String get wire => name;
}

extension FuelTypeWire on FuelType {
  String get wire => name;
}
