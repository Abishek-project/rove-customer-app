import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/money/money.dart';
import 'enums.dart';
import 'reference.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

@freezed
abstract class PartnerRef with _$PartnerRef {
  const factory PartnerRef({
    required String id,
    required String displayName,
    @Default(false) bool verified,
    String? cityName,
    String? logoUrl,
  }) = _PartnerRef;

  factory PartnerRef.fromJson(Map<String, dynamic> json) =>
      _$PartnerRefFromJson(json);
}

@freezed
abstract class VehicleSummary with _$VehicleSummary {
  const VehicleSummary._();

  const factory VehicleSummary({
    required String id,
    required String make,
    required String model,
    required int year,
    @JsonKey(unknownEnumValue: VehicleCategory.unknown)
    required VehicleCategory category,
    @JsonKey(unknownEnumValue: Transmission.unknown)
    required Transmission transmission,
    @JsonKey(unknownEnumValue: FuelType.unknown) required FuelType fuelType,
    required int seats,
    @Default(0) int luggage,
    String? coverImageUrl,
    required Money dailyRate,
    Money? estimatedTotal,
    int? days,
    required CityRef city,
    @Default(false) bool deliveryAvailable,
    required PartnerRef partner,
    @Default(false) bool isFavorite,
  }) = _VehicleSummary;

  factory VehicleSummary.fromJson(Map<String, dynamic> json) =>
      _$VehicleSummaryFromJson(json);

  String get title => '$make $model';
}

@freezed
abstract class VehicleImage with _$VehicleImage {
  const factory VehicleImage({
    required String id,
    required String url,
    @Default(false) bool isCover,
    @Default(0) int sortOrder,
  }) = _VehicleImage;

  factory VehicleImage.fromJson(Map<String, dynamic> json) =>
      _$VehicleImageFromJson(json);
}

@freezed
abstract class MileagePolicy with _$MileagePolicy {
  const factory MileagePolicy({
    int? limitKmPerDay,
    required Money excessFeePerKm,
  }) = _MileagePolicy;

  factory MileagePolicy.fromJson(Map<String, dynamic> json) =>
      _$MileagePolicyFromJson(json);
}

/// `{ code, summary }` — used for the cancellation policy.
@freezed
abstract class PolicyInfo with _$PolicyInfo {
  const factory PolicyInfo({required String code, required String summary}) =
      _PolicyInfo;

  factory PolicyInfo.fromJson(Map<String, dynamic> json) =>
      _$PolicyInfoFromJson(json);
}

@freezed
abstract class AvailabilityInfo with _$AvailabilityInfo {
  const factory AvailabilityInfo({
    @Default(false) bool checked,
    bool? available,
  }) = _AvailabilityInfo;

  factory AvailabilityInfo.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityInfoFromJson(json);
}

@freezed
abstract class VehicleDetail with _$VehicleDetail {
  const VehicleDetail._();

  const factory VehicleDetail({
    required String id,
    required String make,
    required String model,
    required int year,
    @JsonKey(unknownEnumValue: VehicleCategory.unknown)
    required VehicleCategory category,
    @JsonKey(unknownEnumValue: Transmission.unknown)
    required Transmission transmission,
    @JsonKey(unknownEnumValue: FuelType.unknown) required FuelType fuelType,
    required int seats,
    @Default(0) int luggage,
    String? coverImageUrl,
    required Money dailyRate,
    Money? estimatedTotal,
    int? days,
    required CityRef city,
    @Default(false) bool deliveryAvailable,
    required PartnerRef partner,
    @Default(false) bool isFavorite,
    @Default(<VehicleImage>[]) List<VehicleImage> images,
    int? doors,
    String? color,
    String? description,
    @Default(<String>[]) List<String> features,
    required String timezone,
    PickupLocation? pickupLocation,
    required Money deliveryFee,
    required MileagePolicy mileagePolicy,
    @JsonKey(unknownEnumValue: FuelPolicy.unknown)
    required FuelPolicy fuelPolicy,
    required Money deposit,
    required PolicyInfo cancellationPolicy,
    String? insuranceInfo,
    @Default(1) int minRentalDays,
    @JsonKey(unknownEnumValue: BookingMode.unknown)
    required BookingMode bookingMode,
    @Default(AvailabilityInfo()) AvailabilityInfo availability,
  }) = _VehicleDetail;

  factory VehicleDetail.fromJson(Map<String, dynamic> json) =>
      _$VehicleDetailFromJson(json);

  String get title => '$make $model';

  /// Images in display order, cover first.
  List<VehicleImage> get orderedImages {
    final sorted = [...images]
      ..sort((a, b) {
        if (a.isCover != b.isCover) return a.isCover ? -1 : 1;
        return a.sortOrder.compareTo(b.sortOrder);
      });
    return sorted;
  }

  VehicleSummary toSummary() => VehicleSummary(
    id: id,
    make: make,
    model: model,
    year: year,
    category: category,
    transmission: transmission,
    fuelType: fuelType,
    seats: seats,
    luggage: luggage,
    coverImageUrl: coverImageUrl,
    dailyRate: dailyRate,
    estimatedTotal: estimatedTotal,
    days: days,
    city: city,
    deliveryAvailable: deliveryAvailable,
    partner: partner,
    isFavorite: isFavorite,
  );
}
