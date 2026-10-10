import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/money/money.dart';
import 'enums.dart';
import 'vehicle.dart';

part 'pricing.freezed.dart';
part 'pricing.g.dart';

/// Known line-item codes. Labels always come from the backend.
abstract final class LineItemCodes {
  static const rentalFee = 'rental_fee';
  static const discount = 'discount';
  static const deliveryFee = 'delivery_fee';
  static const platformFee = 'platform_fee';
  static const tax = 'tax';
}

@freezed
abstract class LineItem with _$LineItem {
  const factory LineItem({
    required String code,
    required String label,
    required Money amount,
  }) = _LineItem;

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
}

/// A charge that applies only if something happens (e.g. excess mileage).
@freezed
abstract class ConditionalCharge with _$ConditionalCharge {
  const factory ConditionalCharge({
    required String code,
    required String label,
    required Money amount,
    String? unit,
  }) = _ConditionalCharge;

  factory ConditionalCharge.fromJson(Map<String, dynamic> json) =>
      _$ConditionalChargeFromJson(json);
}

@freezed
abstract class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String vehicleId,
    required DateTime pickupAt,
    required DateTime returnAt,
    required int days,
    required List<LineItem> lineItems,
    required Money total,
    required Money deposit,
    @Default(<ConditionalCharge>[]) List<ConditionalCharge> conditionalCharges,
    required PolicyInfo cancellationPolicy,
    @JsonKey(unknownEnumValue: BookingMode.unknown)
    required BookingMode bookingMode,
    required DateTime expiresAt,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

@freezed
abstract class PaymentIntent with _$PaymentIntent {
  const factory PaymentIntent({
    required String provider,
    required String intentId,
    String? clientSecret,
    required Money amount,
    required String status,
  }) = _PaymentIntent;

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);
}

@freezed
abstract class CancellationPreview with _$CancellationPreview {
  const factory CancellationPreview({
    required bool eligible,
    @Default(false) bool free,
    required Money fee,
    required Money refund,
    String? reason,
  }) = _CancellationPreview;

  factory CancellationPreview.fromJson(Map<String, dynamic> json) =>
      _$CancellationPreviewFromJson(json);
}
