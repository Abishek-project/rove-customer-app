// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnerRef {

 String get id; String get displayName; bool get verified; String? get cityName; String? get logoUrl;
/// Create a copy of PartnerRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnerRefCopyWith<PartnerRef> get copyWith => _$PartnerRefCopyWithImpl<PartnerRef>(this as PartnerRef, _$identity);

  /// Serializes this PartnerRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerRef&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,verified,cityName,logoUrl);

@override
String toString() {
  return 'PartnerRef(id: $id, displayName: $displayName, verified: $verified, cityName: $cityName, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $PartnerRefCopyWith<$Res>  {
  factory $PartnerRefCopyWith(PartnerRef value, $Res Function(PartnerRef) _then) = _$PartnerRefCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, bool verified, String? cityName, String? logoUrl
});




}
/// @nodoc
class _$PartnerRefCopyWithImpl<$Res>
    implements $PartnerRefCopyWith<$Res> {
  _$PartnerRefCopyWithImpl(this._self, this._then);

  final PartnerRef _self;
  final $Res Function(PartnerRef) _then;

/// Create a copy of PartnerRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? verified = null,Object? cityName = freezed,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnerRef].
extension PartnerRefPatterns on PartnerRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnerRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnerRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnerRef value)  $default,){
final _that = this;
switch (_that) {
case _PartnerRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnerRef value)?  $default,){
final _that = this;
switch (_that) {
case _PartnerRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  bool verified,  String? cityName,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnerRef() when $default != null:
return $default(_that.id,_that.displayName,_that.verified,_that.cityName,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  bool verified,  String? cityName,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _PartnerRef():
return $default(_that.id,_that.displayName,_that.verified,_that.cityName,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  bool verified,  String? cityName,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _PartnerRef() when $default != null:
return $default(_that.id,_that.displayName,_that.verified,_that.cityName,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnerRef implements PartnerRef {
  const _PartnerRef({required this.id, required this.displayName, this.verified = false, this.cityName, this.logoUrl});
  factory _PartnerRef.fromJson(Map<String, dynamic> json) => _$PartnerRefFromJson(json);

@override final  String id;
@override final  String displayName;
@override@JsonKey() final  bool verified;
@override final  String? cityName;
@override final  String? logoUrl;

/// Create a copy of PartnerRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnerRefCopyWith<_PartnerRef> get copyWith => __$PartnerRefCopyWithImpl<_PartnerRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnerRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnerRef&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,verified,cityName,logoUrl);

@override
String toString() {
  return 'PartnerRef(id: $id, displayName: $displayName, verified: $verified, cityName: $cityName, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$PartnerRefCopyWith<$Res> implements $PartnerRefCopyWith<$Res> {
  factory _$PartnerRefCopyWith(_PartnerRef value, $Res Function(_PartnerRef) _then) = __$PartnerRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, bool verified, String? cityName, String? logoUrl
});




}
/// @nodoc
class __$PartnerRefCopyWithImpl<$Res>
    implements _$PartnerRefCopyWith<$Res> {
  __$PartnerRefCopyWithImpl(this._self, this._then);

  final _PartnerRef _self;
  final $Res Function(_PartnerRef) _then;

/// Create a copy of PartnerRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? verified = null,Object? cityName = freezed,Object? logoUrl = freezed,}) {
  return _then(_PartnerRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VehicleSummary {

 String get id; String get make; String get model; int get year;@JsonKey(unknownEnumValue: VehicleCategory.unknown) VehicleCategory get category;@JsonKey(unknownEnumValue: Transmission.unknown) Transmission get transmission;@JsonKey(unknownEnumValue: FuelType.unknown) FuelType get fuelType; int get seats; int get luggage; String? get coverImageUrl; Money get dailyRate; Money? get estimatedTotal; int? get days; CityRef get city; bool get deliveryAvailable; PartnerRef get partner; bool get isFavorite;
/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleSummaryCopyWith<VehicleSummary> get copyWith => _$VehicleSummaryCopyWithImpl<VehicleSummary>(this as VehicleSummary, _$identity);

  /// Serializes this VehicleSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.category, category) || other.category == category)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.luggage, luggage) || other.luggage == luggage)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.dailyRate, dailyRate) || other.dailyRate == dailyRate)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&(identical(other.days, days) || other.days == days)&&(identical(other.city, city) || other.city == city)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,make,model,year,category,transmission,fuelType,seats,luggage,coverImageUrl,dailyRate,estimatedTotal,days,city,deliveryAvailable,partner,isFavorite);

@override
String toString() {
  return 'VehicleSummary(id: $id, make: $make, model: $model, year: $year, category: $category, transmission: $transmission, fuelType: $fuelType, seats: $seats, luggage: $luggage, coverImageUrl: $coverImageUrl, dailyRate: $dailyRate, estimatedTotal: $estimatedTotal, days: $days, city: $city, deliveryAvailable: $deliveryAvailable, partner: $partner, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $VehicleSummaryCopyWith<$Res>  {
  factory $VehicleSummaryCopyWith(VehicleSummary value, $Res Function(VehicleSummary) _then) = _$VehicleSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String make, String model, int year,@JsonKey(unknownEnumValue: VehicleCategory.unknown) VehicleCategory category,@JsonKey(unknownEnumValue: Transmission.unknown) Transmission transmission,@JsonKey(unknownEnumValue: FuelType.unknown) FuelType fuelType, int seats, int luggage, String? coverImageUrl, Money dailyRate, Money? estimatedTotal, int? days, CityRef city, bool deliveryAvailable, PartnerRef partner, bool isFavorite
});


$CityRefCopyWith<$Res> get city;$PartnerRefCopyWith<$Res> get partner;

}
/// @nodoc
class _$VehicleSummaryCopyWithImpl<$Res>
    implements $VehicleSummaryCopyWith<$Res> {
  _$VehicleSummaryCopyWithImpl(this._self, this._then);

  final VehicleSummary _self;
  final $Res Function(VehicleSummary) _then;

/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? category = null,Object? transmission = null,Object? fuelType = null,Object? seats = null,Object? luggage = null,Object? coverImageUrl = freezed,Object? dailyRate = null,Object? estimatedTotal = freezed,Object? days = freezed,Object? city = null,Object? deliveryAvailable = null,Object? partner = null,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as VehicleCategory,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as Transmission,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,luggage: null == luggage ? _self.luggage : luggage // ignore: cast_nullable_to_non_nullable
as int,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,dailyRate: null == dailyRate ? _self.dailyRate : dailyRate // ignore: cast_nullable_to_non_nullable
as Money,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as Money?,days: freezed == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerRef,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerRefCopyWith<$Res> get partner {
  
  return $PartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}
}


/// Adds pattern-matching-related methods to [VehicleSummary].
extension VehicleSummaryPatterns on VehicleSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleSummary value)  $default,){
final _that = this;
switch (_that) {
case _VehicleSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleSummary value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year, @JsonKey(unknownEnumValue: VehicleCategory.unknown)  VehicleCategory category, @JsonKey(unknownEnumValue: Transmission.unknown)  Transmission transmission, @JsonKey(unknownEnumValue: FuelType.unknown)  FuelType fuelType,  int seats,  int luggage,  String? coverImageUrl,  Money dailyRate,  Money? estimatedTotal,  int? days,  CityRef city,  bool deliveryAvailable,  PartnerRef partner,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleSummary() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.category,_that.transmission,_that.fuelType,_that.seats,_that.luggage,_that.coverImageUrl,_that.dailyRate,_that.estimatedTotal,_that.days,_that.city,_that.deliveryAvailable,_that.partner,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year, @JsonKey(unknownEnumValue: VehicleCategory.unknown)  VehicleCategory category, @JsonKey(unknownEnumValue: Transmission.unknown)  Transmission transmission, @JsonKey(unknownEnumValue: FuelType.unknown)  FuelType fuelType,  int seats,  int luggage,  String? coverImageUrl,  Money dailyRate,  Money? estimatedTotal,  int? days,  CityRef city,  bool deliveryAvailable,  PartnerRef partner,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _VehicleSummary():
return $default(_that.id,_that.make,_that.model,_that.year,_that.category,_that.transmission,_that.fuelType,_that.seats,_that.luggage,_that.coverImageUrl,_that.dailyRate,_that.estimatedTotal,_that.days,_that.city,_that.deliveryAvailable,_that.partner,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String make,  String model,  int year, @JsonKey(unknownEnumValue: VehicleCategory.unknown)  VehicleCategory category, @JsonKey(unknownEnumValue: Transmission.unknown)  Transmission transmission, @JsonKey(unknownEnumValue: FuelType.unknown)  FuelType fuelType,  int seats,  int luggage,  String? coverImageUrl,  Money dailyRate,  Money? estimatedTotal,  int? days,  CityRef city,  bool deliveryAvailable,  PartnerRef partner,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _VehicleSummary() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.category,_that.transmission,_that.fuelType,_that.seats,_that.luggage,_that.coverImageUrl,_that.dailyRate,_that.estimatedTotal,_that.days,_that.city,_that.deliveryAvailable,_that.partner,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleSummary extends VehicleSummary {
  const _VehicleSummary({required this.id, required this.make, required this.model, required this.year, @JsonKey(unknownEnumValue: VehicleCategory.unknown) required this.category, @JsonKey(unknownEnumValue: Transmission.unknown) required this.transmission, @JsonKey(unknownEnumValue: FuelType.unknown) required this.fuelType, required this.seats, this.luggage = 0, this.coverImageUrl, required this.dailyRate, this.estimatedTotal, this.days, required this.city, this.deliveryAvailable = false, required this.partner, this.isFavorite = false}): super._();
  factory _VehicleSummary.fromJson(Map<String, dynamic> json) => _$VehicleSummaryFromJson(json);

@override final  String id;
@override final  String make;
@override final  String model;
@override final  int year;
@override@JsonKey(unknownEnumValue: VehicleCategory.unknown) final  VehicleCategory category;
@override@JsonKey(unknownEnumValue: Transmission.unknown) final  Transmission transmission;
@override@JsonKey(unknownEnumValue: FuelType.unknown) final  FuelType fuelType;
@override final  int seats;
@override@JsonKey() final  int luggage;
@override final  String? coverImageUrl;
@override final  Money dailyRate;
@override final  Money? estimatedTotal;
@override final  int? days;
@override final  CityRef city;
@override@JsonKey() final  bool deliveryAvailable;
@override final  PartnerRef partner;
@override@JsonKey() final  bool isFavorite;

/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleSummaryCopyWith<_VehicleSummary> get copyWith => __$VehicleSummaryCopyWithImpl<_VehicleSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.category, category) || other.category == category)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.luggage, luggage) || other.luggage == luggage)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.dailyRate, dailyRate) || other.dailyRate == dailyRate)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&(identical(other.days, days) || other.days == days)&&(identical(other.city, city) || other.city == city)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,make,model,year,category,transmission,fuelType,seats,luggage,coverImageUrl,dailyRate,estimatedTotal,days,city,deliveryAvailable,partner,isFavorite);

