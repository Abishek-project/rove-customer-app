import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

@freezed
abstract class City with _$City {
  const factory City({
    required String id,
    required String name,
    required String slug,
    required String countryCode,
    required String timezone,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
abstract class Country with _$Country {
  const Country._();

  const factory Country({
    required String code,
    required String name,
    required String currency,
    required String timezone,
    required String taxLabel,
    required int taxRateBps,
    required int platformFeeBps,
    @Default(<String>[]) List<String> paymentMethods,
    @Default(<City>[]) List<City> cities,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  City? cityById(String? id) {
    for (final city in cities) {
      if (city.id == id) return city;
    }
    return null;
  }
}

@freezed
abstract class PickupLocation with _$PickupLocation {
  const factory PickupLocation({
    required String id,
    required String name,
    String? address,
    String? cityId,
    @LenientDoubleConverter() double? latitude,
    @LenientDoubleConverter() double? longitude,
  }) = _PickupLocation;

  factory PickupLocation.fromJson(Map<String, dynamic> json) =>
      _$PickupLocationFromJson(json);
}

@freezed
abstract class CityRef with _$CityRef {
  const factory CityRef({required String id, required String name}) = _CityRef;

  factory CityRef.fromJson(Map<String, dynamic> json) =>
      _$CityRefFromJson(json);
}

/// Pagination metadata from the success envelope.
@freezed
abstract class PageMeta with _$PageMeta {
  const PageMeta._();

  const factory PageMeta({
    @Default(1) int page,
    @Default(20) int pageSize,
    @Default(0) int total,
    @Default(1) int totalPages,
  }) = _PageMeta;

  factory PageMeta.fromJson(Map<String, dynamic> json) =>
      _$PageMetaFromJson(json);

  bool get hasMore => page < totalPages;
}

class Paged<T> {
  const Paged(this.items, this.meta);

  final List<T> items;
  final PageMeta meta;
}
