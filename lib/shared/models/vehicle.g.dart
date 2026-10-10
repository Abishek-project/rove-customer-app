// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnerRef _$PartnerRefFromJson(Map<String, dynamic> json) => _PartnerRef(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  verified: json['verified'] as bool? ?? false,
  cityName: json['cityName'] as String?,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$PartnerRefToJson(_PartnerRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'verified': instance.verified,
      'cityName': ?instance.cityName,
      'logoUrl': ?instance.logoUrl,
    };

_VehicleSummary _$VehicleSummaryFromJson(Map<String, dynamic> json) =>
    _VehicleSummary(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      category: $enumDecode(
        _$VehicleCategoryEnumMap,
        json['category'],
        unknownValue: VehicleCategory.unknown,
      ),
      transmission: $enumDecode(
        _$TransmissionEnumMap,
        json['transmission'],
        unknownValue: Transmission.unknown,
      ),
      fuelType: $enumDecode(
        _$FuelTypeEnumMap,
        json['fuelType'],
        unknownValue: FuelType.unknown,
      ),
      seats: (json['seats'] as num).toInt(),
      luggage: (json['luggage'] as num?)?.toInt() ?? 0,
      coverImageUrl: json['coverImageUrl'] as String?,
      dailyRate: Money.fromJson(json['dailyRate'] as Map<String, dynamic>),
      estimatedTotal: json['estimatedTotal'] == null
          ? null
          : Money.fromJson(json['estimatedTotal'] as Map<String, dynamic>),
      days: (json['days'] as num?)?.toInt(),
      city: CityRef.fromJson(json['city'] as Map<String, dynamic>),
      deliveryAvailable: json['deliveryAvailable'] as bool? ?? false,
      partner: PartnerRef.fromJson(json['partner'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$VehicleSummaryToJson(_VehicleSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'category': _$VehicleCategoryEnumMap[instance.category]!,
      'transmission': _$TransmissionEnumMap[instance.transmission]!,
      'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
      'seats': instance.seats,
      'luggage': instance.luggage,
      'coverImageUrl': ?instance.coverImageUrl,
      'dailyRate': instance.dailyRate.toJson(),
      'estimatedTotal': ?instance.estimatedTotal?.toJson(),
      'days': ?instance.days,
      'city': instance.city.toJson(),
      'deliveryAvailable': instance.deliveryAvailable,
      'partner': instance.partner.toJson(),
      'isFavorite': instance.isFavorite,
    };

const _$VehicleCategoryEnumMap = {
  VehicleCategory.economy: 'economy',
  VehicleCategory.suv: 'suv',
  VehicleCategory.sedan: 'sedan',
  VehicleCategory.luxury: 'luxury',
  VehicleCategory.electric: 'electric',
  VehicleCategory.unknown: 'unknown',
};

const _$TransmissionEnumMap = {
  Transmission.automatic: 'automatic',
  Transmission.manual: 'manual',
  Transmission.unknown: 'unknown',
};

const _$FuelTypeEnumMap = {
  FuelType.petrol: 'petrol',
  FuelType.diesel: 'diesel',
  FuelType.hybrid: 'hybrid',
  FuelType.electric: 'electric',
  FuelType.unknown: 'unknown',
};

_VehicleImage _$VehicleImageFromJson(Map<String, dynamic> json) =>
    _VehicleImage(
      id: json['id'] as String,
      url: json['url'] as String,
      isCover: json['isCover'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VehicleImageToJson(_VehicleImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'isCover': instance.isCover,
      'sortOrder': instance.sortOrder,
    };

_MileagePolicy _$MileagePolicyFromJson(Map<String, dynamic> json) =>
    _MileagePolicy(
      limitKmPerDay: (json['limitKmPerDay'] as num?)?.toInt(),
      excessFeePerKm: Money.fromJson(
        json['excessFeePerKm'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MileagePolicyToJson(_MileagePolicy instance) =>
    <String, dynamic>{
      'limitKmPerDay': ?instance.limitKmPerDay,
      'excessFeePerKm': instance.excessFeePerKm.toJson(),
    };

_PolicyInfo _$PolicyInfoFromJson(Map<String, dynamic> json) => _PolicyInfo(
  code: json['code'] as String,
  summary: json['summary'] as String,
);

Map<String, dynamic> _$PolicyInfoToJson(_PolicyInfo instance) =>
    <String, dynamic>{'code': instance.code, 'summary': instance.summary};

_AvailabilityInfo _$AvailabilityInfoFromJson(Map<String, dynamic> json) =>
    _AvailabilityInfo(
      checked: json['checked'] as bool? ?? false,
      available: json['available'] as bool?,
    );

Map<String, dynamic> _$AvailabilityInfoToJson(_AvailabilityInfo instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'available': ?instance.available,
    };

_VehicleDetail _$VehicleDetailFromJson(
  Map<String, dynamic> json,
) => _VehicleDetail(
  id: json['id'] as String,
  make: json['make'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  category: $enumDecode(
    _$VehicleCategoryEnumMap,
    json['category'],
    unknownValue: VehicleCategory.unknown,
  ),
  transmission: $enumDecode(
    _$TransmissionEnumMap,
    json['transmission'],
    unknownValue: Transmission.unknown,
  ),
  fuelType: $enumDecode(
    _$FuelTypeEnumMap,
    json['fuelType'],
    unknownValue: FuelType.unknown,
  ),
  seats: (json['seats'] as num).toInt(),
  luggage: (json['luggage'] as num?)?.toInt() ?? 0,
  coverImageUrl: json['coverImageUrl'] as String?,
  dailyRate: Money.fromJson(json['dailyRate'] as Map<String, dynamic>),
  estimatedTotal: json['estimatedTotal'] == null
      ? null
      : Money.fromJson(json['estimatedTotal'] as Map<String, dynamic>),
  days: (json['days'] as num?)?.toInt(),
  city: CityRef.fromJson(json['city'] as Map<String, dynamic>),
  deliveryAvailable: json['deliveryAvailable'] as bool? ?? false,
  partner: PartnerRef.fromJson(json['partner'] as Map<String, dynamic>),
  isFavorite: json['isFavorite'] as bool? ?? false,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => VehicleImage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <VehicleImage>[],
  doors: (json['doors'] as num?)?.toInt(),
  color: json['color'] as String?,
  description: json['description'] as String?,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  timezone: json['timezone'] as String,
  pickupLocation: json['pickupLocation'] == null
      ? null
      : PickupLocation.fromJson(json['pickupLocation'] as Map<String, dynamic>),
  deliveryFee: Money.fromJson(json['deliveryFee'] as Map<String, dynamic>),
  mileagePolicy: MileagePolicy.fromJson(
    json['mileagePolicy'] as Map<String, dynamic>,
  ),
  fuelPolicy: $enumDecode(
    _$FuelPolicyEnumMap,
    json['fuelPolicy'],
    unknownValue: FuelPolicy.unknown,
  ),
  deposit: Money.fromJson(json['deposit'] as Map<String, dynamic>),
  cancellationPolicy: PolicyInfo.fromJson(
    json['cancellationPolicy'] as Map<String, dynamic>,
  ),
  insuranceInfo: json['insuranceInfo'] as String?,
  minRentalDays: (json['minRentalDays'] as num?)?.toInt() ?? 1,
  bookingMode: $enumDecode(
    _$BookingModeEnumMap,
    json['bookingMode'],
    unknownValue: BookingMode.unknown,
  ),
  availability: json['availability'] == null
      ? const AvailabilityInfo()
      : AvailabilityInfo.fromJson(json['availability'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VehicleDetailToJson(_VehicleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'category': _$VehicleCategoryEnumMap[instance.category]!,
      'transmission': _$TransmissionEnumMap[instance.transmission]!,
      'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
      'seats': instance.seats,
      'luggage': instance.luggage,
      'coverImageUrl': ?instance.coverImageUrl,
      'dailyRate': instance.dailyRate.toJson(),
      'estimatedTotal': ?instance.estimatedTotal?.toJson(),
      'days': ?instance.days,
      'city': instance.city.toJson(),
      'deliveryAvailable': instance.deliveryAvailable,
      'partner': instance.partner.toJson(),
      'isFavorite': instance.isFavorite,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'doors': ?instance.doors,
      'color': ?instance.color,
      'description': ?instance.description,
      'features': instance.features,
      'timezone': instance.timezone,
      'pickupLocation': ?instance.pickupLocation?.toJson(),
      'deliveryFee': instance.deliveryFee.toJson(),
      'mileagePolicy': instance.mileagePolicy.toJson(),
      'fuelPolicy': _$FuelPolicyEnumMap[instance.fuelPolicy]!,
      'deposit': instance.deposit.toJson(),
      'cancellationPolicy': instance.cancellationPolicy.toJson(),
      'insuranceInfo': ?instance.insuranceInfo,
      'minRentalDays': instance.minRentalDays,
      'bookingMode': _$BookingModeEnumMap[instance.bookingMode]!,
      'availability': instance.availability.toJson(),
    };

const _$FuelPolicyEnumMap = {
  FuelPolicy.fullToFull: 'full_to_full',
  FuelPolicy.sameToSame: 'same_to_same',
  FuelPolicy.unknown: 'unknown',
};

const _$BookingModeEnumMap = {
  BookingMode.instant: 'instant',
  BookingMode.request: 'request',
  BookingMode.unknown: 'unknown',
};
