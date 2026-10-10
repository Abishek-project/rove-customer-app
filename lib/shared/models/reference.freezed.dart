// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$City {

 String get id; String get name; String get slug; String get countryCode; String get timezone;
/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCopyWith<City> get copyWith => _$CityCopyWithImpl<City>(this as City, _$identity);

  /// Serializes this City to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is City&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,countryCode,timezone);

@override
String toString() {
  return 'City(id: $id, name: $name, slug: $slug, countryCode: $countryCode, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class $CityCopyWith<$Res>  {
  factory $CityCopyWith(City value, $Res Function(City) _then) = _$CityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, String countryCode, String timezone
});




}
/// @nodoc
class _$CityCopyWithImpl<$Res>
    implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._self, this._then);

  final City _self;
  final $Res Function(City) _then;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? countryCode = null,Object? timezone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [City].
extension CityPatterns on City {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _City value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _City() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _City value)  $default,){
final _that = this;
switch (_that) {
case _City():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _City value)?  $default,){
final _that = this;
switch (_that) {
case _City() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String countryCode,  String timezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _City() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.countryCode,_that.timezone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String countryCode,  String timezone)  $default,) {final _that = this;
switch (_that) {
case _City():
return $default(_that.id,_that.name,_that.slug,_that.countryCode,_that.timezone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug,  String countryCode,  String timezone)?  $default,) {final _that = this;
switch (_that) {
case _City() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.countryCode,_that.timezone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _City implements City {
  const _City({required this.id, required this.name, required this.slug, required this.countryCode, required this.timezone});
  factory _City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override final  String countryCode;
@override final  String timezone;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCopyWith<_City> get copyWith => __$CityCopyWithImpl<_City>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _City&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,countryCode,timezone);

@override
String toString() {
  return 'City(id: $id, name: $name, slug: $slug, countryCode: $countryCode, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class _$CityCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$CityCopyWith(_City value, $Res Function(_City) _then) = __$CityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, String countryCode, String timezone
});




}
/// @nodoc
class __$CityCopyWithImpl<$Res>
    implements _$CityCopyWith<$Res> {
  __$CityCopyWithImpl(this._self, this._then);

  final _City _self;
  final $Res Function(_City) _then;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? countryCode = null,Object? timezone = null,}) {
  return _then(_City(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Country {

 String get code; String get name; String get currency; String get timezone; String get taxLabel; int get taxRateBps; int get platformFeeBps; List<String> get paymentMethods; List<City> get cities;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.taxLabel, taxLabel) || other.taxLabel == taxLabel)&&(identical(other.taxRateBps, taxRateBps) || other.taxRateBps == taxRateBps)&&(identical(other.platformFeeBps, platformFeeBps) || other.platformFeeBps == platformFeeBps)&&const DeepCollectionEquality().equals(other.paymentMethods, paymentMethods)&&const DeepCollectionEquality().equals(other.cities, cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,currency,timezone,taxLabel,taxRateBps,platformFeeBps,const DeepCollectionEquality().hash(paymentMethods),const DeepCollectionEquality().hash(cities));

@override
String toString() {
  return 'Country(code: $code, name: $name, currency: $currency, timezone: $timezone, taxLabel: $taxLabel, taxRateBps: $taxRateBps, platformFeeBps: $platformFeeBps, paymentMethods: $paymentMethods, cities: $cities)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 String code, String name, String currency, String timezone, String taxLabel, int taxRateBps, int platformFeeBps, List<String> paymentMethods, List<City> cities
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? currency = null,Object? timezone = null,Object? taxLabel = null,Object? taxRateBps = null,Object? platformFeeBps = null,Object? paymentMethods = null,Object? cities = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,taxLabel: null == taxLabel ? _self.taxLabel : taxLabel // ignore: cast_nullable_to_non_nullable
as String,taxRateBps: null == taxRateBps ? _self.taxRateBps : taxRateBps // ignore: cast_nullable_to_non_nullable
as int,platformFeeBps: null == platformFeeBps ? _self.platformFeeBps : platformFeeBps // ignore: cast_nullable_to_non_nullable
as int,paymentMethods: null == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<String>,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<City>,
  ));
}

}


