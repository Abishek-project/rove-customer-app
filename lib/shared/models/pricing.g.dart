// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LineItem _$LineItemFromJson(Map<String, dynamic> json) => _LineItem(
  code: json['code'] as String,
  label: json['label'] as String,
  amount: Money.fromJson(json['amount'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineItemToJson(_LineItem instance) => <String, dynamic>{
  'code': instance.code,
  'label': instance.label,
  'amount': instance.amount.toJson(),
};

_ConditionalCharge _$ConditionalChargeFromJson(Map<String, dynamic> json) =>
    _ConditionalCharge(
      code: json['code'] as String,
      label: json['label'] as String,
      amount: Money.fromJson(json['amount'] as Map<String, dynamic>),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$ConditionalChargeToJson(_ConditionalCharge instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'amount': instance.amount.toJson(),
      'unit': ?instance.unit,
    };

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
  id: json['id'] as String,
  vehicleId: json['vehicleId'] as String,
  pickupAt: DateTime.parse(json['pickupAt'] as String),
  returnAt: DateTime.parse(json['returnAt'] as String),
  days: (json['days'] as num).toInt(),
  lineItems: (json['lineItems'] as List<dynamic>)
      .map((e) => LineItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: Money.fromJson(json['total'] as Map<String, dynamic>),
  deposit: Money.fromJson(json['deposit'] as Map<String, dynamic>),
  conditionalCharges:
      (json['conditionalCharges'] as List<dynamic>?)
          ?.map((e) => ConditionalCharge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ConditionalCharge>[],
  cancellationPolicy: PolicyInfo.fromJson(
    json['cancellationPolicy'] as Map<String, dynamic>,
  ),
  bookingMode: $enumDecode(
    _$BookingModeEnumMap,
    json['bookingMode'],
    unknownValue: BookingMode.unknown,
  ),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
  'id': instance.id,
  'vehicleId': instance.vehicleId,
  'pickupAt': instance.pickupAt.toIso8601String(),
  'returnAt': instance.returnAt.toIso8601String(),
  'days': instance.days,
  'lineItems': instance.lineItems.map((e) => e.toJson()).toList(),
  'total': instance.total.toJson(),
  'deposit': instance.deposit.toJson(),
  'conditionalCharges': instance.conditionalCharges
      .map((e) => e.toJson())
      .toList(),
  'cancellationPolicy': instance.cancellationPolicy.toJson(),
  'bookingMode': _$BookingModeEnumMap[instance.bookingMode]!,
  'expiresAt': instance.expiresAt.toIso8601String(),
};

const _$BookingModeEnumMap = {
  BookingMode.instant: 'instant',
  BookingMode.request: 'request',
  BookingMode.unknown: 'unknown',
};

_PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    _PaymentIntent(
      provider: json['provider'] as String,
      intentId: json['intentId'] as String,
      clientSecret: json['clientSecret'] as String?,
      amount: Money.fromJson(json['amount'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentIntentToJson(_PaymentIntent instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'intentId': instance.intentId,
      'clientSecret': ?instance.clientSecret,
      'amount': instance.amount.toJson(),
      'status': instance.status,
    };

_CancellationPreview _$CancellationPreviewFromJson(Map<String, dynamic> json) =>
    _CancellationPreview(
      eligible: json['eligible'] as bool,
      free: json['free'] as bool? ?? false,
      fee: Money.fromJson(json['fee'] as Map<String, dynamic>),
      refund: Money.fromJson(json['refund'] as Map<String, dynamic>),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$CancellationPreviewToJson(
  _CancellationPreview instance,
) => <String, dynamic>{
  'eligible': instance.eligible,
  'free': instance.free,
  'fee': instance.fee.toJson(),
  'refund': instance.refund.toJson(),
  'reason': ?instance.reason,
};
