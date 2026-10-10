// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingVehicleRef _$BookingVehicleRefFromJson(Map<String, dynamic> json) =>
    _BookingVehicleRef(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      coverImageUrl: json['coverImageUrl'] as String?,
    );

Map<String, dynamic> _$BookingVehicleRefToJson(_BookingVehicleRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'coverImageUrl': ?instance.coverImageUrl,
    };

_BookingPartnerRef _$BookingPartnerRefFromJson(Map<String, dynamic> json) =>
    _BookingPartnerRef(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$BookingPartnerRefToJson(_BookingPartnerRef instance) =>
    <String, dynamic>{'id': instance.id, 'displayName': instance.displayName};

_BookingSummary _$BookingSummaryFromJson(
  Map<String, dynamic> json,
) => _BookingSummary(
  id: json['id'] as String,
  reference: json['reference'] as String,
  status: $enumDecode(
    _$BookingStatusEnumMap,
    json['status'],
    unknownValue: BookingStatus.unknown,
  ),
  paymentStatus: $enumDecode(
    _$PaymentStatusEnumMap,
    json['paymentStatus'],
    unknownValue: PaymentStatus.unknown,
  ),
  pickupAt: DateTime.parse(json['pickupAt'] as String),
  returnAt: DateTime.parse(json['returnAt'] as String),
  total: Money.fromJson(json['total'] as Map<String, dynamic>),
  vehicle: BookingVehicleRef.fromJson(json['vehicle'] as Map<String, dynamic>),
  partner: BookingPartnerRef.fromJson(json['partner'] as Map<String, dynamic>),
  city: CityRef.fromJson(json['city'] as Map<String, dynamic>),
  timezone: json['timezone'] as String,
);

Map<String, dynamic> _$BookingSummaryToJson(_BookingSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'pickupAt': instance.pickupAt.toIso8601String(),
      'returnAt': instance.returnAt.toIso8601String(),
      'total': instance.total.toJson(),
      'vehicle': instance.vehicle.toJson(),
      'partner': instance.partner.toJson(),
      'city': instance.city.toJson(),
      'timezone': instance.timezone,
    };

const _$BookingStatusEnumMap = {
  BookingStatus.held: 'held',
  BookingStatus.pendingPartner: 'pending_partner',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.active: 'active',
  BookingStatus.completed: 'completed',
  BookingStatus.rejected: 'rejected',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.expired: 'expired',
  BookingStatus.unknown: 'unknown',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.unpaid: 'unpaid',
  PaymentStatus.authorized: 'authorized',
  PaymentStatus.captured: 'captured',
  PaymentStatus.partiallyRefunded: 'partially_refunded',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.failed: 'failed',
  PaymentStatus.voided: 'voided',
  PaymentStatus.unknown: 'unknown',
};

_DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) =>
    _DeliveryInfo(
      enabled: json['enabled'] as bool? ?? false,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$DeliveryInfoToJson(_DeliveryInfo instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'address': ?instance.address,
    };

_DriverInfo _$DriverInfoFromJson(Map<String, dynamic> json) => _DriverInfo(
  fullName: json['fullName'] as String,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$DriverInfoToJson(_DriverInfo instance) =>
    <String, dynamic>{'fullName': instance.fullName, 'phone': ?instance.phone};

_DamageNote _$DamageNoteFromJson(Map<String, dynamic> json) => _DamageNote(
  area: json['area'] as String?,
  severity: json['severity'] as String?,
  description: json['description'] as String?,
  isNew: json['isNew'] as bool? ?? false,
);

Map<String, dynamic> _$DamageNoteToJson(_DamageNote instance) =>
    <String, dynamic>{
      'area': ?instance.area,
      'severity': ?instance.severity,
      'description': ?instance.description,
      'isNew': instance.isNew,
    };

_ConditionReportSummary _$ConditionReportSummaryFromJson(
  Map<String, dynamic> json,
) => _ConditionReportSummary(
  recordedAt: DateTime.parse(json['recordedAt'] as String),
  odometerKm: (json['odometerKm'] as num?)?.toInt(),
  fuelLevelPct: (json['fuelLevelPct'] as num?)?.toInt(),
  damages:
      (json['damages'] as List<dynamic>?)
          ?.map((e) => DamageNote.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DamageNote>[],
  photoCount: (json['photoCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ConditionReportSummaryToJson(
  _ConditionReportSummary instance,
) => <String, dynamic>{
  'recordedAt': instance.recordedAt.toIso8601String(),
  'odometerKm': ?instance.odometerKm,
  'fuelLevelPct': ?instance.fuelLevelPct,
  'damages': instance.damages.map((e) => e.toJson()).toList(),
  'photoCount': instance.photoCount,
};

_BookingEvent _$BookingEventFromJson(Map<String, dynamic> json) =>
    _BookingEvent(
      type: json['type'] as String,
      toStatus: $enumDecodeNullable(
        _$BookingStatusEnumMap,
        json['toStatus'],
        unknownValue: BookingStatus.unknown,
      ),
      at: DateTime.parse(json['at'] as String),
      actorRole: json['actorRole'] as String?,
    );

Map<String, dynamic> _$BookingEventToJson(_BookingEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'toStatus': ?_$BookingStatusEnumMap[instance.toStatus],
      'at': instance.at.toIso8601String(),
      'actorRole': ?instance.actorRole,
    };

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: json['id'] as String,
  reference: json['reference'] as String,
  status: $enumDecode(
    _$BookingStatusEnumMap,
    json['status'],
    unknownValue: BookingStatus.unknown,
  ),
  paymentStatus: $enumDecode(
    _$PaymentStatusEnumMap,
    json['paymentStatus'],
    unknownValue: PaymentStatus.unknown,
  ),
  pickupAt: DateTime.parse(json['pickupAt'] as String),
  returnAt: DateTime.parse(json['returnAt'] as String),
  total: Money.fromJson(json['total'] as Map<String, dynamic>),
  vehicle: BookingVehicleRef.fromJson(json['vehicle'] as Map<String, dynamic>),
  partner: BookingPartnerRef.fromJson(json['partner'] as Map<String, dynamic>),
  city: CityRef.fromJson(json['city'] as Map<String, dynamic>),
  timezone: json['timezone'] as String,
  days: (json['days'] as num).toInt(),
  bookingMode: $enumDecode(
    _$BookingModeEnumMap,
    json['bookingMode'],
    unknownValue: BookingMode.unknown,
  ),
  depositStatus: $enumDecode(
    _$DepositStatusEnumMap,
    json['depositStatus'],
    unknownValue: DepositStatus.unknown,
  ),
  delivery: json['delivery'] == null
      ? const DeliveryInfo()
      : DeliveryInfo.fromJson(json['delivery'] as Map<String, dynamic>),
  pickupLocation: json['pickupLocation'] == null
      ? null
      : PickupLocation.fromJson(json['pickupLocation'] as Map<String, dynamic>),
  lineItems:
      (json['lineItems'] as List<dynamic>?)
          ?.map((e) => LineItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LineItem>[],
  deposit: Money.fromJson(json['deposit'] as Map<String, dynamic>),
  conditionalCharges:
      (json['conditionalCharges'] as List<dynamic>?)
          ?.map((e) => ConditionalCharge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ConditionalCharge>[],
  cancellationPolicy: json['cancellationPolicy'] == null
      ? null
      : PolicyInfo.fromJson(json['cancellationPolicy'] as Map<String, dynamic>),
  cancellationFee: json['cancellationFee'] == null
      ? null
      : Money.fromJson(json['cancellationFee'] as Map<String, dynamic>),
  refund: json['refund'] == null
      ? null
      : Money.fromJson(json['refund'] as Map<String, dynamic>),
  holdExpiresAt: json['holdExpiresAt'] == null
      ? null
      : DateTime.parse(json['holdExpiresAt'] as String),
  partnerResponseDueAt: json['partnerResponseDueAt'] == null
      ? null
      : DateTime.parse(json['partnerResponseDueAt'] as String),
  driver: json['driver'] == null
      ? null
      : DriverInfo.fromJson(json['driver'] as Map<String, dynamic>),
  pickupInstructions: json['pickupInstructions'] as String?,
  returnInstructions: json['returnInstructions'] as String?,
  requiredDocuments:
      (json['requiredDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  pickupReport: json['pickupReport'] == null
      ? null
      : ConditionReportSummary.fromJson(
          json['pickupReport'] as Map<String, dynamic>,
        ),
  returnReport: json['returnReport'] == null
      ? null
      : ConditionReportSummary.fromJson(
          json['returnReport'] as Map<String, dynamic>,
        ),
  events:
      (json['events'] as List<dynamic>?)
          ?.map((e) => BookingEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <BookingEvent>[],
  allowedActions:
      (json['allowedActions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  payment: json['payment'] == null
      ? null
      : PaymentIntent.fromJson(json['payment'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'reference': instance.reference,
  'status': _$BookingStatusEnumMap[instance.status]!,
  'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
  'pickupAt': instance.pickupAt.toIso8601String(),
  'returnAt': instance.returnAt.toIso8601String(),
  'total': instance.total.toJson(),
  'vehicle': instance.vehicle.toJson(),
  'partner': instance.partner.toJson(),
  'city': instance.city.toJson(),
  'timezone': instance.timezone,
  'days': instance.days,
  'bookingMode': _$BookingModeEnumMap[instance.bookingMode]!,
  'depositStatus': _$DepositStatusEnumMap[instance.depositStatus]!,
  'delivery': instance.delivery.toJson(),
  'pickupLocation': ?instance.pickupLocation?.toJson(),
  'lineItems': instance.lineItems.map((e) => e.toJson()).toList(),
  'deposit': instance.deposit.toJson(),
  'conditionalCharges': instance.conditionalCharges
      .map((e) => e.toJson())
      .toList(),
  'cancellationPolicy': ?instance.cancellationPolicy?.toJson(),
  'cancellationFee': ?instance.cancellationFee?.toJson(),
  'refund': ?instance.refund?.toJson(),
  'holdExpiresAt': ?instance.holdExpiresAt?.toIso8601String(),
  'partnerResponseDueAt': ?instance.partnerResponseDueAt?.toIso8601String(),
  'driver': ?instance.driver?.toJson(),
  'pickupInstructions': ?instance.pickupInstructions,
  'returnInstructions': ?instance.returnInstructions,
  'requiredDocuments': instance.requiredDocuments,
  'pickupReport': ?instance.pickupReport?.toJson(),
  'returnReport': ?instance.returnReport?.toJson(),
  'events': instance.events.map((e) => e.toJson()).toList(),
  'allowedActions': instance.allowedActions,
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'payment': ?instance.payment?.toJson(),
};

const _$BookingModeEnumMap = {
  BookingMode.instant: 'instant',
  BookingMode.request: 'request',
  BookingMode.unknown: 'unknown',
};

const _$DepositStatusEnumMap = {
  DepositStatus.notHeld: 'not_held',
  DepositStatus.held: 'held',
  DepositStatus.released: 'released',
  DepositStatus.partiallyReleased: 'partially_released',
  DepositStatus.unknown: 'unknown',
};

_BookingCreation _$BookingCreationFromJson(Map<String, dynamic> json) =>
    _BookingCreation(
      booking: Booking.fromJson(json['booking'] as Map<String, dynamic>),
      payment: PaymentIntent.fromJson(json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingCreationToJson(_BookingCreation instance) =>
    <String, dynamic>{
      'booking': instance.booking.toJson(),
      'payment': instance.payment.toJson(),
    };
