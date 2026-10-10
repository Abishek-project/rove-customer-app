// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_City _$CityFromJson(Map<String, dynamic> json) => _City(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  countryCode: json['countryCode'] as String,
  timezone: json['timezone'] as String,
);

Map<String, dynamic> _$CityToJson(_City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'countryCode': instance.countryCode,
  'timezone': instance.timezone,
};

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  code: json['code'] as String,
  name: json['name'] as String,
  currency: json['currency'] as String,
  timezone: json['timezone'] as String,
  taxLabel: json['taxLabel'] as String,
  taxRateBps: (json['taxRateBps'] as num).toInt(),
  platformFeeBps: (json['platformFeeBps'] as num).toInt(),
  paymentMethods:
      (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  cities:
      (json['cities'] as List<dynamic>?)
          ?.map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <City>[],
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'currency': instance.currency,
  'timezone': instance.timezone,
  'taxLabel': instance.taxLabel,
  'taxRateBps': instance.taxRateBps,
  'platformFeeBps': instance.platformFeeBps,
  'paymentMethods': instance.paymentMethods,
  'cities': instance.cities.map((e) => e.toJson()).toList(),
};

_PickupLocation _$PickupLocationFromJson(Map<String, dynamic> json) =>
    _PickupLocation(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      cityId: json['cityId'] as String?,
      latitude: const LenientDoubleConverter().fromJson(json['latitude']),
      longitude: const LenientDoubleConverter().fromJson(json['longitude']),
    );

Map<String, dynamic> _$PickupLocationToJson(_PickupLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': ?instance.address,
      'cityId': ?instance.cityId,
      'latitude': ?const LenientDoubleConverter().toJson(instance.latitude),
      'longitude': ?const LenientDoubleConverter().toJson(instance.longitude),
    };

_CityRef _$CityRefFromJson(Map<String, dynamic> json) =>
    _CityRef(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$CityRefToJson(_CityRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

_PageMeta _$PageMetaFromJson(Map<String, dynamic> json) => _PageMeta(
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
  total: (json['total'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$PageMetaToJson(_PageMeta instance) => <String, dynamic>{
  'page': instance.page,
  'pageSize': instance.pageSize,
  'total': instance.total,
  'totalPages': instance.totalPages,
};
