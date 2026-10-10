// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingVehicleRef {

 String get id; String get make; String get model; int get year; String? get coverImageUrl;
/// Create a copy of BookingVehicleRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingVehicleRefCopyWith<BookingVehicleRef> get copyWith => _$BookingVehicleRefCopyWithImpl<BookingVehicleRef>(this as BookingVehicleRef, _$identity);

  /// Serializes this BookingVehicleRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingVehicleRef&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,make,model,year,coverImageUrl);

@override
String toString() {
  return 'BookingVehicleRef(id: $id, make: $make, model: $model, year: $year, coverImageUrl: $coverImageUrl)';
}


}

/// @nodoc
abstract mixin class $BookingVehicleRefCopyWith<$Res>  {
  factory $BookingVehicleRefCopyWith(BookingVehicleRef value, $Res Function(BookingVehicleRef) _then) = _$BookingVehicleRefCopyWithImpl;
@useResult
$Res call({
 String id, String make, String model, int year, String? coverImageUrl
});




}
/// @nodoc
class _$BookingVehicleRefCopyWithImpl<$Res>
    implements $BookingVehicleRefCopyWith<$Res> {
  _$BookingVehicleRefCopyWithImpl(this._self, this._then);

  final BookingVehicleRef _self;
  final $Res Function(BookingVehicleRef) _then;

/// Create a copy of BookingVehicleRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? coverImageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingVehicleRef].
extension BookingVehicleRefPatterns on BookingVehicleRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingVehicleRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingVehicleRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingVehicleRef value)  $default,){
final _that = this;
switch (_that) {
case _BookingVehicleRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingVehicleRef value)?  $default,){
final _that = this;
switch (_that) {
case _BookingVehicleRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year,  String? coverImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingVehicleRef() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.coverImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year,  String? coverImageUrl)  $default,) {final _that = this;
switch (_that) {
case _BookingVehicleRef():
return $default(_that.id,_that.make,_that.model,_that.year,_that.coverImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String make,  String model,  int year,  String? coverImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _BookingVehicleRef() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.coverImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingVehicleRef extends BookingVehicleRef {
  const _BookingVehicleRef({required this.id, required this.make, required this.model, required this.year, this.coverImageUrl}): super._();
  factory _BookingVehicleRef.fromJson(Map<String, dynamic> json) => _$BookingVehicleRefFromJson(json);

@override final  String id;
@override final  String make;
@override final  String model;
@override final  int year;
@override final  String? coverImageUrl;

/// Create a copy of BookingVehicleRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingVehicleRefCopyWith<_BookingVehicleRef> get copyWith => __$BookingVehicleRefCopyWithImpl<_BookingVehicleRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingVehicleRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingVehicleRef&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,make,model,year,coverImageUrl);

@override
String toString() {
  return 'BookingVehicleRef(id: $id, make: $make, model: $model, year: $year, coverImageUrl: $coverImageUrl)';
}


}

/// @nodoc
abstract mixin class _$BookingVehicleRefCopyWith<$Res> implements $BookingVehicleRefCopyWith<$Res> {
  factory _$BookingVehicleRefCopyWith(_BookingVehicleRef value, $Res Function(_BookingVehicleRef) _then) = __$BookingVehicleRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String make, String model, int year, String? coverImageUrl
});




}
/// @nodoc
class __$BookingVehicleRefCopyWithImpl<$Res>
    implements _$BookingVehicleRefCopyWith<$Res> {
  __$BookingVehicleRefCopyWithImpl(this._self, this._then);

  final _BookingVehicleRef _self;
  final $Res Function(_BookingVehicleRef) _then;

/// Create a copy of BookingVehicleRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? coverImageUrl = freezed,}) {
  return _then(_BookingVehicleRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BookingPartnerRef {

 String get id; String get displayName;
/// Create a copy of BookingPartnerRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPartnerRefCopyWith<BookingPartnerRef> get copyWith => _$BookingPartnerRefCopyWithImpl<BookingPartnerRef>(this as BookingPartnerRef, _$identity);

  /// Serializes this BookingPartnerRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPartnerRef&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName);

@override
String toString() {
  return 'BookingPartnerRef(id: $id, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $BookingPartnerRefCopyWith<$Res>  {
  factory $BookingPartnerRefCopyWith(BookingPartnerRef value, $Res Function(BookingPartnerRef) _then) = _$BookingPartnerRefCopyWithImpl;
@useResult
$Res call({
 String id, String displayName
});




}
/// @nodoc
class _$BookingPartnerRefCopyWithImpl<$Res>
    implements $BookingPartnerRefCopyWith<$Res> {
  _$BookingPartnerRefCopyWithImpl(this._self, this._then);

  final BookingPartnerRef _self;
  final $Res Function(BookingPartnerRef) _then;

/// Create a copy of BookingPartnerRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingPartnerRef].
extension BookingPartnerRefPatterns on BookingPartnerRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingPartnerRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingPartnerRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingPartnerRef value)  $default,){
final _that = this;
switch (_that) {
case _BookingPartnerRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingPartnerRef value)?  $default,){
final _that = this;
switch (_that) {
case _BookingPartnerRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingPartnerRef() when $default != null:
return $default(_that.id,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName)  $default,) {final _that = this;
switch (_that) {
case _BookingPartnerRef():
return $default(_that.id,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _BookingPartnerRef() when $default != null:
return $default(_that.id,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingPartnerRef implements BookingPartnerRef {
  const _BookingPartnerRef({required this.id, required this.displayName});
  factory _BookingPartnerRef.fromJson(Map<String, dynamic> json) => _$BookingPartnerRefFromJson(json);

@override final  String id;
@override final  String displayName;

/// Create a copy of BookingPartnerRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingPartnerRefCopyWith<_BookingPartnerRef> get copyWith => __$BookingPartnerRefCopyWithImpl<_BookingPartnerRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingPartnerRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingPartnerRef&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName);

@override
String toString() {
  return 'BookingPartnerRef(id: $id, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$BookingPartnerRefCopyWith<$Res> implements $BookingPartnerRefCopyWith<$Res> {
  factory _$BookingPartnerRefCopyWith(_BookingPartnerRef value, $Res Function(_BookingPartnerRef) _then) = __$BookingPartnerRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName
});




}
/// @nodoc
class __$BookingPartnerRefCopyWithImpl<$Res>
    implements _$BookingPartnerRefCopyWith<$Res> {
  __$BookingPartnerRefCopyWithImpl(this._self, this._then);

  final _BookingPartnerRef _self;
  final $Res Function(_BookingPartnerRef) _then;

/// Create a copy of BookingPartnerRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,}) {
  return _then(_BookingPartnerRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BookingSummary {

 String get id; String get reference;@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus get status;@JsonKey(unknownEnumValue: PaymentStatus.unknown) PaymentStatus get paymentStatus; DateTime get pickupAt; DateTime get returnAt; Money get total; BookingVehicleRef get vehicle; BookingPartnerRef get partner; CityRef get city; String get timezone;
/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSummaryCopyWith<BookingSummary> get copyWith => _$BookingSummaryCopyWithImpl<BookingSummary>(this as BookingSummary, _$identity);

  /// Serializes this BookingSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.pickupAt, pickupAt) || other.pickupAt == pickupAt)&&(identical(other.returnAt, returnAt) || other.returnAt == returnAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.city, city) || other.city == city)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reference,status,paymentStatus,pickupAt,returnAt,total,vehicle,partner,city,timezone);

@override
String toString() {
  return 'BookingSummary(id: $id, reference: $reference, status: $status, paymentStatus: $paymentStatus, pickupAt: $pickupAt, returnAt: $returnAt, total: $total, vehicle: $vehicle, partner: $partner, city: $city, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class $BookingSummaryCopyWith<$Res>  {
  factory $BookingSummaryCopyWith(BookingSummary value, $Res Function(BookingSummary) _then) = _$BookingSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String reference,@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus status,@JsonKey(unknownEnumValue: PaymentStatus.unknown) PaymentStatus paymentStatus, DateTime pickupAt, DateTime returnAt, Money total, BookingVehicleRef vehicle, BookingPartnerRef partner, CityRef city, String timezone
});


$BookingVehicleRefCopyWith<$Res> get vehicle;$BookingPartnerRefCopyWith<$Res> get partner;$CityRefCopyWith<$Res> get city;

}
/// @nodoc
class _$BookingSummaryCopyWithImpl<$Res>
    implements $BookingSummaryCopyWith<$Res> {
  _$BookingSummaryCopyWithImpl(this._self, this._then);

  final BookingSummary _self;
  final $Res Function(BookingSummary) _then;

/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? status = null,Object? paymentStatus = null,Object? pickupAt = null,Object? returnAt = null,Object? total = null,Object? vehicle = null,Object? partner = null,Object? city = null,Object? timezone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,pickupAt: null == pickupAt ? _self.pickupAt : pickupAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnAt: null == returnAt ? _self.returnAt : returnAt // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as BookingVehicleRef,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as BookingPartnerRef,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVehicleRefCopyWith<$Res> get vehicle {
  
  return $BookingVehicleRefCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingPartnerRefCopyWith<$Res> get partner {
  
  return $BookingPartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingSummary].
extension BookingSummaryPatterns on BookingSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingSummary value)  $default,){
final _that = this;
switch (_that) {
case _BookingSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingSummary value)?  $default,){
final _that = this;
switch (_that) {
case _BookingSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus status, @JsonKey(unknownEnumValue: PaymentStatus.unknown)  PaymentStatus paymentStatus,  DateTime pickupAt,  DateTime returnAt,  Money total,  BookingVehicleRef vehicle,  BookingPartnerRef partner,  CityRef city,  String timezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingSummary() when $default != null:
return $default(_that.id,_that.reference,_that.status,_that.paymentStatus,_that.pickupAt,_that.returnAt,_that.total,_that.vehicle,_that.partner,_that.city,_that.timezone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus status, @JsonKey(unknownEnumValue: PaymentStatus.unknown)  PaymentStatus paymentStatus,  DateTime pickupAt,  DateTime returnAt,  Money total,  BookingVehicleRef vehicle,  BookingPartnerRef partner,  CityRef city,  String timezone)  $default,) {final _that = this;
switch (_that) {
case _BookingSummary():
return $default(_that.id,_that.reference,_that.status,_that.paymentStatus,_that.pickupAt,_that.returnAt,_that.total,_that.vehicle,_that.partner,_that.city,_that.timezone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus status, @JsonKey(unknownEnumValue: PaymentStatus.unknown)  PaymentStatus paymentStatus,  DateTime pickupAt,  DateTime returnAt,  Money total,  BookingVehicleRef vehicle,  BookingPartnerRef partner,  CityRef city,  String timezone)?  $default,) {final _that = this;
switch (_that) {
case _BookingSummary() when $default != null:
return $default(_that.id,_that.reference,_that.status,_that.paymentStatus,_that.pickupAt,_that.returnAt,_that.total,_that.vehicle,_that.partner,_that.city,_that.timezone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingSummary implements BookingSummary {
  const _BookingSummary({required this.id, required this.reference, @JsonKey(unknownEnumValue: BookingStatus.unknown) required this.status, @JsonKey(unknownEnumValue: PaymentStatus.unknown) required this.paymentStatus, required this.pickupAt, required this.returnAt, required this.total, required this.vehicle, required this.partner, required this.city, required this.timezone});
  factory _BookingSummary.fromJson(Map<String, dynamic> json) => _$BookingSummaryFromJson(json);

@override final  String id;
@override final  String reference;
@override@JsonKey(unknownEnumValue: BookingStatus.unknown) final  BookingStatus status;
@override@JsonKey(unknownEnumValue: PaymentStatus.unknown) final  PaymentStatus paymentStatus;
@override final  DateTime pickupAt;
@override final  DateTime returnAt;
@override final  Money total;
@override final  BookingVehicleRef vehicle;
@override final  BookingPartnerRef partner;
@override final  CityRef city;
@override final  String timezone;

/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingSummaryCopyWith<_BookingSummary> get copyWith => __$BookingSummaryCopyWithImpl<_BookingSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.pickupAt, pickupAt) || other.pickupAt == pickupAt)&&(identical(other.returnAt, returnAt) || other.returnAt == returnAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.city, city) || other.city == city)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reference,status,paymentStatus,pickupAt,returnAt,total,vehicle,partner,city,timezone);

@override
String toString() {
  return 'BookingSummary(id: $id, reference: $reference, status: $status, paymentStatus: $paymentStatus, pickupAt: $pickupAt, returnAt: $returnAt, total: $total, vehicle: $vehicle, partner: $partner, city: $city, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class _$BookingSummaryCopyWith<$Res> implements $BookingSummaryCopyWith<$Res> {
  factory _$BookingSummaryCopyWith(_BookingSummary value, $Res Function(_BookingSummary) _then) = __$BookingSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference,@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus status,@JsonKey(unknownEnumValue: PaymentStatus.unknown) PaymentStatus paymentStatus, DateTime pickupAt, DateTime returnAt, Money total, BookingVehicleRef vehicle, BookingPartnerRef partner, CityRef city, String timezone
});


@override $BookingVehicleRefCopyWith<$Res> get vehicle;@override $BookingPartnerRefCopyWith<$Res> get partner;@override $CityRefCopyWith<$Res> get city;

}
/// @nodoc
class __$BookingSummaryCopyWithImpl<$Res>
    implements _$BookingSummaryCopyWith<$Res> {
  __$BookingSummaryCopyWithImpl(this._self, this._then);

  final _BookingSummary _self;
  final $Res Function(_BookingSummary) _then;

/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? status = null,Object? paymentStatus = null,Object? pickupAt = null,Object? returnAt = null,Object? total = null,Object? vehicle = null,Object? partner = null,Object? city = null,Object? timezone = null,}) {
  return _then(_BookingSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,pickupAt: null == pickupAt ? _self.pickupAt : pickupAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnAt: null == returnAt ? _self.returnAt : returnAt // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as BookingVehicleRef,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as BookingPartnerRef,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVehicleRefCopyWith<$Res> get vehicle {
  
  return $BookingVehicleRefCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingPartnerRefCopyWith<$Res> get partner {
  
  return $BookingPartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of BookingSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}


/// @nodoc
mixin _$DeliveryInfo {

 bool get enabled; String? get address;
/// Create a copy of DeliveryInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryInfoCopyWith<DeliveryInfo> get copyWith => _$DeliveryInfoCopyWithImpl<DeliveryInfo>(this as DeliveryInfo, _$identity);

  /// Serializes this DeliveryInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryInfo&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,address);

@override
String toString() {
  return 'DeliveryInfo(enabled: $enabled, address: $address)';
}


}

/// @nodoc
abstract mixin class $DeliveryInfoCopyWith<$Res>  {
  factory $DeliveryInfoCopyWith(DeliveryInfo value, $Res Function(DeliveryInfo) _then) = _$DeliveryInfoCopyWithImpl;
@useResult
$Res call({
 bool enabled, String? address
});




}
/// @nodoc
class _$DeliveryInfoCopyWithImpl<$Res>
    implements $DeliveryInfoCopyWith<$Res> {
  _$DeliveryInfoCopyWithImpl(this._self, this._then);

  final DeliveryInfo _self;
  final $Res Function(DeliveryInfo) _then;

/// Create a copy of DeliveryInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? address = freezed,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryInfo].
extension DeliveryInfoPatterns on DeliveryInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryInfo value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryInfo() when $default != null:
return $default(_that.enabled,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  String? address)  $default,) {final _that = this;
switch (_that) {
case _DeliveryInfo():
return $default(_that.enabled,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryInfo() when $default != null:
return $default(_that.enabled,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeliveryInfo implements DeliveryInfo {
  const _DeliveryInfo({this.enabled = false, this.address});
  factory _DeliveryInfo.fromJson(Map<String, dynamic> json) => _$DeliveryInfoFromJson(json);

@override@JsonKey() final  bool enabled;
@override final  String? address;

/// Create a copy of DeliveryInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryInfoCopyWith<_DeliveryInfo> get copyWith => __$DeliveryInfoCopyWithImpl<_DeliveryInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryInfo&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,address);

@override
String toString() {
  return 'DeliveryInfo(enabled: $enabled, address: $address)';
}


}

/// @nodoc
abstract mixin class _$DeliveryInfoCopyWith<$Res> implements $DeliveryInfoCopyWith<$Res> {
  factory _$DeliveryInfoCopyWith(_DeliveryInfo value, $Res Function(_DeliveryInfo) _then) = __$DeliveryInfoCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String? address
});




}
/// @nodoc
class __$DeliveryInfoCopyWithImpl<$Res>
    implements _$DeliveryInfoCopyWith<$Res> {
  __$DeliveryInfoCopyWithImpl(this._self, this._then);

  final _DeliveryInfo _self;
  final $Res Function(_DeliveryInfo) _then;

/// Create a copy of DeliveryInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? address = freezed,}) {
  return _then(_DeliveryInfo(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DriverInfo {

 String get fullName; String? get phone;
/// Create a copy of DriverInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverInfoCopyWith<DriverInfo> get copyWith => _$DriverInfoCopyWithImpl<DriverInfo>(this as DriverInfo, _$identity);

  /// Serializes this DriverInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverInfo&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,phone);

@override
String toString() {
  return 'DriverInfo(fullName: $fullName, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $DriverInfoCopyWith<$Res>  {
  factory $DriverInfoCopyWith(DriverInfo value, $Res Function(DriverInfo) _then) = _$DriverInfoCopyWithImpl;
@useResult
$Res call({
 String fullName, String? phone
});




}
/// @nodoc
class _$DriverInfoCopyWithImpl<$Res>
    implements $DriverInfoCopyWith<$Res> {
  _$DriverInfoCopyWithImpl(this._self, this._then);

  final DriverInfo _self;
  final $Res Function(DriverInfo) _then;

/// Create a copy of DriverInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? phone = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverInfo].
extension DriverInfoPatterns on DriverInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverInfo value)  $default,){
final _that = this;
switch (_that) {
case _DriverInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DriverInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverInfo() when $default != null:
return $default(_that.fullName,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _DriverInfo():
return $default(_that.fullName,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _DriverInfo() when $default != null:
return $default(_that.fullName,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriverInfo implements DriverInfo {
  const _DriverInfo({required this.fullName, this.phone});
  factory _DriverInfo.fromJson(Map<String, dynamic> json) => _$DriverInfoFromJson(json);

@override final  String fullName;
@override final  String? phone;

/// Create a copy of DriverInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverInfoCopyWith<_DriverInfo> get copyWith => __$DriverInfoCopyWithImpl<_DriverInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverInfo&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,phone);

@override
String toString() {
  return 'DriverInfo(fullName: $fullName, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$DriverInfoCopyWith<$Res> implements $DriverInfoCopyWith<$Res> {
  factory _$DriverInfoCopyWith(_DriverInfo value, $Res Function(_DriverInfo) _then) = __$DriverInfoCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String? phone
});




}
/// @nodoc
class __$DriverInfoCopyWithImpl<$Res>
    implements _$DriverInfoCopyWith<$Res> {
  __$DriverInfoCopyWithImpl(this._self, this._then);

  final _DriverInfo _self;
  final $Res Function(_DriverInfo) _then;

/// Create a copy of DriverInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? phone = freezed,}) {
  return _then(_DriverInfo(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DamageNote {

 String? get area; String? get severity; String? get description; bool get isNew;
/// Create a copy of DamageNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DamageNoteCopyWith<DamageNote> get copyWith => _$DamageNoteCopyWithImpl<DamageNote>(this as DamageNote, _$identity);

  /// Serializes this DamageNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DamageNote&&(identical(other.area, area) || other.area == area)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&(identical(other.isNew, isNew) || other.isNew == isNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area,severity,description,isNew);

@override
String toString() {
  return 'DamageNote(area: $area, severity: $severity, description: $description, isNew: $isNew)';
}


}

/// @nodoc
abstract mixin class $DamageNoteCopyWith<$Res>  {
  factory $DamageNoteCopyWith(DamageNote value, $Res Function(DamageNote) _then) = _$DamageNoteCopyWithImpl;
@useResult
$Res call({
 String? area, String? severity, String? description, bool isNew
});




}
/// @nodoc
class _$DamageNoteCopyWithImpl<$Res>
    implements $DamageNoteCopyWith<$Res> {
  _$DamageNoteCopyWithImpl(this._self, this._then);

  final DamageNote _self;
  final $Res Function(DamageNote) _then;

/// Create a copy of DamageNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? area = freezed,Object? severity = freezed,Object? description = freezed,Object? isNew = null,}) {
  return _then(_self.copyWith(
area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DamageNote].
extension DamageNotePatterns on DamageNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DamageNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DamageNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DamageNote value)  $default,){
final _that = this;
switch (_that) {
case _DamageNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DamageNote value)?  $default,){
final _that = this;
switch (_that) {
case _DamageNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? area,  String? severity,  String? description,  bool isNew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DamageNote() when $default != null:
return $default(_that.area,_that.severity,_that.description,_that.isNew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? area,  String? severity,  String? description,  bool isNew)  $default,) {final _that = this;
switch (_that) {
case _DamageNote():
return $default(_that.area,_that.severity,_that.description,_that.isNew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? area,  String? severity,  String? description,  bool isNew)?  $default,) {final _that = this;
switch (_that) {
case _DamageNote() when $default != null:
return $default(_that.area,_that.severity,_that.description,_that.isNew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DamageNote implements DamageNote {
  const _DamageNote({this.area, this.severity, this.description, this.isNew = false});
  factory _DamageNote.fromJson(Map<String, dynamic> json) => _$DamageNoteFromJson(json);

@override final  String? area;
@override final  String? severity;
@override final  String? description;
@override@JsonKey() final  bool isNew;

/// Create a copy of DamageNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DamageNoteCopyWith<_DamageNote> get copyWith => __$DamageNoteCopyWithImpl<_DamageNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DamageNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DamageNote&&(identical(other.area, area) || other.area == area)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&(identical(other.isNew, isNew) || other.isNew == isNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area,severity,description,isNew);

@override
String toString() {
  return 'DamageNote(area: $area, severity: $severity, description: $description, isNew: $isNew)';
}


}

/// @nodoc
abstract mixin class _$DamageNoteCopyWith<$Res> implements $DamageNoteCopyWith<$Res> {
  factory _$DamageNoteCopyWith(_DamageNote value, $Res Function(_DamageNote) _then) = __$DamageNoteCopyWithImpl;
@override @useResult
$Res call({
 String? area, String? severity, String? description, bool isNew
});




}
/// @nodoc
class __$DamageNoteCopyWithImpl<$Res>
    implements _$DamageNoteCopyWith<$Res> {
  __$DamageNoteCopyWithImpl(this._self, this._then);

  final _DamageNote _self;
  final $Res Function(_DamageNote) _then;

/// Create a copy of DamageNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? area = freezed,Object? severity = freezed,Object? description = freezed,Object? isNew = null,}) {
  return _then(_DamageNote(
area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ConditionReportSummary {

 DateTime get recordedAt; int? get odometerKm; int? get fuelLevelPct; List<DamageNote> get damages; int get photoCount;
/// Create a copy of ConditionReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConditionReportSummaryCopyWith<ConditionReportSummary> get copyWith => _$ConditionReportSummaryCopyWithImpl<ConditionReportSummary>(this as ConditionReportSummary, _$identity);

  /// Serializes this ConditionReportSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConditionReportSummary&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.odometerKm, odometerKm) || other.odometerKm == odometerKm)&&(identical(other.fuelLevelPct, fuelLevelPct) || other.fuelLevelPct == fuelLevelPct)&&const DeepCollectionEquality().equals(other.damages, damages)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recordedAt,odometerKm,fuelLevelPct,const DeepCollectionEquality().hash(damages),photoCount);

@override
String toString() {
  return 'ConditionReportSummary(recordedAt: $recordedAt, odometerKm: $odometerKm, fuelLevelPct: $fuelLevelPct, damages: $damages, photoCount: $photoCount)';
}


}

/// @nodoc
abstract mixin class $ConditionReportSummaryCopyWith<$Res>  {
  factory $ConditionReportSummaryCopyWith(ConditionReportSummary value, $Res Function(ConditionReportSummary) _then) = _$ConditionReportSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime recordedAt, int? odometerKm, int? fuelLevelPct, List<DamageNote> damages, int photoCount
});




}
/// @nodoc
class _$ConditionReportSummaryCopyWithImpl<$Res>
    implements $ConditionReportSummaryCopyWith<$Res> {
  _$ConditionReportSummaryCopyWithImpl(this._self, this._then);

  final ConditionReportSummary _self;
  final $Res Function(ConditionReportSummary) _then;

/// Create a copy of ConditionReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recordedAt = null,Object? odometerKm = freezed,Object? fuelLevelPct = freezed,Object? damages = null,Object? photoCount = null,}) {
  return _then(_self.copyWith(
recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,odometerKm: freezed == odometerKm ? _self.odometerKm : odometerKm // ignore: cast_nullable_to_non_nullable
as int?,fuelLevelPct: freezed == fuelLevelPct ? _self.fuelLevelPct : fuelLevelPct // ignore: cast_nullable_to_non_nullable
as int?,damages: null == damages ? _self.damages : damages // ignore: cast_nullable_to_non_nullable
as List<DamageNote>,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ConditionReportSummary].
extension ConditionReportSummaryPatterns on ConditionReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConditionReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConditionReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConditionReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _ConditionReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConditionReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ConditionReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime recordedAt,  int? odometerKm,  int? fuelLevelPct,  List<DamageNote> damages,  int photoCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConditionReportSummary() when $default != null:
return $default(_that.recordedAt,_that.odometerKm,_that.fuelLevelPct,_that.damages,_that.photoCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime recordedAt,  int? odometerKm,  int? fuelLevelPct,  List<DamageNote> damages,  int photoCount)  $default,) {final _that = this;
switch (_that) {
case _ConditionReportSummary():
return $default(_that.recordedAt,_that.odometerKm,_that.fuelLevelPct,_that.damages,_that.photoCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime recordedAt,  int? odometerKm,  int? fuelLevelPct,  List<DamageNote> damages,  int photoCount)?  $default,) {final _that = this;
switch (_that) {
case _ConditionReportSummary() when $default != null:
return $default(_that.recordedAt,_that.odometerKm,_that.fuelLevelPct,_that.damages,_that.photoCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConditionReportSummary implements ConditionReportSummary {
  const _ConditionReportSummary({required this.recordedAt, this.odometerKm, this.fuelLevelPct, final  List<DamageNote> damages = const <DamageNote>[], this.photoCount = 0}): _damages = damages;
  factory _ConditionReportSummary.fromJson(Map<String, dynamic> json) => _$ConditionReportSummaryFromJson(json);

@override final  DateTime recordedAt;
@override final  int? odometerKm;
@override final  int? fuelLevelPct;
 final  List<DamageNote> _damages;
@override@JsonKey() List<DamageNote> get damages {
  if (_damages is EqualUnmodifiableListView) return _damages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_damages);
}

@override@JsonKey() final  int photoCount;

/// Create a copy of ConditionReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConditionReportSummaryCopyWith<_ConditionReportSummary> get copyWith => __$ConditionReportSummaryCopyWithImpl<_ConditionReportSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConditionReportSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConditionReportSummary&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.odometerKm, odometerKm) || other.odometerKm == odometerKm)&&(identical(other.fuelLevelPct, fuelLevelPct) || other.fuelLevelPct == fuelLevelPct)&&const DeepCollectionEquality().equals(other._damages, _damages)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recordedAt,odometerKm,fuelLevelPct,const DeepCollectionEquality().hash(_damages),photoCount);

@override
String toString() {
  return 'ConditionReportSummary(recordedAt: $recordedAt, odometerKm: $odometerKm, fuelLevelPct: $fuelLevelPct, damages: $damages, photoCount: $photoCount)';
}


}

/// @nodoc
abstract mixin class _$ConditionReportSummaryCopyWith<$Res> implements $ConditionReportSummaryCopyWith<$Res> {
  factory _$ConditionReportSummaryCopyWith(_ConditionReportSummary value, $Res Function(_ConditionReportSummary) _then) = __$ConditionReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime recordedAt, int? odometerKm, int? fuelLevelPct, List<DamageNote> damages, int photoCount
});




}
/// @nodoc
class __$ConditionReportSummaryCopyWithImpl<$Res>
    implements _$ConditionReportSummaryCopyWith<$Res> {
  __$ConditionReportSummaryCopyWithImpl(this._self, this._then);

  final _ConditionReportSummary _self;
  final $Res Function(_ConditionReportSummary) _then;

/// Create a copy of ConditionReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recordedAt = null,Object? odometerKm = freezed,Object? fuelLevelPct = freezed,Object? damages = null,Object? photoCount = null,}) {
  return _then(_ConditionReportSummary(
recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,odometerKm: freezed == odometerKm ? _self.odometerKm : odometerKm // ignore: cast_nullable_to_non_nullable
as int?,fuelLevelPct: freezed == fuelLevelPct ? _self.fuelLevelPct : fuelLevelPct // ignore: cast_nullable_to_non_nullable
as int?,damages: null == damages ? _self._damages : damages // ignore: cast_nullable_to_non_nullable
as List<DamageNote>,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BookingEvent {

 String get type;@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus? get toStatus; DateTime get at; String? get actorRole;
/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingEventCopyWith<BookingEvent> get copyWith => _$BookingEventCopyWithImpl<BookingEvent>(this as BookingEvent, _$identity);

  /// Serializes this BookingEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.at, at) || other.at == at)&&(identical(other.actorRole, actorRole) || other.actorRole == actorRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,toStatus,at,actorRole);

@override
String toString() {
  return 'BookingEvent(type: $type, toStatus: $toStatus, at: $at, actorRole: $actorRole)';
}


}

/// @nodoc
abstract mixin class $BookingEventCopyWith<$Res>  {
  factory $BookingEventCopyWith(BookingEvent value, $Res Function(BookingEvent) _then) = _$BookingEventCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus? toStatus, DateTime at, String? actorRole
});




}
/// @nodoc
class _$BookingEventCopyWithImpl<$Res>
    implements $BookingEventCopyWith<$Res> {
  _$BookingEventCopyWithImpl(this._self, this._then);

  final BookingEvent _self;
  final $Res Function(BookingEvent) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? toStatus = freezed,Object? at = null,Object? actorRole = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,toStatus: freezed == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus?,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,actorRole: freezed == actorRole ? _self.actorRole : actorRole // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingEvent].
extension BookingEventPatterns on BookingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingEvent value)  $default,){
final _that = this;
switch (_that) {
case _BookingEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingEvent value)?  $default,){
final _that = this;
switch (_that) {
case _BookingEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus? toStatus,  DateTime at,  String? actorRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingEvent() when $default != null:
return $default(_that.type,_that.toStatus,_that.at,_that.actorRole);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus? toStatus,  DateTime at,  String? actorRole)  $default,) {final _that = this;
switch (_that) {
case _BookingEvent():
return $default(_that.type,_that.toStatus,_that.at,_that.actorRole);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus? toStatus,  DateTime at,  String? actorRole)?  $default,) {final _that = this;
switch (_that) {
case _BookingEvent() when $default != null:
return $default(_that.type,_that.toStatus,_that.at,_that.actorRole);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingEvent implements BookingEvent {
  const _BookingEvent({required this.type, @JsonKey(unknownEnumValue: BookingStatus.unknown) this.toStatus, required this.at, this.actorRole});
  factory _BookingEvent.fromJson(Map<String, dynamic> json) => _$BookingEventFromJson(json);

@override final  String type;
@override@JsonKey(unknownEnumValue: BookingStatus.unknown) final  BookingStatus? toStatus;
@override final  DateTime at;
@override final  String? actorRole;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingEventCopyWith<_BookingEvent> get copyWith => __$BookingEventCopyWithImpl<_BookingEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.at, at) || other.at == at)&&(identical(other.actorRole, actorRole) || other.actorRole == actorRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,toStatus,at,actorRole);

@override
String toString() {
  return 'BookingEvent(type: $type, toStatus: $toStatus, at: $at, actorRole: $actorRole)';
}


}

/// @nodoc
abstract mixin class _$BookingEventCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory _$BookingEventCopyWith(_BookingEvent value, $Res Function(_BookingEvent) _then) = __$BookingEventCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus? toStatus, DateTime at, String? actorRole
});




}
/// @nodoc
class __$BookingEventCopyWithImpl<$Res>
    implements _$BookingEventCopyWith<$Res> {
  __$BookingEventCopyWithImpl(this._self, this._then);

  final _BookingEvent _self;
  final $Res Function(_BookingEvent) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? toStatus = freezed,Object? at = null,Object? actorRole = freezed,}) {
  return _then(_BookingEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,toStatus: freezed == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus?,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,actorRole: freezed == actorRole ? _self.actorRole : actorRole // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Booking {

 String get id; String get reference;@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus get status;@JsonKey(unknownEnumValue: PaymentStatus.unknown) PaymentStatus get paymentStatus; DateTime get pickupAt; DateTime get returnAt; Money get total; BookingVehicleRef get vehicle; BookingPartnerRef get partner; CityRef get city; String get timezone; int get days;@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode get bookingMode;@JsonKey(unknownEnumValue: DepositStatus.unknown) DepositStatus get depositStatus; DeliveryInfo get delivery; PickupLocation? get pickupLocation; List<LineItem> get lineItems; Money get deposit; List<ConditionalCharge> get conditionalCharges; PolicyInfo? get cancellationPolicy; Money? get cancellationFee; Money? get refund; DateTime? get holdExpiresAt; DateTime? get partnerResponseDueAt; DriverInfo? get driver; String? get pickupInstructions; String? get returnInstructions; List<String> get requiredDocuments; ConditionReportSummary? get pickupReport; ConditionReportSummary? get returnReport; List<BookingEvent> get events; List<String> get allowedActions; DateTime? get createdAt;// CONTRACT-ASSUMPTION: an optional open payment intent on held bookings
// so "pay" can resume from booking details (contract-requests.md).
 PaymentIntent? get payment;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.pickupAt, pickupAt) || other.pickupAt == pickupAt)&&(identical(other.returnAt, returnAt) || other.returnAt == returnAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.city, city) || other.city == city)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.days, days) || other.days == days)&&(identical(other.bookingMode, bookingMode) || other.bookingMode == bookingMode)&&(identical(other.depositStatus, depositStatus) || other.depositStatus == depositStatus)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.pickupLocation, pickupLocation) || other.pickupLocation == pickupLocation)&&const DeepCollectionEquality().equals(other.lineItems, lineItems)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&const DeepCollectionEquality().equals(other.conditionalCharges, conditionalCharges)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.cancellationFee, cancellationFee) || other.cancellationFee == cancellationFee)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.partnerResponseDueAt, partnerResponseDueAt) || other.partnerResponseDueAt == partnerResponseDueAt)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.pickupInstructions, pickupInstructions) || other.pickupInstructions == pickupInstructions)&&(identical(other.returnInstructions, returnInstructions) || other.returnInstructions == returnInstructions)&&const DeepCollectionEquality().equals(other.requiredDocuments, requiredDocuments)&&(identical(other.pickupReport, pickupReport) || other.pickupReport == pickupReport)&&(identical(other.returnReport, returnReport) || other.returnReport == returnReport)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.allowedActions, allowedActions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.payment, payment) || other.payment == payment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,reference,status,paymentStatus,pickupAt,returnAt,total,vehicle,partner,city,timezone,days,bookingMode,depositStatus,delivery,pickupLocation,const DeepCollectionEquality().hash(lineItems),deposit,const DeepCollectionEquality().hash(conditionalCharges),cancellationPolicy,cancellationFee,refund,holdExpiresAt,partnerResponseDueAt,driver,pickupInstructions,returnInstructions,const DeepCollectionEquality().hash(requiredDocuments),pickupReport,returnReport,const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(allowedActions),createdAt,payment]);

@override
String toString() {
  return 'Booking(id: $id, reference: $reference, status: $status, paymentStatus: $paymentStatus, pickupAt: $pickupAt, returnAt: $returnAt, total: $total, vehicle: $vehicle, partner: $partner, city: $city, timezone: $timezone, days: $days, bookingMode: $bookingMode, depositStatus: $depositStatus, delivery: $delivery, pickupLocation: $pickupLocation, lineItems: $lineItems, deposit: $deposit, conditionalCharges: $conditionalCharges, cancellationPolicy: $cancellationPolicy, cancellationFee: $cancellationFee, refund: $refund, holdExpiresAt: $holdExpiresAt, partnerResponseDueAt: $partnerResponseDueAt, driver: $driver, pickupInstructions: $pickupInstructions, returnInstructions: $returnInstructions, requiredDocuments: $requiredDocuments, pickupReport: $pickupReport, returnReport: $returnReport, events: $events, allowedActions: $allowedActions, createdAt: $createdAt, payment: $payment)';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
 String id, String reference,@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus status,@JsonKey(unknownEnumValue: PaymentStatus.unknown) PaymentStatus paymentStatus, DateTime pickupAt, DateTime returnAt, Money total, BookingVehicleRef vehicle, BookingPartnerRef partner, CityRef city, String timezone, int days,@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode bookingMode,@JsonKey(unknownEnumValue: DepositStatus.unknown) DepositStatus depositStatus, DeliveryInfo delivery, PickupLocation? pickupLocation, List<LineItem> lineItems, Money deposit, List<ConditionalCharge> conditionalCharges, PolicyInfo? cancellationPolicy, Money? cancellationFee, Money? refund, DateTime? holdExpiresAt, DateTime? partnerResponseDueAt, DriverInfo? driver, String? pickupInstructions, String? returnInstructions, List<String> requiredDocuments, ConditionReportSummary? pickupReport, ConditionReportSummary? returnReport, List<BookingEvent> events, List<String> allowedActions, DateTime? createdAt, PaymentIntent? payment
});


$BookingVehicleRefCopyWith<$Res> get vehicle;$BookingPartnerRefCopyWith<$Res> get partner;$CityRefCopyWith<$Res> get city;$DeliveryInfoCopyWith<$Res> get delivery;$PickupLocationCopyWith<$Res>? get pickupLocation;$PolicyInfoCopyWith<$Res>? get cancellationPolicy;$DriverInfoCopyWith<$Res>? get driver;$ConditionReportSummaryCopyWith<$Res>? get pickupReport;$ConditionReportSummaryCopyWith<$Res>? get returnReport;$PaymentIntentCopyWith<$Res>? get payment;

}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? status = null,Object? paymentStatus = null,Object? pickupAt = null,Object? returnAt = null,Object? total = null,Object? vehicle = null,Object? partner = null,Object? city = null,Object? timezone = null,Object? days = null,Object? bookingMode = null,Object? depositStatus = null,Object? delivery = null,Object? pickupLocation = freezed,Object? lineItems = null,Object? deposit = null,Object? conditionalCharges = null,Object? cancellationPolicy = freezed,Object? cancellationFee = freezed,Object? refund = freezed,Object? holdExpiresAt = freezed,Object? partnerResponseDueAt = freezed,Object? driver = freezed,Object? pickupInstructions = freezed,Object? returnInstructions = freezed,Object? requiredDocuments = null,Object? pickupReport = freezed,Object? returnReport = freezed,Object? events = null,Object? allowedActions = null,Object? createdAt = freezed,Object? payment = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,pickupAt: null == pickupAt ? _self.pickupAt : pickupAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnAt: null == returnAt ? _self.returnAt : returnAt // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as BookingVehicleRef,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as BookingPartnerRef,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,bookingMode: null == bookingMode ? _self.bookingMode : bookingMode // ignore: cast_nullable_to_non_nullable
as BookingMode,depositStatus: null == depositStatus ? _self.depositStatus : depositStatus // ignore: cast_nullable_to_non_nullable
as DepositStatus,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as DeliveryInfo,pickupLocation: freezed == pickupLocation ? _self.pickupLocation : pickupLocation // ignore: cast_nullable_to_non_nullable
as PickupLocation?,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<LineItem>,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as Money,conditionalCharges: null == conditionalCharges ? _self.conditionalCharges : conditionalCharges // ignore: cast_nullable_to_non_nullable
as List<ConditionalCharge>,cancellationPolicy: freezed == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as PolicyInfo?,cancellationFee: freezed == cancellationFee ? _self.cancellationFee : cancellationFee // ignore: cast_nullable_to_non_nullable
as Money?,refund: freezed == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as Money?,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,partnerResponseDueAt: freezed == partnerResponseDueAt ? _self.partnerResponseDueAt : partnerResponseDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverInfo?,pickupInstructions: freezed == pickupInstructions ? _self.pickupInstructions : pickupInstructions // ignore: cast_nullable_to_non_nullable
as String?,returnInstructions: freezed == returnInstructions ? _self.returnInstructions : returnInstructions // ignore: cast_nullable_to_non_nullable
as String?,requiredDocuments: null == requiredDocuments ? _self.requiredDocuments : requiredDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,pickupReport: freezed == pickupReport ? _self.pickupReport : pickupReport // ignore: cast_nullable_to_non_nullable
as ConditionReportSummary?,returnReport: freezed == returnReport ? _self.returnReport : returnReport // ignore: cast_nullable_to_non_nullable
as ConditionReportSummary?,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<BookingEvent>,allowedActions: null == allowedActions ? _self.allowedActions : allowedActions // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentIntent?,
  ));
}
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVehicleRefCopyWith<$Res> get vehicle {
  
  return $BookingVehicleRefCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingPartnerRefCopyWith<$Res> get partner {
  
  return $BookingPartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryInfoCopyWith<$Res> get delivery {
  
  return $DeliveryInfoCopyWith<$Res>(_self.delivery, (value) {
    return _then(_self.copyWith(delivery: value));
  });
}/// Create a copy of Booking
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
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<$Res>? get cancellationPolicy {
    if (_self.cancellationPolicy == null) {
    return null;
  }

  return $PolicyInfoCopyWith<$Res>(_self.cancellationPolicy!, (value) {
    return _then(_self.copyWith(cancellationPolicy: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverInfoCopyWith<$Res>? get driver {
    if (_self.driver == null) {
    return null;
  }

  return $DriverInfoCopyWith<$Res>(_self.driver!, (value) {
    return _then(_self.copyWith(driver: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConditionReportSummaryCopyWith<$Res>? get pickupReport {
    if (_self.pickupReport == null) {
    return null;
  }

  return $ConditionReportSummaryCopyWith<$Res>(_self.pickupReport!, (value) {
    return _then(_self.copyWith(pickupReport: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConditionReportSummaryCopyWith<$Res>? get returnReport {
    if (_self.returnReport == null) {
    return null;
  }

  return $ConditionReportSummaryCopyWith<$Res>(_self.returnReport!, (value) {
    return _then(_self.copyWith(returnReport: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<$Res>? get payment {
    if (_self.payment == null) {
    return null;
  }

  return $PaymentIntentCopyWith<$Res>(_self.payment!, (value) {
    return _then(_self.copyWith(payment: value));
  });
}
}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus status, @JsonKey(unknownEnumValue: PaymentStatus.unknown)  PaymentStatus paymentStatus,  DateTime pickupAt,  DateTime returnAt,  Money total,  BookingVehicleRef vehicle,  BookingPartnerRef partner,  CityRef city,  String timezone,  int days, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode, @JsonKey(unknownEnumValue: DepositStatus.unknown)  DepositStatus depositStatus,  DeliveryInfo delivery,  PickupLocation? pickupLocation,  List<LineItem> lineItems,  Money deposit,  List<ConditionalCharge> conditionalCharges,  PolicyInfo? cancellationPolicy,  Money? cancellationFee,  Money? refund,  DateTime? holdExpiresAt,  DateTime? partnerResponseDueAt,  DriverInfo? driver,  String? pickupInstructions,  String? returnInstructions,  List<String> requiredDocuments,  ConditionReportSummary? pickupReport,  ConditionReportSummary? returnReport,  List<BookingEvent> events,  List<String> allowedActions,  DateTime? createdAt,  PaymentIntent? payment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.reference,_that.status,_that.paymentStatus,_that.pickupAt,_that.returnAt,_that.total,_that.vehicle,_that.partner,_that.city,_that.timezone,_that.days,_that.bookingMode,_that.depositStatus,_that.delivery,_that.pickupLocation,_that.lineItems,_that.deposit,_that.conditionalCharges,_that.cancellationPolicy,_that.cancellationFee,_that.refund,_that.holdExpiresAt,_that.partnerResponseDueAt,_that.driver,_that.pickupInstructions,_that.returnInstructions,_that.requiredDocuments,_that.pickupReport,_that.returnReport,_that.events,_that.allowedActions,_that.createdAt,_that.payment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus status, @JsonKey(unknownEnumValue: PaymentStatus.unknown)  PaymentStatus paymentStatus,  DateTime pickupAt,  DateTime returnAt,  Money total,  BookingVehicleRef vehicle,  BookingPartnerRef partner,  CityRef city,  String timezone,  int days, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode, @JsonKey(unknownEnumValue: DepositStatus.unknown)  DepositStatus depositStatus,  DeliveryInfo delivery,  PickupLocation? pickupLocation,  List<LineItem> lineItems,  Money deposit,  List<ConditionalCharge> conditionalCharges,  PolicyInfo? cancellationPolicy,  Money? cancellationFee,  Money? refund,  DateTime? holdExpiresAt,  DateTime? partnerResponseDueAt,  DriverInfo? driver,  String? pickupInstructions,  String? returnInstructions,  List<String> requiredDocuments,  ConditionReportSummary? pickupReport,  ConditionReportSummary? returnReport,  List<BookingEvent> events,  List<String> allowedActions,  DateTime? createdAt,  PaymentIntent? payment)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.reference,_that.status,_that.paymentStatus,_that.pickupAt,_that.returnAt,_that.total,_that.vehicle,_that.partner,_that.city,_that.timezone,_that.days,_that.bookingMode,_that.depositStatus,_that.delivery,_that.pickupLocation,_that.lineItems,_that.deposit,_that.conditionalCharges,_that.cancellationPolicy,_that.cancellationFee,_that.refund,_that.holdExpiresAt,_that.partnerResponseDueAt,_that.driver,_that.pickupInstructions,_that.returnInstructions,_that.requiredDocuments,_that.pickupReport,_that.returnReport,_that.events,_that.allowedActions,_that.createdAt,_that.payment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference, @JsonKey(unknownEnumValue: BookingStatus.unknown)  BookingStatus status, @JsonKey(unknownEnumValue: PaymentStatus.unknown)  PaymentStatus paymentStatus,  DateTime pickupAt,  DateTime returnAt,  Money total,  BookingVehicleRef vehicle,  BookingPartnerRef partner,  CityRef city,  String timezone,  int days, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode, @JsonKey(unknownEnumValue: DepositStatus.unknown)  DepositStatus depositStatus,  DeliveryInfo delivery,  PickupLocation? pickupLocation,  List<LineItem> lineItems,  Money deposit,  List<ConditionalCharge> conditionalCharges,  PolicyInfo? cancellationPolicy,  Money? cancellationFee,  Money? refund,  DateTime? holdExpiresAt,  DateTime? partnerResponseDueAt,  DriverInfo? driver,  String? pickupInstructions,  String? returnInstructions,  List<String> requiredDocuments,  ConditionReportSummary? pickupReport,  ConditionReportSummary? returnReport,  List<BookingEvent> events,  List<String> allowedActions,  DateTime? createdAt,  PaymentIntent? payment)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.reference,_that.status,_that.paymentStatus,_that.pickupAt,_that.returnAt,_that.total,_that.vehicle,_that.partner,_that.city,_that.timezone,_that.days,_that.bookingMode,_that.depositStatus,_that.delivery,_that.pickupLocation,_that.lineItems,_that.deposit,_that.conditionalCharges,_that.cancellationPolicy,_that.cancellationFee,_that.refund,_that.holdExpiresAt,_that.partnerResponseDueAt,_that.driver,_that.pickupInstructions,_that.returnInstructions,_that.requiredDocuments,_that.pickupReport,_that.returnReport,_that.events,_that.allowedActions,_that.createdAt,_that.payment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Booking extends Booking {
  const _Booking({required this.id, required this.reference, @JsonKey(unknownEnumValue: BookingStatus.unknown) required this.status, @JsonKey(unknownEnumValue: PaymentStatus.unknown) required this.paymentStatus, required this.pickupAt, required this.returnAt, required this.total, required this.vehicle, required this.partner, required this.city, required this.timezone, required this.days, @JsonKey(unknownEnumValue: BookingMode.unknown) required this.bookingMode, @JsonKey(unknownEnumValue: DepositStatus.unknown) required this.depositStatus, this.delivery = const DeliveryInfo(), this.pickupLocation, final  List<LineItem> lineItems = const <LineItem>[], required this.deposit, final  List<ConditionalCharge> conditionalCharges = const <ConditionalCharge>[], this.cancellationPolicy, this.cancellationFee, this.refund, this.holdExpiresAt, this.partnerResponseDueAt, this.driver, this.pickupInstructions, this.returnInstructions, final  List<String> requiredDocuments = const <String>[], this.pickupReport, this.returnReport, final  List<BookingEvent> events = const <BookingEvent>[], final  List<String> allowedActions = const <String>[], this.createdAt, this.payment}): _lineItems = lineItems,_conditionalCharges = conditionalCharges,_requiredDocuments = requiredDocuments,_events = events,_allowedActions = allowedActions,super._();
  factory _Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

@override final  String id;
@override final  String reference;
@override@JsonKey(unknownEnumValue: BookingStatus.unknown) final  BookingStatus status;
@override@JsonKey(unknownEnumValue: PaymentStatus.unknown) final  PaymentStatus paymentStatus;
@override final  DateTime pickupAt;
@override final  DateTime returnAt;
@override final  Money total;
@override final  BookingVehicleRef vehicle;
@override final  BookingPartnerRef partner;
@override final  CityRef city;
@override final  String timezone;
@override final  int days;
@override@JsonKey(unknownEnumValue: BookingMode.unknown) final  BookingMode bookingMode;
@override@JsonKey(unknownEnumValue: DepositStatus.unknown) final  DepositStatus depositStatus;
@override@JsonKey() final  DeliveryInfo delivery;
@override final  PickupLocation? pickupLocation;
 final  List<LineItem> _lineItems;
@override@JsonKey() List<LineItem> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}

@override final  Money deposit;
 final  List<ConditionalCharge> _conditionalCharges;
@override@JsonKey() List<ConditionalCharge> get conditionalCharges {
  if (_conditionalCharges is EqualUnmodifiableListView) return _conditionalCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conditionalCharges);
}

@override final  PolicyInfo? cancellationPolicy;
@override final  Money? cancellationFee;
@override final  Money? refund;
@override final  DateTime? holdExpiresAt;
@override final  DateTime? partnerResponseDueAt;
@override final  DriverInfo? driver;
@override final  String? pickupInstructions;
@override final  String? returnInstructions;
 final  List<String> _requiredDocuments;
@override@JsonKey() List<String> get requiredDocuments {
  if (_requiredDocuments is EqualUnmodifiableListView) return _requiredDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredDocuments);
}

@override final  ConditionReportSummary? pickupReport;
@override final  ConditionReportSummary? returnReport;
 final  List<BookingEvent> _events;
@override@JsonKey() List<BookingEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  List<String> _allowedActions;
@override@JsonKey() List<String> get allowedActions {
  if (_allowedActions is EqualUnmodifiableListView) return _allowedActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedActions);
}

@override final  DateTime? createdAt;
// CONTRACT-ASSUMPTION: an optional open payment intent on held bookings
// so "pay" can resume from booking details (contract-requests.md).
@override final  PaymentIntent? payment;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.pickupAt, pickupAt) || other.pickupAt == pickupAt)&&(identical(other.returnAt, returnAt) || other.returnAt == returnAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.city, city) || other.city == city)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.days, days) || other.days == days)&&(identical(other.bookingMode, bookingMode) || other.bookingMode == bookingMode)&&(identical(other.depositStatus, depositStatus) || other.depositStatus == depositStatus)&&(identical(other.delivery, delivery) || other.delivery == delivery)&&(identical(other.pickupLocation, pickupLocation) || other.pickupLocation == pickupLocation)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&const DeepCollectionEquality().equals(other._conditionalCharges, _conditionalCharges)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.cancellationFee, cancellationFee) || other.cancellationFee == cancellationFee)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.holdExpiresAt, holdExpiresAt) || other.holdExpiresAt == holdExpiresAt)&&(identical(other.partnerResponseDueAt, partnerResponseDueAt) || other.partnerResponseDueAt == partnerResponseDueAt)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.pickupInstructions, pickupInstructions) || other.pickupInstructions == pickupInstructions)&&(identical(other.returnInstructions, returnInstructions) || other.returnInstructions == returnInstructions)&&const DeepCollectionEquality().equals(other._requiredDocuments, _requiredDocuments)&&(identical(other.pickupReport, pickupReport) || other.pickupReport == pickupReport)&&(identical(other.returnReport, returnReport) || other.returnReport == returnReport)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._allowedActions, _allowedActions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.payment, payment) || other.payment == payment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,reference,status,paymentStatus,pickupAt,returnAt,total,vehicle,partner,city,timezone,days,bookingMode,depositStatus,delivery,pickupLocation,const DeepCollectionEquality().hash(_lineItems),deposit,const DeepCollectionEquality().hash(_conditionalCharges),cancellationPolicy,cancellationFee,refund,holdExpiresAt,partnerResponseDueAt,driver,pickupInstructions,returnInstructions,const DeepCollectionEquality().hash(_requiredDocuments),pickupReport,returnReport,const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_allowedActions),createdAt,payment]);

@override
String toString() {
  return 'Booking(id: $id, reference: $reference, status: $status, paymentStatus: $paymentStatus, pickupAt: $pickupAt, returnAt: $returnAt, total: $total, vehicle: $vehicle, partner: $partner, city: $city, timezone: $timezone, days: $days, bookingMode: $bookingMode, depositStatus: $depositStatus, delivery: $delivery, pickupLocation: $pickupLocation, lineItems: $lineItems, deposit: $deposit, conditionalCharges: $conditionalCharges, cancellationPolicy: $cancellationPolicy, cancellationFee: $cancellationFee, refund: $refund, holdExpiresAt: $holdExpiresAt, partnerResponseDueAt: $partnerResponseDueAt, driver: $driver, pickupInstructions: $pickupInstructions, returnInstructions: $returnInstructions, requiredDocuments: $requiredDocuments, pickupReport: $pickupReport, returnReport: $returnReport, events: $events, allowedActions: $allowedActions, createdAt: $createdAt, payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference,@JsonKey(unknownEnumValue: BookingStatus.unknown) BookingStatus status,@JsonKey(unknownEnumValue: PaymentStatus.unknown) PaymentStatus paymentStatus, DateTime pickupAt, DateTime returnAt, Money total, BookingVehicleRef vehicle, BookingPartnerRef partner, CityRef city, String timezone, int days,@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode bookingMode,@JsonKey(unknownEnumValue: DepositStatus.unknown) DepositStatus depositStatus, DeliveryInfo delivery, PickupLocation? pickupLocation, List<LineItem> lineItems, Money deposit, List<ConditionalCharge> conditionalCharges, PolicyInfo? cancellationPolicy, Money? cancellationFee, Money? refund, DateTime? holdExpiresAt, DateTime? partnerResponseDueAt, DriverInfo? driver, String? pickupInstructions, String? returnInstructions, List<String> requiredDocuments, ConditionReportSummary? pickupReport, ConditionReportSummary? returnReport, List<BookingEvent> events, List<String> allowedActions, DateTime? createdAt, PaymentIntent? payment
});


@override $BookingVehicleRefCopyWith<$Res> get vehicle;@override $BookingPartnerRefCopyWith<$Res> get partner;@override $CityRefCopyWith<$Res> get city;@override $DeliveryInfoCopyWith<$Res> get delivery;@override $PickupLocationCopyWith<$Res>? get pickupLocation;@override $PolicyInfoCopyWith<$Res>? get cancellationPolicy;@override $DriverInfoCopyWith<$Res>? get driver;@override $ConditionReportSummaryCopyWith<$Res>? get pickupReport;@override $ConditionReportSummaryCopyWith<$Res>? get returnReport;@override $PaymentIntentCopyWith<$Res>? get payment;

}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? status = null,Object? paymentStatus = null,Object? pickupAt = null,Object? returnAt = null,Object? total = null,Object? vehicle = null,Object? partner = null,Object? city = null,Object? timezone = null,Object? days = null,Object? bookingMode = null,Object? depositStatus = null,Object? delivery = null,Object? pickupLocation = freezed,Object? lineItems = null,Object? deposit = null,Object? conditionalCharges = null,Object? cancellationPolicy = freezed,Object? cancellationFee = freezed,Object? refund = freezed,Object? holdExpiresAt = freezed,Object? partnerResponseDueAt = freezed,Object? driver = freezed,Object? pickupInstructions = freezed,Object? returnInstructions = freezed,Object? requiredDocuments = null,Object? pickupReport = freezed,Object? returnReport = freezed,Object? events = null,Object? allowedActions = null,Object? createdAt = freezed,Object? payment = freezed,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,pickupAt: null == pickupAt ? _self.pickupAt : pickupAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnAt: null == returnAt ? _self.returnAt : returnAt // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as BookingVehicleRef,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as BookingPartnerRef,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityRef,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,bookingMode: null == bookingMode ? _self.bookingMode : bookingMode // ignore: cast_nullable_to_non_nullable
as BookingMode,depositStatus: null == depositStatus ? _self.depositStatus : depositStatus // ignore: cast_nullable_to_non_nullable
as DepositStatus,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as DeliveryInfo,pickupLocation: freezed == pickupLocation ? _self.pickupLocation : pickupLocation // ignore: cast_nullable_to_non_nullable
as PickupLocation?,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<LineItem>,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as Money,conditionalCharges: null == conditionalCharges ? _self._conditionalCharges : conditionalCharges // ignore: cast_nullable_to_non_nullable
as List<ConditionalCharge>,cancellationPolicy: freezed == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as PolicyInfo?,cancellationFee: freezed == cancellationFee ? _self.cancellationFee : cancellationFee // ignore: cast_nullable_to_non_nullable
as Money?,refund: freezed == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as Money?,holdExpiresAt: freezed == holdExpiresAt ? _self.holdExpiresAt : holdExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,partnerResponseDueAt: freezed == partnerResponseDueAt ? _self.partnerResponseDueAt : partnerResponseDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverInfo?,pickupInstructions: freezed == pickupInstructions ? _self.pickupInstructions : pickupInstructions // ignore: cast_nullable_to_non_nullable
as String?,returnInstructions: freezed == returnInstructions ? _self.returnInstructions : returnInstructions // ignore: cast_nullable_to_non_nullable
as String?,requiredDocuments: null == requiredDocuments ? _self._requiredDocuments : requiredDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,pickupReport: freezed == pickupReport ? _self.pickupReport : pickupReport // ignore: cast_nullable_to_non_nullable
as ConditionReportSummary?,returnReport: freezed == returnReport ? _self.returnReport : returnReport // ignore: cast_nullable_to_non_nullable
as ConditionReportSummary?,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<BookingEvent>,allowedActions: null == allowedActions ? _self._allowedActions : allowedActions // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentIntent?,
  ));
}

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingVehicleRefCopyWith<$Res> get vehicle {
  
  return $BookingVehicleRefCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingPartnerRefCopyWith<$Res> get partner {
  
  return $BookingPartnerRefCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityRefCopyWith<$Res> get city {
  
  return $CityRefCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryInfoCopyWith<$Res> get delivery {
  
  return $DeliveryInfoCopyWith<$Res>(_self.delivery, (value) {
    return _then(_self.copyWith(delivery: value));
  });
}/// Create a copy of Booking
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
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<$Res>? get cancellationPolicy {
    if (_self.cancellationPolicy == null) {
    return null;
  }

  return $PolicyInfoCopyWith<$Res>(_self.cancellationPolicy!, (value) {
    return _then(_self.copyWith(cancellationPolicy: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverInfoCopyWith<$Res>? get driver {
    if (_self.driver == null) {
    return null;
  }

  return $DriverInfoCopyWith<$Res>(_self.driver!, (value) {
    return _then(_self.copyWith(driver: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConditionReportSummaryCopyWith<$Res>? get pickupReport {
    if (_self.pickupReport == null) {
    return null;
  }

  return $ConditionReportSummaryCopyWith<$Res>(_self.pickupReport!, (value) {
    return _then(_self.copyWith(pickupReport: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConditionReportSummaryCopyWith<$Res>? get returnReport {
    if (_self.returnReport == null) {
    return null;
  }

  return $ConditionReportSummaryCopyWith<$Res>(_self.returnReport!, (value) {
    return _then(_self.copyWith(returnReport: value));
  });
}/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<$Res>? get payment {
    if (_self.payment == null) {
    return null;
  }

  return $PaymentIntentCopyWith<$Res>(_self.payment!, (value) {
    return _then(_self.copyWith(payment: value));
  });
}
}


/// @nodoc
mixin _$BookingCreation {

 Booking get booking; PaymentIntent get payment;
/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCreationCopyWith<BookingCreation> get copyWith => _$BookingCreationCopyWithImpl<BookingCreation>(this as BookingCreation, _$identity);

  /// Serializes this BookingCreation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingCreation&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.payment, payment) || other.payment == payment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,booking,payment);

@override
String toString() {
  return 'BookingCreation(booking: $booking, payment: $payment)';
}


}

/// @nodoc
abstract mixin class $BookingCreationCopyWith<$Res>  {
  factory $BookingCreationCopyWith(BookingCreation value, $Res Function(BookingCreation) _then) = _$BookingCreationCopyWithImpl;
@useResult
$Res call({
 Booking booking, PaymentIntent payment
});


$BookingCopyWith<$Res> get booking;$PaymentIntentCopyWith<$Res> get payment;

}
/// @nodoc
class _$BookingCreationCopyWithImpl<$Res>
    implements $BookingCreationCopyWith<$Res> {
  _$BookingCreationCopyWithImpl(this._self, this._then);

  final BookingCreation _self;
  final $Res Function(BookingCreation) _then;

/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = null,Object? payment = null,}) {
  return _then(_self.copyWith(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentIntent,
  ));
}
/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res> get booking {
  
  return $BookingCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<$Res> get payment {
  
  return $PaymentIntentCopyWith<$Res>(_self.payment, (value) {
    return _then(_self.copyWith(payment: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingCreation].
extension BookingCreationPatterns on BookingCreation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingCreation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingCreation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingCreation value)  $default,){
final _that = this;
switch (_that) {
case _BookingCreation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingCreation value)?  $default,){
final _that = this;
switch (_that) {
case _BookingCreation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Booking booking,  PaymentIntent payment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingCreation() when $default != null:
return $default(_that.booking,_that.payment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Booking booking,  PaymentIntent payment)  $default,) {final _that = this;
switch (_that) {
case _BookingCreation():
return $default(_that.booking,_that.payment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Booking booking,  PaymentIntent payment)?  $default,) {final _that = this;
switch (_that) {
case _BookingCreation() when $default != null:
return $default(_that.booking,_that.payment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingCreation implements BookingCreation {
  const _BookingCreation({required this.booking, required this.payment});
  factory _BookingCreation.fromJson(Map<String, dynamic> json) => _$BookingCreationFromJson(json);

@override final  Booking booking;
@override final  PaymentIntent payment;

/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCreationCopyWith<_BookingCreation> get copyWith => __$BookingCreationCopyWithImpl<_BookingCreation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingCreationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingCreation&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.payment, payment) || other.payment == payment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,booking,payment);

@override
String toString() {
  return 'BookingCreation(booking: $booking, payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$BookingCreationCopyWith<$Res> implements $BookingCreationCopyWith<$Res> {
  factory _$BookingCreationCopyWith(_BookingCreation value, $Res Function(_BookingCreation) _then) = __$BookingCreationCopyWithImpl;
@override @useResult
$Res call({
 Booking booking, PaymentIntent payment
});


@override $BookingCopyWith<$Res> get booking;@override $PaymentIntentCopyWith<$Res> get payment;

}
/// @nodoc
class __$BookingCreationCopyWithImpl<$Res>
    implements _$BookingCreationCopyWith<$Res> {
  __$BookingCreationCopyWithImpl(this._self, this._then);

  final _BookingCreation _self;
  final $Res Function(_BookingCreation) _then;

/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? payment = null,}) {
  return _then(_BookingCreation(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking,payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentIntent,
  ));
}

/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingCopyWith<$Res> get booking {
  
  return $BookingCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}/// Create a copy of BookingCreation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<$Res> get payment {
  
  return $PaymentIntentCopyWith<$Res>(_self.payment, (value) {
    return _then(_self.copyWith(payment: value));
  });
}
}

// dart format on