/// Adds pattern-matching-related methods to [Country].
extension CountryPatterns on Country {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Country value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Country value)  $default,){
final _that = this;
switch (_that) {
case _Country():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Country value)?  $default,){
final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String currency,  String timezone,  String taxLabel,  int taxRateBps,  int platformFeeBps,  List<String> paymentMethods,  List<City> cities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.code,_that.name,_that.currency,_that.timezone,_that.taxLabel,_that.taxRateBps,_that.platformFeeBps,_that.paymentMethods,_that.cities);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String currency,  String timezone,  String taxLabel,  int taxRateBps,  int platformFeeBps,  List<String> paymentMethods,  List<City> cities)  $default,) {final _that = this;
switch (_that) {
case _Country():
return $default(_that.code,_that.name,_that.currency,_that.timezone,_that.taxLabel,_that.taxRateBps,_that.platformFeeBps,_that.paymentMethods,_that.cities);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String currency,  String timezone,  String taxLabel,  int taxRateBps,  int platformFeeBps,  List<String> paymentMethods,  List<City> cities)?  $default,) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.code,_that.name,_that.currency,_that.timezone,_that.taxLabel,_that.taxRateBps,_that.platformFeeBps,_that.paymentMethods,_that.cities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Country extends Country {
  const _Country({required this.code, required this.name, required this.currency, required this.timezone, required this.taxLabel, required this.taxRateBps, required this.platformFeeBps, final  List<String> paymentMethods = const <String>[], final  List<City> cities = const <City>[]}): _paymentMethods = paymentMethods,_cities = cities,super._();
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override final  String code;
@override final  String name;
@override final  String currency;
@override final  String timezone;
@override final  String taxLabel;
@override final  int taxRateBps;
@override final  int platformFeeBps;
 final  List<String> _paymentMethods;
@override@JsonKey() List<String> get paymentMethods {
  if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentMethods);
}

 final  List<City> _cities;
@override@JsonKey() List<City> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}


/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.taxLabel, taxLabel) || other.taxLabel == taxLabel)&&(identical(other.taxRateBps, taxRateBps) || other.taxRateBps == taxRateBps)&&(identical(other.platformFeeBps, platformFeeBps) || other.platformFeeBps == platformFeeBps)&&const DeepCollectionEquality().equals(other._paymentMethods, _paymentMethods)&&const DeepCollectionEquality().equals(other._cities, _cities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,currency,timezone,taxLabel,taxRateBps,platformFeeBps,const DeepCollectionEquality().hash(_paymentMethods),const DeepCollectionEquality().hash(_cities));

@override
String toString() {
  return 'Country(code: $code, name: $name, currency: $currency, timezone: $timezone, taxLabel: $taxLabel, taxRateBps: $taxRateBps, platformFeeBps: $platformFeeBps, paymentMethods: $paymentMethods, cities: $cities)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String currency, String timezone, String taxLabel, int taxRateBps, int platformFeeBps, List<String> paymentMethods, List<City> cities
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? currency = null,Object? timezone = null,Object? taxLabel = null,Object? taxRateBps = null,Object? platformFeeBps = null,Object? paymentMethods = null,Object? cities = null,}) {
  return _then(_Country(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,taxLabel: null == taxLabel ? _self.taxLabel : taxLabel // ignore: cast_nullable_to_non_nullable
as String,taxRateBps: null == taxRateBps ? _self.taxRateBps : taxRateBps // ignore: cast_nullable_to_non_nullable
as int,platformFeeBps: null == platformFeeBps ? _self.platformFeeBps : platformFeeBps // ignore: cast_nullable_to_non_nullable
as int,paymentMethods: null == paymentMethods ? _self._paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<String>,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<City>,
  ));
}


}


