import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/money/money.dart';
import 'enums.dart';
import 'pricing.dart';
import 'reference.dart';
import 'vehicle.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
abstract class BookingVehicleRef with _$BookingVehicleRef {
  const BookingVehicleRef._();

  const factory BookingVehicleRef({
    required String id,
    required String make,
    required String model,
    required int year,
    String? coverImageUrl,
  }) = _BookingVehicleRef;

  factory BookingVehicleRef.fromJson(Map<String, dynamic> json) =>
      _$BookingVehicleRefFromJson(json);

  String get title => '$make $model';
}

@freezed
abstract class BookingPartnerRef with _$BookingPartnerRef {
  const factory BookingPartnerRef({
    required String id,
    required String displayName,
  }) = _BookingPartnerRef;

  factory BookingPartnerRef.fromJson(Map<String, dynamic> json) =>
      _$BookingPartnerRefFromJson(json);
}

@freezed
abstract class BookingSummary with _$BookingSummary {
  const factory BookingSummary({
    required String id,
    required String reference,
    @JsonKey(unknownEnumValue: BookingStatus.unknown)
    required BookingStatus status,
    @JsonKey(unknownEnumValue: PaymentStatus.unknown)
    required PaymentStatus paymentStatus,
    required DateTime pickupAt,
    required DateTime returnAt,
    required Money total,
    required BookingVehicleRef vehicle,
    required BookingPartnerRef partner,
    required CityRef city,
    required String timezone,
  }) = _BookingSummary;

  factory BookingSummary.fromJson(Map<String, dynamic> json) =>
      _$BookingSummaryFromJson(json);
}

@freezed
abstract class DeliveryInfo with _$DeliveryInfo {
  const factory DeliveryInfo({@Default(false) bool enabled, String? address}) =
      _DeliveryInfo;

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) =>
      _$DeliveryInfoFromJson(json);
}

@freezed
abstract class DriverInfo with _$DriverInfo {
  const factory DriverInfo({required String fullName, String? phone}) =
      _DriverInfo;

  factory DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoFromJson(json);
}

@freezed
abstract class DamageNote with _$DamageNote {
  const factory DamageNote({
    String? area,
    String? severity,
    String? description,
    @Default(false) bool isNew,
  }) = _DamageNote;

  factory DamageNote.fromJson(Map<String, dynamic> json) =>
      _$DamageNoteFromJson(json);
}

@freezed
abstract class ConditionReportSummary with _$ConditionReportSummary {
  const factory ConditionReportSummary({
    required DateTime recordedAt,
    int? odometerKm,
    int? fuelLevelPct,
    @Default(<DamageNote>[]) List<DamageNote> damages,
    @Default(0) int photoCount,
  }) = _ConditionReportSummary;

  factory ConditionReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ConditionReportSummaryFromJson(json);
}

@freezed
abstract class BookingEvent with _$BookingEvent {
  const factory BookingEvent({
    required String type,
    @JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus? toStatus,
    required DateTime at,
    String? actorRole,
  }) = _BookingEvent;

  factory BookingEvent.fromJson(Map<String, dynamic> json) =>
      _$BookingEventFromJson(json);
}

@freezed
abstract class Booking with _$Booking {
  const Booking._();

  const factory Booking({
    required String id,
    required String reference,
    @JsonKey(unknownEnumValue: BookingStatus.unknown)
    required BookingStatus status,
    @JsonKey(unknownEnumValue: PaymentStatus.unknown)
    required PaymentStatus paymentStatus,
    required DateTime pickupAt,
    required DateTime returnAt,
    required Money total,
    required BookingVehicleRef vehicle,
    required BookingPartnerRef partner,
    required CityRef city,
    required String timezone,
    required int days,
    @JsonKey(unknownEnumValue: BookingMode.unknown)
    required BookingMode bookingMode,
    @JsonKey(unknownEnumValue: DepositStatus.unknown)
    required DepositStatus depositStatus,
    @Default(DeliveryInfo()) DeliveryInfo delivery,
    PickupLocation? pickupLocation,
    @Default(<LineItem>[]) List<LineItem> lineItems,
    required Money deposit,
    @Default(<ConditionalCharge>[]) List<ConditionalCharge> conditionalCharges,
    PolicyInfo? cancellationPolicy,
    Money? cancellationFee,
    Money? refund,
    DateTime? holdExpiresAt,
    DateTime? partnerResponseDueAt,
    DriverInfo? driver,
    String? pickupInstructions,
    String? returnInstructions,
    @Default(<String>[]) List<String> requiredDocuments,
    ConditionReportSummary? pickupReport,
    ConditionReportSummary? returnReport,
    @Default(<BookingEvent>[]) List<BookingEvent> events,
    @Default(<String>[]) List<String> allowedActions,
    DateTime? createdAt,
    // CONTRACT-ASSUMPTION: an optional open payment intent on held bookings
    // so "pay" can resume from booking details (contract-requests.md).
    PaymentIntent? payment,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  bool can(String action) => allowedActions.contains(action);

  BookingSummary toSummary() => BookingSummary(
    id: id,
    reference: reference,
    status: status,
    paymentStatus: paymentStatus,
    pickupAt: pickupAt,
    returnAt: returnAt,
    total: total,
    vehicle: vehicle,
    partner: partner,
    city: city,
    timezone: timezone,
  );
}

/// `POST /bookings` response.
@freezed
abstract class BookingCreation with _$BookingCreation {
  const factory BookingCreation({
    required Booking booking,
    required PaymentIntent payment,
  }) = _BookingCreation;

  factory BookingCreation.fromJson(Map<String, dynamic> json) =>
      _$BookingCreationFromJson(json);
}