@override
String toString() {
  return 'VehicleSummary(id: $id, make: $make, model: $model, year: $year, category: $category, transmission: $transmission, fuelType: $fuelType, seats: $seats, luggage: $luggage, coverImageUrl: $coverImageUrl, dailyRate: $dailyRate, estimatedTotal: $estimatedTotal, days: $days, city: $city, deliveryAvailable: $deliveryAvailable, partner: $partner, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$VehicleSummaryCopyWith<$Res> implements $VehicleSummaryCopyWith<$Res> {
  factory _$VehicleSummaryCopyWith(_VehicleSummary value, $Res Function(_VehicleSummary) _then) = __$VehicleSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String make, String model, int year,@JsonKey(unknownEnumValue: VehicleCategory.unknown) VehicleCategory category,@JsonKey(unknownEnumValue: Transmission.unknown) Transmission transmission,@JsonKey(unknownEnumValue: FuelType.unknown) FuelType fuelType, int seats, int luggage, String? coverImageUrl, Money dailyRate, Money? estimatedTotal, int? days, CityRef city, bool deliveryAvailable, PartnerRef partner, bool isFavorite
});


@override $CityRefCopyWith<$Res> get city;@override $PartnerRefCopyWith<$Res> get partner;

}
/// @nodoc
class __$VehicleSummaryCopyWithImpl<$Res>
    implements _$VehicleSummaryCopyWith<$Res> {
  __$VehicleSummaryCopyWithImpl(this._self, this._then);

  final _VehicleSummary _self;
  final $Res Function(_VehicleSummary) _then;

/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? category = null,Object? transmission = null,Object? fuelType = null,Object? seats = null,Object? luggage = null,Object? coverImageUrl = freezed,Object? dailyRate = null,Object? estimatedTotal = freezed,Object? days = freezed,Object? city = null,Object? deliveryAvailable = null,Object? partner = null,Object? isFavorite = null,}) {
  return _then(_VehicleSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as VehicleCategory,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as Transmission,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,luggage: null == luggage ? _self.luggage : luggage // ignore: cast_nullable_to_non_nullable
as int,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,dailyRate: null == dailyRate ? _self.dailyRate : dailyRate // ignore: cast_nullable_to_non_nullable
as Money,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as Money?,days: freezed == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerRef,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of VehicleSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerRefCopyWith<$Res> get partner {
  
  return $PartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}
}


/// @nodoc
mixin _$VehicleImage {

 String get id; String get url; bool get isCover; int get sortOrder;
/// Create a copy of VehicleImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleImageCopyWith<VehicleImage> get copyWith => _$VehicleImageCopyWithImpl<VehicleImage>(this as VehicleImage, _$identity);

  /// Serializes this VehicleImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,isCover,sortOrder);

@override
String toString() {
  return 'VehicleImage(id: $id, url: $url, isCover: $isCover, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $VehicleImageCopyWith<$Res>  {
  factory $VehicleImageCopyWith(VehicleImage value, $Res Function(VehicleImage) _then) = _$VehicleImageCopyWithImpl;
@useResult
$Res call({
 String id, String url, bool isCover, int sortOrder
});




}
/// @nodoc
class _$VehicleImageCopyWithImpl<$Res>
    implements $VehicleImageCopyWith<$Res> {
  _$VehicleImageCopyWithImpl(this._self, this._then);

  final VehicleImage _self;
  final $Res Function(VehicleImage) _then;

/// Create a copy of VehicleImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? isCover = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleImage].
extension VehicleImagePatterns on VehicleImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleImage value)  $default,){
final _that = this;
switch (_that) {
case _VehicleImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleImage value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String url,  bool isCover,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleImage() when $default != null:
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String url,  bool isCover,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _VehicleImage():
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String url,  bool isCover,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _VehicleImage() when $default != null:
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleImage implements VehicleImage {
  const _VehicleImage({required this.id, required this.url, this.isCover = false, this.sortOrder = 0});
  factory _VehicleImage.fromJson(Map<String, dynamic> json) => _$VehicleImageFromJson(json);

@override final  String id;
@override final  String url;
@override@JsonKey() final  bool isCover;
@override@JsonKey() final  int sortOrder;

/// Create a copy of VehicleImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleImageCopyWith<_VehicleImage> get copyWith => __$VehicleImageCopyWithImpl<_VehicleImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,isCover,sortOrder);

@override
String toString() {
  return 'VehicleImage(id: $id, url: $url, isCover: $isCover, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$VehicleImageCopyWith<$Res> implements $VehicleImageCopyWith<$Res> {
  factory _$VehicleImageCopyWith(_VehicleImage value, $Res Function(_VehicleImage) _then) = __$VehicleImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String url, bool isCover, int sortOrder
});




}
/// @nodoc
class __$VehicleImageCopyWithImpl<$Res>
    implements _$VehicleImageCopyWith<$Res> {
  __$VehicleImageCopyWithImpl(this._self, this._then);

  final _VehicleImage _self;
  final $Res Function(_VehicleImage) _then;

/// Create a copy of VehicleImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? isCover = null,Object? sortOrder = null,}) {
  return _then(_VehicleImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MileagePolicy {

 int? get limitKmPerDay; Money get excessFeePerKm;
/// Create a copy of MileagePolicy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MileagePolicyCopyWith<MileagePolicy> get copyWith => _$MileagePolicyCopyWithImpl<MileagePolicy>(this as MileagePolicy, _$identity);

  /// Serializes this MileagePolicy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MileagePolicy&&(identical(other.limitKmPerDay, limitKmPerDay) || other.limitKmPerDay == limitKmPerDay)&&(identical(other.excessFeePerKm, excessFeePerKm) || other.excessFeePerKm == excessFeePerKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limitKmPerDay,excessFeePerKm);

@override
String toString() {
  return 'MileagePolicy(limitKmPerDay: $limitKmPerDay, excessFeePerKm: $excessFeePerKm)';
}


}

/// @nodoc
abstract mixin class $MileagePolicyCopyWith<$Res>  {
  factory $MileagePolicyCopyWith(MileagePolicy value, $Res Function(MileagePolicy) _then) = _$MileagePolicyCopyWithImpl;
@useResult
$Res call({
 int? limitKmPerDay, Money excessFeePerKm
});




}
/// @nodoc
class _$MileagePolicyCopyWithImpl<$Res>
    implements $MileagePolicyCopyWith<$Res> {
  _$MileagePolicyCopyWithImpl(this._self, this._then);

  final MileagePolicy _self;
  final $Res Function(MileagePolicy) _then;

/// Create a copy of MileagePolicy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limitKmPerDay = freezed,Object? excessFeePerKm = null,}) {
  return _then(_self.copyWith(
limitKmPerDay: freezed == limitKmPerDay ? _self.limitKmPerDay : limitKmPerDay // ignore: cast_nullable_to_non_nullable
as int?,excessFeePerKm: null == excessFeePerKm ? _self.excessFeePerKm : excessFeePerKm // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [MileagePolicy].
extension MileagePolicyPatterns on MileagePolicy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MileagePolicy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MileagePolicy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MileagePolicy value)  $default,){
final _that = this;
switch (_that) {
case _MileagePolicy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MileagePolicy value)?  $default,){
final _that = this;
switch (_that) {
case _MileagePolicy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? limitKmPerDay,  Money excessFeePerKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MileagePolicy() when $default != null:
return $default(_that.limitKmPerDay,_that.excessFeePerKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? limitKmPerDay,  Money excessFeePerKm)  $default,) {final _that = this;
switch (_that) {
case _MileagePolicy():
return $default(_that.limitKmPerDay,_that.excessFeePerKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? limitKmPerDay,  Money excessFeePerKm)?  $default,) {final _that = this;
switch (_that) {
case _MileagePolicy() when $default != null:
return $default(_that.limitKmPerDay,_that.excessFeePerKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MileagePolicy implements MileagePolicy {
  const _MileagePolicy({this.limitKmPerDay, required this.excessFeePerKm});
  factory _MileagePolicy.fromJson(Map<String, dynamic> json) => _$MileagePolicyFromJson(json);

@override final  int? limitKmPerDay;
@override final  Money excessFeePerKm;

/// Create a copy of MileagePolicy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MileagePolicyCopyWith<_MileagePolicy> get copyWith => __$MileagePolicyCopyWithImpl<_MileagePolicy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MileagePolicyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MileagePolicy&&(identical(other.limitKmPerDay, limitKmPerDay) || other.limitKmPerDay == limitKmPerDay)&&(identical(other.excessFeePerKm, excessFeePerKm) || other.excessFeePerKm == excessFeePerKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limitKmPerDay,excessFeePerKm);

@override
String toString() {
  return 'MileagePolicy(limitKmPerDay: $limitKmPerDay, excessFeePerKm: $excessFeePerKm)';
}


}

/// @nodoc
abstract mixin class _$MileagePolicyCopyWith<$Res> implements $MileagePolicyCopyWith<$Res> {
  factory _$MileagePolicyCopyWith(_MileagePolicy value, $Res Function(_MileagePolicy) _then) = __$MileagePolicyCopyWithImpl;
@override @useResult
$Res call({
 int? limitKmPerDay, Money excessFeePerKm
});




}
/// @nodoc
class __$MileagePolicyCopyWithImpl<$Res>
    implements _$MileagePolicyCopyWith<$Res> {
  __$MileagePolicyCopyWithImpl(this._self, this._then);

  final _MileagePolicy _self;
  final $Res Function(_MileagePolicy) _then;

/// Create a copy of MileagePolicy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limitKmPerDay = freezed,Object? excessFeePerKm = null,}) {
  return _then(_MileagePolicy(
limitKmPerDay: freezed == limitKmPerDay ? _self.limitKmPerDay : limitKmPerDay // ignore: cast_nullable_to_non_nullable
as int?,excessFeePerKm: null == excessFeePerKm ? _self.excessFeePerKm : excessFeePerKm // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}


/// @nodoc
mixin _$PolicyInfo {

 String get code; String get summary;
/// Create a copy of PolicyInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<PolicyInfo> get copyWith => _$PolicyInfoCopyWithImpl<PolicyInfo>(this as PolicyInfo, _$identity);

  /// Serializes this PolicyInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolicyInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,summary);

@override
String toString() {
  return 'PolicyInfo(code: $code, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $PolicyInfoCopyWith<$Res>  {
  factory $PolicyInfoCopyWith(PolicyInfo value, $Res Function(PolicyInfo) _then) = _$PolicyInfoCopyWithImpl;
@useResult
$Res call({
 String code, String summary
});




}
/// @nodoc
class _$PolicyInfoCopyWithImpl<$Res>
    implements $PolicyInfoCopyWith<$Res> {
  _$PolicyInfoCopyWithImpl(this._self, this._then);

  final PolicyInfo _self;
  final $Res Function(PolicyInfo) _then;

/// Create a copy of PolicyInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? summary = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PolicyInfo].
extension PolicyInfoPatterns on PolicyInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolicyInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolicyInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolicyInfo value)  $default,){
final _that = this;
switch (_that) {
case _PolicyInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolicyInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PolicyInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolicyInfo() when $default != null:
return $default(_that.code,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String summary)  $default,) {final _that = this;
switch (_that) {
case _PolicyInfo():
return $default(_that.code,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String summary)?  $default,) {final _that = this;
switch (_that) {
case _PolicyInfo() when $default != null:
return $default(_that.code,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PolicyInfo implements PolicyInfo {
  const _PolicyInfo({required this.code, required this.summary});
  factory _PolicyInfo.fromJson(Map<String, dynamic> json) => _$PolicyInfoFromJson(json);

@override final  String code;
@override final  String summary;

/// Create a copy of PolicyInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolicyInfoCopyWith<_PolicyInfo> get copyWith => __$PolicyInfoCopyWithImpl<_PolicyInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolicyInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolicyInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,summary);

@override
String toString() {
  return 'PolicyInfo(code: $code, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$PolicyInfoCopyWith<$Res> implements $PolicyInfoCopyWith<$Res> {
  factory _$PolicyInfoCopyWith(_PolicyInfo value, $Res Function(_PolicyInfo) _then) = __$PolicyInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String summary
});




}
/// @nodoc
class __$PolicyInfoCopyWithImpl<$Res>
    implements _$PolicyInfoCopyWith<$Res> {
  __$PolicyInfoCopyWithImpl(this._self, this._then);

  final _PolicyInfo _self;
  final $Res Function(_PolicyInfo) _then;

/// Create a copy of PolicyInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? summary = null,}) {
  return _then(_PolicyInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AvailabilityInfo {

 bool get checked; bool? get available;
/// Create a copy of AvailabilityInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityInfoCopyWith<AvailabilityInfo> get copyWith => _$AvailabilityInfoCopyWithImpl<AvailabilityInfo>(this as AvailabilityInfo, _$identity);

  /// Serializes this AvailabilityInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityInfo&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checked,available);

@override
String toString() {
  return 'AvailabilityInfo(checked: $checked, available: $available)';
}


}

/// @nodoc
abstract mixin class $AvailabilityInfoCopyWith<$Res>  {
  factory $AvailabilityInfoCopyWith(AvailabilityInfo value, $Res Function(AvailabilityInfo) _then) = _$AvailabilityInfoCopyWithImpl;
@useResult
$Res call({
 bool checked, bool? available
});




}
/// @nodoc
class _$AvailabilityInfoCopyWithImpl<$Res>
    implements $AvailabilityInfoCopyWith<$Res> {
  _$AvailabilityInfoCopyWithImpl(this._self, this._then);

  final AvailabilityInfo _self;
  final $Res Function(AvailabilityInfo) _then;

/// Create a copy of AvailabilityInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checked = null,Object? available = freezed,}) {
  return _then(_self.copyWith(
checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,available: freezed == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityInfo].
extension AvailabilityInfoPatterns on AvailabilityInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityInfo value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityInfo value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool checked,  bool? available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityInfo() when $default != null:
return $default(_that.checked,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool checked,  bool? available)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityInfo():
return $default(_that.checked,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool checked,  bool? available)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityInfo() when $default != null:
return $default(_that.checked,_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityInfo implements AvailabilityInfo {
  const _AvailabilityInfo({this.checked = false, this.available});
  factory _AvailabilityInfo.fromJson(Map<String, dynamic> json) => _$AvailabilityInfoFromJson(json);

@override@JsonKey() final  bool checked;
@override final  bool? available;

/// Create a copy of AvailabilityInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityInfoCopyWith<_AvailabilityInfo> get copyWith => __$AvailabilityInfoCopyWithImpl<_AvailabilityInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityInfo&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checked,available);

@override
String toString() {
  return 'AvailabilityInfo(checked: $checked, available: $available)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityInfoCopyWith<$Res> implements $AvailabilityInfoCopyWith<$Res> {
  factory _$AvailabilityInfoCopyWith(_AvailabilityInfo value, $Res Function(_AvailabilityInfo) _then) = __$AvailabilityInfoCopyWithImpl;
@override @useResult
$Res call({
 bool checked, bool? available
});




}
/// @nodoc
class __$AvailabilityInfoCopyWithImpl<$Res>
    implements _$AvailabilityInfoCopyWith<$Res> {
  __$AvailabilityInfoCopyWithImpl(this._self, this._then);

  final _AvailabilityInfo _self;
  final $Res Function(_AvailabilityInfo) _then;

/// Create a copy of AvailabilityInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checked = null,Object? available = freezed,}) {
  return _then(_AvailabilityInfo(
checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,available: freezed == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$VehicleDetail {

 String get id; String get make; String get model; int get year;@JsonKey(unknownEnumValue: VehicleCategory.unknown) VehicleCategory get category;@JsonKey(unknownEnumValue: Transmission.unknown) Transmission get transmission;@JsonKey(unknownEnumValue: FuelType.unknown) FuelType get fuelType; int get seats; int get luggage; String? get coverImageUrl; Money get dailyRate; Money? get estimatedTotal; int? get days; CityRef get city; bool get deliveryAvailable; PartnerRef get partner; bool get isFavorite; List<VehicleImage> get images; int? get doors; String? get color; String? get description; List<String> get features; String get timezone; PickupLocation? get pickupLocation; Money get deliveryFee; MileagePolicy get mileagePolicy;@JsonKey(unknownEnumValue: FuelPolicy.unknown) FuelPolicy get fuelPolicy; Money get deposit; PolicyInfo get cancellationPolicy; String? get insuranceInfo; int get minRentalDays;@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode get bookingMode; AvailabilityInfo get availability;
/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleDetailCopyWith<VehicleDetail> get copyWith => _$VehicleDetailCopyWithImpl<VehicleDetail>(this as VehicleDetail, _$identity);

  /// Serializes this VehicleDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.category, category) || other.category == category)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.luggage, luggage) || other.luggage == luggage)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.dailyRate, dailyRate) || other.dailyRate == dailyRate)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&(identical(other.days, days) || other.days == days)&&(identical(other.city, city) || other.city == city)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.color, color) || other.color == color)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.pickupLocation, pickupLocation) || other.pickupLocation == pickupLocation)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.mileagePolicy, mileagePolicy) || other.mileagePolicy == mileagePolicy)&&(identical(other.fuelPolicy, fuelPolicy) || other.fuelPolicy == fuelPolicy)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.insuranceInfo, insuranceInfo) || other.insuranceInfo == insuranceInfo)&&(identical(other.minRentalDays, minRentalDays) || other.minRentalDays == minRentalDays)&&(identical(other.bookingMode, bookingMode) || other.bookingMode == bookingMode)&&(identical(other.availability, availability) || other.availability == availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,make,model,year,category,transmission,fuelType,seats,luggage,coverImageUrl,dailyRate,estimatedTotal,days,city,deliveryAvailable,partner,isFavorite,const DeepCollectionEquality().hash(images),doors,color,description,const DeepCollectionEquality().hash(features),timezone,pickupLocation,deliveryFee,mileagePolicy,fuelPolicy,deposit,cancellationPolicy,insuranceInfo,minRentalDays,bookingMode,availability]);

@override
String toString() {
  return 'VehicleDetail(id: $id, make: $make, model: $model, year: $year, category: $category, transmission: $transmission, fuelType: $fuelType, seats: $seats, luggage: $luggage, coverImageUrl: $coverImageUrl, dailyRate: $dailyRate, estimatedTotal: $estimatedTotal, days: $days, city: $city, deliveryAvailable: $deliveryAvailable, partner: $partner, isFavorite: $isFavorite, images: $images, doors: $doors, color: $color, description: $description, features: $features, timezone: $timezone, pickupLocation: $pickupLocation, deliveryFee: $deliveryFee, mileagePolicy: $mileagePolicy, fuelPolicy: $fuelPolicy, deposit: $deposit, cancellationPolicy: $cancellationPolicy, insuranceInfo: $insuranceInfo, minRentalDays: $minRentalDays, bookingMode: $bookingMode, availability: $availability)';
}


}

/// @nodoc
abstract mixin class $VehicleDetailCopyWith<$Res>  {
  factory $VehicleDetailCopyWith(VehicleDetail value, $Res Function(VehicleDetail) _then) = _$VehicleDetailCopyWithImpl;
@useResult
$Res call({
 String id, String make, String model, int year,@JsonKey(unknownEnumValue: VehicleCategory.unknown) VehicleCategory category,@JsonKey(unknownEnumValue: Transmission.unknown) Transmission transmission,@JsonKey(unknownEnumValue: FuelType.unknown) FuelType fuelType, int seats, int luggage, String? coverImageUrl, Money dailyRate, Money? estimatedTotal, int? days, CityRef city, bool deliveryAvailable, PartnerRef partner, bool isFavorite, List<VehicleImage> images, int? doors, String? color, String? description, List<String> features, String timezone, PickupLocation? pickupLocation, Money deliveryFee, MileagePolicy mileagePolicy,@JsonKey(unknownEnumValue: FuelPolicy.unknown) FuelPolicy fuelPolicy, Money deposit, PolicyInfo cancellationPolicy, String? insuranceInfo, int minRentalDays,@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode bookingMode, AvailabilityInfo availability
});


$CityRefCopyWith<$Res> get city;$PartnerRefCopyWith<$Res> get partner;$PickupLocationCopyWith<$Res>? get pickupLocation;$MileagePolicyCopyWith<$Res> get mileagePolicy;$PolicyInfoCopyWith<$Res> get cancellationPolicy;$AvailabilityInfoCopyWith<$Res> get availability;

}
/// @nodoc
class _$VehicleDetailCopyWithImpl<$Res>
    implements $VehicleDetailCopyWith<$Res> {
  _$VehicleDetailCopyWithImpl(this._self, this._then);

  final VehicleDetail _self;
  final $Res Function(VehicleDetail) _then;

/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? category = null,Object? transmission = null,Object? fuelType = null,Object? seats = null,Object? luggage = null,Object? coverImageUrl = freezed,Object? dailyRate = null,Object? estimatedTotal = freezed,Object? days = freezed,Object? city = null,Object? deliveryAvailable = null,Object? partner = null,Object? isFavorite = null,Object? images = null,Object? doors = freezed,Object? color = freezed,Object? description = freezed,Object? features = null,Object? timezone = null,Object? pickupLocation = freezed,Object? deliveryFee = null,Object? mileagePolicy = null,Object? fuelPolicy = null,Object? deposit = null,Object? cancellationPolicy = null,Object? insuranceInfo = freezed,Object? minRentalDays = null,Object? bookingMode = null,Object? availability = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as VehicleCategory,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as Transmission,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,luggage: null == luggage ? _self.luggage : luggage // ignore: cast_nullable_to_non_nullable
as int,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,dailyRate: null == dailyRate ? _self.dailyRate : dailyRate // ignore: cast_nullable_to_non_nullable
as Money,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as Money?,days: freezed == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerRef,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<VehicleImage>,doors: freezed == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,pickupLocation: freezed == pickupLocation ? _self.pickupLocation : pickupLocation // ignore: cast_nullable_to_non_nullable
as PickupLocation?,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as Money,mileagePolicy: null == mileagePolicy ? _self.mileagePolicy : mileagePolicy // ignore: cast_nullable_to_non_nullable
as MileagePolicy,fuelPolicy: null == fuelPolicy ? _self.fuelPolicy : fuelPolicy // ignore: cast_nullable_to_non_nullable
as FuelPolicy,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as Money,cancellationPolicy: null == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as PolicyInfo,insuranceInfo: freezed == insuranceInfo ? _self.insuranceInfo : insuranceInfo // ignore: cast_nullable_to_non_nullable
as String?,minRentalDays: null == minRentalDays ? _self.minRentalDays : minRentalDays // ignore: cast_nullable_to_non_nullable
as int,bookingMode: null == bookingMode ? _self.bookingMode : bookingMode // ignore: cast_nullable_to_non_nullable
as BookingMode,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as AvailabilityInfo,
  ));
}
/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerRefCopyWith<$Res> get partner {
  
  return $PartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PickupLocationCopyWith<$Res>? get pickupLocation {
    if (_self.pickupLocation == null) {
    return null;
  }

  return $PickupLocationCopyWith<$Res>(_self.pickupLocation!, (value) {
    return _then(_self.copyWith(pickupLocation: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MileagePolicyCopyWith<$Res> get mileagePolicy {
  
  return $MileagePolicyCopyWith<$Res>(_self.mileagePolicy, (value) {
    return _then(_self.copyWith(mileagePolicy: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<$Res> get cancellationPolicy {
  
  return $PolicyInfoCopyWith<$Res>(_self.cancellationPolicy, (value) {
    return _then(_self.copyWith(cancellationPolicy: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilityInfoCopyWith<$Res> get availability {
  
  return $AvailabilityInfoCopyWith<$Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}
}


/// Adds pattern-matching-related methods to [VehicleDetail].
extension VehicleDetailPatterns on VehicleDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleDetail value)  $default,){
final _that = this;
switch (_that) {
case _VehicleDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleDetail value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year, @JsonKey(unknownEnumValue: VehicleCategory.unknown)  VehicleCategory category, @JsonKey(unknownEnumValue: Transmission.unknown)  Transmission transmission, @JsonKey(unknownEnumValue: FuelType.unknown)  FuelType fuelType,  int seats,  int luggage,  String? coverImageUrl,  Money dailyRate,  Money? estimatedTotal,  int? days,  CityRef city,  bool deliveryAvailable,  PartnerRef partner,  bool isFavorite,  List<VehicleImage> images,  int? doors,  String? color,  String? description,  List<String> features,  String timezone,  PickupLocation? pickupLocation,  Money deliveryFee,  MileagePolicy mileagePolicy, @JsonKey(unknownEnumValue: FuelPolicy.unknown)  FuelPolicy fuelPolicy,  Money deposit,  PolicyInfo cancellationPolicy,  String? insuranceInfo,  int minRentalDays, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode,  AvailabilityInfo availability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleDetail() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.category,_that.transmission,_that.fuelType,_that.seats,_that.luggage,_that.coverImageUrl,_that.dailyRate,_that.estimatedTotal,_that.days,_that.city,_that.deliveryAvailable,_that.partner,_that.isFavorite,_that.images,_that.doors,_that.color,_that.description,_that.features,_that.timezone,_that.pickupLocation,_that.deliveryFee,_that.mileagePolicy,_that.fuelPolicy,_that.deposit,_that.cancellationPolicy,_that.insuranceInfo,_that.minRentalDays,_that.bookingMode,_that.availability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year, @JsonKey(unknownEnumValue: VehicleCategory.unknown)  VehicleCategory category, @JsonKey(unknownEnumValue: Transmission.unknown)  Transmission transmission, @JsonKey(unknownEnumValue: FuelType.unknown)  FuelType fuelType,  int seats,  int luggage,  String? coverImageUrl,  Money dailyRate,  Money? estimatedTotal,  int? days,  CityRef city,  bool deliveryAvailable,  PartnerRef partner,  bool isFavorite,  List<VehicleImage> images,  int? doors,  String? color,  String? description,  List<String> features,  String timezone,  PickupLocation? pickupLocation,  Money deliveryFee,  MileagePolicy mileagePolicy, @JsonKey(unknownEnumValue: FuelPolicy.unknown)  FuelPolicy fuelPolicy,  Money deposit,  PolicyInfo cancellationPolicy,  String? insuranceInfo,  int minRentalDays, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode,  AvailabilityInfo availability)  $default,) {final _that = this;
switch (_that) {
case _VehicleDetail():
return $default(_that.id,_that.make,_that.model,_that.year,_that.category,_that.transmission,_that.fuelType,_that.seats,_that.luggage,_that.coverImageUrl,_that.dailyRate,_that.estimatedTotal,_that.days,_that.city,_that.deliveryAvailable,_that.partner,_that.isFavorite,_that.images,_that.doors,_that.color,_that.description,_that.features,_that.timezone,_that.pickupLocation,_that.deliveryFee,_that.mileagePolicy,_that.fuelPolicy,_that.deposit,_that.cancellationPolicy,_that.insuranceInfo,_that.minRentalDays,_that.bookingMode,_that.availability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String make,  String model,  int year, @JsonKey(unknownEnumValue: VehicleCategory.unknown)  VehicleCategory category, @JsonKey(unknownEnumValue: Transmission.unknown)  Transmission transmission, @JsonKey(unknownEnumValue: FuelType.unknown)  FuelType fuelType,  int seats,  int luggage,  String? coverImageUrl,  Money dailyRate,  Money? estimatedTotal,  int? days,  CityRef city,  bool deliveryAvailable,  PartnerRef partner,  bool isFavorite,  List<VehicleImage> images,  int? doors,  String? color,  String? description,  List<String> features,  String timezone,  PickupLocation? pickupLocation,  Money deliveryFee,  MileagePolicy mileagePolicy, @JsonKey(unknownEnumValue: FuelPolicy.unknown)  FuelPolicy fuelPolicy,  Money deposit,  PolicyInfo cancellationPolicy,  String? insuranceInfo,  int minRentalDays, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode,  AvailabilityInfo availability)?  $default,) {final _that = this;
switch (_that) {
case _VehicleDetail() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.category,_that.transmission,_that.fuelType,_that.seats,_that.luggage,_that.coverImageUrl,_that.dailyRate,_that.estimatedTotal,_that.days,_that.city,_that.deliveryAvailable,_that.partner,_that.isFavorite,_that.images,_that.doors,_that.color,_that.description,_that.features,_that.timezone,_that.pickupLocation,_that.deliveryFee,_that.mileagePolicy,_that.fuelPolicy,_that.deposit,_that.cancellationPolicy,_that.insuranceInfo,_that.minRentalDays,_that.bookingMode,_that.availability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleDetail extends VehicleDetail {
  const _VehicleDetail({required this.id, required this.make, required this.model, required this.year, @JsonKey(unknownEnumValue: VehicleCategory.unknown) required this.category, @JsonKey(unknownEnumValue: Transmission.unknown) required this.transmission, @JsonKey(unknownEnumValue: FuelType.unknown) required this.fuelType, required this.seats, this.luggage = 0, this.coverImageUrl, required this.dailyRate, this.estimatedTotal, this.days, required this.city, this.deliveryAvailable = false, required this.partner, this.isFavorite = false, final  List<VehicleImage> images = const <VehicleImage>[], this.doors, this.color, this.description, final  List<String> features = const <String>[], required this.timezone, this.pickupLocation, required this.deliveryFee, required this.mileagePolicy, @JsonKey(unknownEnumValue: FuelPolicy.unknown) required this.fuelPolicy, required this.deposit, required this.cancellationPolicy, this.insuranceInfo, this.minRentalDays = 1, @JsonKey(unknownEnumValue: BookingMode.unknown) required this.bookingMode, this.availability = const AvailabilityInfo()}): _images = images,_features = features,super._();
  factory _VehicleDetail.fromJson(Map<String, dynamic> json) => _$VehicleDetailFromJson(json);

@override final  String id;
@override final  String make;
@override final  String model;
@override final  int year;
@override@JsonKey(unknownEnumValue: VehicleCategory.unknown) final  VehicleCategory category;
@override@JsonKey(unknownEnumValue: Transmission.unknown) final  Transmission transmission;
@override@JsonKey(unknownEnumValue: FuelType.unknown) final  FuelType fuelType;
@override final  int seats;
@override@JsonKey() final  int luggage;
@override final  String? coverImageUrl;
@override final  Money dailyRate;
@override final  Money? estimatedTotal;
@override final  int? days;
@override final  CityRef city;
@override@JsonKey() final  bool deliveryAvailable;
@override final  PartnerRef partner;
@override@JsonKey() final  bool isFavorite;
 final  List<VehicleImage> _images;
@override@JsonKey() List<VehicleImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  int? doors;
@override final  String? color;
@override final  String? description;
 final  List<String> _features;
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

@override final  String timezone;
@override final  PickupLocation? pickupLocation;
@override final  Money deliveryFee;
@override final  MileagePolicy mileagePolicy;
@override@JsonKey(unknownEnumValue: FuelPolicy.unknown) final  FuelPolicy fuelPolicy;
@override final  Money deposit;
@override final  PolicyInfo cancellationPolicy;
@override final  String? insuranceInfo;
@override@JsonKey() final  int minRentalDays;
@override@JsonKey(unknownEnumValue: BookingMode.unknown) final  BookingMode bookingMode;
@override@JsonKey() final  AvailabilityInfo availability;

/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleDetailCopyWith<_VehicleDetail> get copyWith => __$VehicleDetailCopyWithImpl<_VehicleDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.category, category) || other.category == category)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.luggage, luggage) || other.luggage == luggage)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.dailyRate, dailyRate) || other.dailyRate == dailyRate)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&(identical(other.days, days) || other.days == days)&&(identical(other.city, city) || other.city == city)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.color, color) || other.color == color)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.pickupLocation, pickupLocation) || other.pickupLocation == pickupLocation)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.mileagePolicy, mileagePolicy) || other.mileagePolicy == mileagePolicy)&&(identical(other.fuelPolicy, fuelPolicy) || other.fuelPolicy == fuelPolicy)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.insuranceInfo, insuranceInfo) || other.insuranceInfo == insuranceInfo)&&(identical(other.minRentalDays, minRentalDays) || other.minRentalDays == minRentalDays)&&(identical(other.bookingMode, bookingMode) || other.bookingMode == bookingMode)&&(identical(other.availability, availability) || other.availability == availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,make,model,year,category,transmission,fuelType,seats,luggage,coverImageUrl,dailyRate,estimatedTotal,days,city,deliveryAvailable,partner,isFavorite,const DeepCollectionEquality().hash(_images),doors,color,description,const DeepCollectionEquality().hash(_features),timezone,pickupLocation,deliveryFee,mileagePolicy,fuelPolicy,deposit,cancellationPolicy,insuranceInfo,minRentalDays,bookingMode,availability]);

@override
String toString() {
  return 'VehicleDetail(id: $id, make: $make, model: $model, year: $year, category: $category, transmission: $transmission, fuelType: $fuelType, seats: $seats, luggage: $luggage, coverImageUrl: $coverImageUrl, dailyRate: $dailyRate, estimatedTotal: $estimatedTotal, days: $days, city: $city, deliveryAvailable: $deliveryAvailable, partner: $partner, isFavorite: $isFavorite, images: $images, doors: $doors, color: $color, description: $description, features: $features, timezone: $timezone, pickupLocation: $pickupLocation, deliveryFee: $deliveryFee, mileagePolicy: $mileagePolicy, fuelPolicy: $fuelPolicy, deposit: $deposit, cancellationPolicy: $cancellationPolicy, insuranceInfo: $insuranceInfo, minRentalDays: $minRentalDays, bookingMode: $bookingMode, availability: $availability)';
}


}

/// @nodoc
abstract mixin class _$VehicleDetailCopyWith<$Res> implements $VehicleDetailCopyWith<$Res> {
  factory _$VehicleDetailCopyWith(_VehicleDetail value, $Res Function(_VehicleDetail) _then) = __$VehicleDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String make, String model, int year,@JsonKey(unknownEnumValue: VehicleCategory.unknown) VehicleCategory category,@JsonKey(unknownEnumValue: Transmission.unknown) Transmission transmission,@JsonKey(unknownEnumValue: FuelType.unknown) FuelType fuelType, int seats, int luggage, String? coverImageUrl, Money dailyRate, Money? estimatedTotal, int? days, CityRef city, bool deliveryAvailable, PartnerRef partner, bool isFavorite, List<VehicleImage> images, int? doors, String? color, String? description, List<String> features, String timezone, PickupLocation? pickupLocation, Money deliveryFee, MileagePolicy mileagePolicy,@JsonKey(unknownEnumValue: FuelPolicy.unknown) FuelPolicy fuelPolicy, Money deposit, PolicyInfo cancellationPolicy, String? insuranceInfo, int minRentalDays,@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode bookingMode, AvailabilityInfo availability
});


@override $CityRefCopyWith<$Res> get city;@override $PartnerRefCopyWith<$Res> get partner;@override $PickupLocationCopyWith<$Res>? get pickupLocation;@override $MileagePolicyCopyWith<$Res> get mileagePolicy;@override $PolicyInfoCopyWith<$Res> get cancellationPolicy;@override $AvailabilityInfoCopyWith<$Res> get availability;

}
/// @nodoc
class __$VehicleDetailCopyWithImpl<$Res>
    implements _$VehicleDetailCopyWith<$Res> {
  __$VehicleDetailCopyWithImpl(this._self, this._then);

  final _VehicleDetail _self;
  final $Res Function(_VehicleDetail) _then;

/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? category = null,Object? transmission = null,Object? fuelType = null,Object? seats = null,Object? luggage = null,Object? coverImageUrl = freezed,Object? dailyRate = null,Object? estimatedTotal = freezed,Object? days = freezed,Object? city = null,Object? deliveryAvailable = null,Object? partner = null,Object? isFavorite = null,Object? images = null,Object? doors = freezed,Object? color = freezed,Object? description = freezed,Object? features = null,Object? timezone = null,Object? pickupLocation = freezed,Object? deliveryFee = null,Object? mileagePolicy = null,Object? fuelPolicy = null,Object? deposit = null,Object? cancellationPolicy = null,Object? insuranceInfo = freezed,Object? minRentalDays = null,Object? bookingMode = null,Object? availability = null,}) {
  return _then(_VehicleDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as VehicleCategory,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as Transmission,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,luggage: null == luggage ? _self.luggage : luggage // ignore: cast_nullable_to_non_nullable
as int,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,dailyRate: null == dailyRate ? _self.dailyRate : dailyRate // ignore: cast_nullable_to_non_nullable
as Money,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as Money?,days: freezed == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerRef,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<VehicleImage>,doors: freezed == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,pickupLocation: freezed == pickupLocation ? _self.pickupLocation : pickupLocation // ignore: cast_nullable_to_non_nullable
as PickupLocation?,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as Money,mileagePolicy: null == mileagePolicy ? _self.mileagePolicy : mileagePolicy // ignore: cast_nullable_to_non_nullable
as MileagePolicy,fuelPolicy: null == fuelPolicy ? _self.fuelPolicy : fuelPolicy // ignore: cast_nullable_to_non_nullable
as FuelPolicy,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as Money,cancellationPolicy: null == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as PolicyInfo,insuranceInfo: freezed == insuranceInfo ? _self.insuranceInfo : insuranceInfo // ignore: cast_nullable_to_non_nullable
as String?,minRentalDays: null == minRentalDays ? _self.minRentalDays : minRentalDays // ignore: cast_nullable_to_non_nullable
as int,bookingMode: null == bookingMode ? _self.bookingMode : bookingMode // ignore: cast_nullable_to_non_nullable
as BookingMode,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as AvailabilityInfo,
  ));
}

/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerRefCopyWith<$Res> get partner {
  
  return $PartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PickupLocationCopyWith<$Res>? get pickupLocation {
    if (_self.pickupLocation == null) {
    return null;
  }

  return $PickupLocationCopyWith<$Res>(_self.pickupLocation!, (value) {
    return _then(_self.copyWith(pickupLocation: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MileagePolicyCopyWith<$Res> get mileagePolicy {
  
  return $MileagePolicyCopyWith<$Res>(_self.mileagePolicy, (value) {
    return _then(_self.copyWith(mileagePolicy: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<$Res> get cancellationPolicy {
  
  return $PolicyInfoCopyWith<$Res>(_self.cancellationPolicy, (value) {
    return _then(_self.copyWith(cancellationPolicy: value));
  });
}/// Create a copy of VehicleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilityInfoCopyWith<$Res> get availability {
  
  return $AvailabilityInfoCopyWith<$Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}
}

// dart format on