/// @nodoc
mixin _$PickupLocation {

 String get id; String get name; String? get address; String? get cityId;@LenientDoubleConverter() double? get latitude;@LenientDoubleConverter() double? get longitude;
/// Create a copy of PickupLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PickupLocationCopyWith<PickupLocation> get copyWith => _$PickupLocationCopyWithImpl<PickupLocation>(this as PickupLocation, _$identity);

  /// Serializes this PickupLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PickupLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,cityId,latitude,longitude);

@override
String toString() {
  return 'PickupLocation(id: $id, name: $name, address: $address, cityId: $cityId, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $PickupLocationCopyWith<$Res>  {
  factory $PickupLocationCopyWith(PickupLocation value, $Res Function(PickupLocation) _then) = _$PickupLocationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? address, String? cityId,@LenientDoubleConverter() double? latitude,@LenientDoubleConverter() double? longitude
});




}
/// @nodoc
class _$PickupLocationCopyWithImpl<$Res>
    implements $PickupLocationCopyWith<$Res> {
  _$PickupLocationCopyWithImpl(this._self, this._then);

  final PickupLocation _self;
  final $Res Function(PickupLocation) _then;

/// Create a copy of PickupLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = freezed,Object? cityId = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PickupLocation].
extension PickupLocationPatterns on PickupLocation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PickupLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PickupLocation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PickupLocation value)  $default,){
final _that = this;
switch (_that) {
case _PickupLocation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PickupLocation value)?  $default,){
final _that = this;
switch (_that) {
case _PickupLocation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? address,  String? cityId, @LenientDoubleConverter()  double? latitude, @LenientDoubleConverter()  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PickupLocation() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.cityId,_that.latitude,_that.longitude);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? address,  String? cityId, @LenientDoubleConverter()  double? latitude, @LenientDoubleConverter()  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _PickupLocation():
return $default(_that.id,_that.name,_that.address,_that.cityId,_that.latitude,_that.longitude);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? address,  String? cityId, @LenientDoubleConverter()  double? latitude, @LenientDoubleConverter()  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _PickupLocation() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.cityId,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PickupLocation implements PickupLocation {
  const _PickupLocation({required this.id, required this.name, this.address, this.cityId, @LenientDoubleConverter() this.latitude, @LenientDoubleConverter() this.longitude});
  factory _PickupLocation.fromJson(Map<String, dynamic> json) => _$PickupLocationFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? address;
@override final  String? cityId;
@override@LenientDoubleConverter() final  double? latitude;
@override@LenientDoubleConverter() final  double? longitude;

/// Create a copy of PickupLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickupLocationCopyWith<_PickupLocation> get copyWith => __$PickupLocationCopyWithImpl<_PickupLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PickupLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PickupLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,cityId,latitude,longitude);

@override
String toString() {
  return 'PickupLocation(id: $id, name: $name, address: $address, cityId: $cityId, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$PickupLocationCopyWith<$Res> implements $PickupLocationCopyWith<$Res> {
  factory _$PickupLocationCopyWith(_PickupLocation value, $Res Function(_PickupLocation) _then) = __$PickupLocationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? address, String? cityId,@LenientDoubleConverter() double? latitude,@LenientDoubleConverter() double? longitude
});




}
/// @nodoc
class __$PickupLocationCopyWithImpl<$Res>
    implements _$PickupLocationCopyWith<$Res> {
  __$PickupLocationCopyWithImpl(this._self, this._then);

  final _PickupLocation _self;
  final $Res Function(_PickupLocation) _then;

/// Create a copy of PickupLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = freezed,Object? cityId = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_PickupLocation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$CityRef {

 String get id; String get name;
/// Create a copy of CityRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityRefCopyWith<CityRef> get copyWith => _$CityRefCopyWithImpl<CityRef>(this as CityRef, _$identity);

  /// Serializes this CityRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'CityRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $CityRefCopyWith<$Res>  {
  factory $CityRefCopyWith(CityRef value, $Res Function(CityRef) _then) = _$CityRefCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$CityRefCopyWithImpl<$Res>
    implements $CityRefCopyWith<$Res> {
  _$CityRefCopyWithImpl(this._self, this._then);

  final CityRef _self;
  final $Res Function(CityRef) _then;

/// Create a copy of CityRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CityRef].
extension CityRefPatterns on CityRef {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityRef() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityRef value)  $default,){
final _that = this;
switch (_that) {
case _CityRef():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityRef value)?  $default,){
final _that = this;
switch (_that) {
case _CityRef() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityRef() when $default != null:
return $default(_that.id,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _CityRef():
return $default(_that.id,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _CityRef() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityRef implements CityRef {
  const _CityRef({required this.id, required this.name});
  factory _CityRef.fromJson(Map<String, dynamic> json) => _$CityRefFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of CityRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityRefCopyWith<_CityRef> get copyWith => __$CityRefCopyWithImpl<_CityRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'CityRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$CityRefCopyWith<$Res> implements $CityRefCopyWith<$Res> {
  factory _$CityRefCopyWith(_CityRef value, $Res Function(_CityRef) _then) = __$CityRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$CityRefCopyWithImpl<$Res>
    implements _$CityRefCopyWith<$Res> {
  __$CityRefCopyWithImpl(this._self, this._then);

  final _CityRef _self;
  final $Res Function(_CityRef) _then;

/// Create a copy of CityRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_CityRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PageMeta {

 int get page; int get pageSize; int get total; int get totalPages;
/// Create a copy of PageMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageMetaCopyWith<PageMeta> get copyWith => _$PageMetaCopyWithImpl<PageMeta>(this as PageMeta, _$identity);

  /// Serializes this PageMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageMeta&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,pageSize,total,totalPages);

@override
String toString() {
  return 'PageMeta(page: $page, pageSize: $pageSize, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $PageMetaCopyWith<$Res>  {
  factory $PageMetaCopyWith(PageMeta value, $Res Function(PageMeta) _then) = _$PageMetaCopyWithImpl;
@useResult
$Res call({
 int page, int pageSize, int total, int totalPages
});




}
/// @nodoc
class _$PageMetaCopyWithImpl<$Res>
    implements $PageMetaCopyWith<$Res> {
  _$PageMetaCopyWithImpl(this._self, this._then);

  final PageMeta _self;
  final $Res Function(PageMeta) _then;

/// Create a copy of PageMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? pageSize = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PageMeta].
extension PageMetaPatterns on PageMeta {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageMeta() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageMeta value)  $default,){
final _that = this;
switch (_that) {
case _PageMeta():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageMeta value)?  $default,){
final _that = this;
switch (_that) {
case _PageMeta() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  int pageSize,  int total,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageMeta() when $default != null:
return $default(_that.page,_that.pageSize,_that.total,_that.totalPages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  int pageSize,  int total,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _PageMeta():
return $default(_that.page,_that.pageSize,_that.total,_that.totalPages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  int pageSize,  int total,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _PageMeta() when $default != null:
return $default(_that.page,_that.pageSize,_that.total,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageMeta extends PageMeta {
  const _PageMeta({this.page = 1, this.pageSize = 20, this.total = 0, this.totalPages = 1}): super._();
  factory _PageMeta.fromJson(Map<String, dynamic> json) => _$PageMetaFromJson(json);

@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int total;
@override@JsonKey() final  int totalPages;

/// Create a copy of PageMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageMetaCopyWith<_PageMeta> get copyWith => __$PageMetaCopyWithImpl<_PageMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageMeta&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,pageSize,total,totalPages);

@override
String toString() {
  return 'PageMeta(page: $page, pageSize: $pageSize, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$PageMetaCopyWith<$Res> implements $PageMetaCopyWith<$Res> {
  factory _$PageMetaCopyWith(_PageMeta value, $Res Function(_PageMeta) _then) = __$PageMetaCopyWithImpl;
@override @useResult
$Res call({
 int page, int pageSize, int total, int totalPages
});




}
/// @nodoc
class __$PageMetaCopyWithImpl<$Res>
    implements _$PageMetaCopyWith<$Res> {
  __$PageMetaCopyWithImpl(this._self, this._then);

  final _PageMeta _self;
  final $Res Function(_PageMeta) _then;

/// Create a copy of PageMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? pageSize = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_PageMeta(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
