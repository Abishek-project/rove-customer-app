// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LineItem {

 String get code; String get label; Money get amount;
/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineItemCopyWith<LineItem> get copyWith => _$LineItemCopyWithImpl<LineItem>(this as LineItem, _$identity);

  /// Serializes this LineItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineItem&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,amount);

@override
String toString() {
  return 'LineItem(code: $code, label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $LineItemCopyWith<$Res>  {
  factory $LineItemCopyWith(LineItem value, $Res Function(LineItem) _then) = _$LineItemCopyWithImpl;
@useResult
$Res call({
 String code, String label, Money amount
});




}
/// @nodoc
class _$LineItemCopyWithImpl<$Res>
    implements $LineItemCopyWith<$Res> {
  _$LineItemCopyWithImpl(this._self, this._then);

  final LineItem _self;
  final $Res Function(LineItem) _then;

/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,Object? amount = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [LineItem].
extension LineItemPatterns on LineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineItem value)  $default,){
final _that = this;
switch (_that) {
case _LineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineItem value)?  $default,){
final _that = this;
switch (_that) {
case _LineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String label,  Money amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineItem() when $default != null:
return $default(_that.code,_that.label,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String label,  Money amount)  $default,) {final _that = this;
switch (_that) {
case _LineItem():
return $default(_that.code,_that.label,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String label,  Money amount)?  $default,) {final _that = this;
switch (_that) {
case _LineItem() when $default != null:
return $default(_that.code,_that.label,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineItem implements LineItem {
  const _LineItem({required this.code, required this.label, required this.amount});
  factory _LineItem.fromJson(Map<String, dynamic> json) => _$LineItemFromJson(json);

@override final  String code;
@override final  String label;
@override final  Money amount;

/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineItemCopyWith<_LineItem> get copyWith => __$LineItemCopyWithImpl<_LineItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineItem&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,amount);

@override
String toString() {
  return 'LineItem(code: $code, label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$LineItemCopyWith<$Res> implements $LineItemCopyWith<$Res> {
  factory _$LineItemCopyWith(_LineItem value, $Res Function(_LineItem) _then) = __$LineItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String label, Money amount
});




}
/// @nodoc
class __$LineItemCopyWithImpl<$Res>
    implements _$LineItemCopyWith<$Res> {
  __$LineItemCopyWithImpl(this._self, this._then);

  final _LineItem _self;
  final $Res Function(_LineItem) _then;

/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,Object? amount = null,}) {
  return _then(_LineItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}


/// @nodoc
mixin _$ConditionalCharge {

 String get code; String get label; Money get amount; String? get unit;
/// Create a copy of ConditionalCharge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConditionalChargeCopyWith<ConditionalCharge> get copyWith => _$ConditionalChargeCopyWithImpl<ConditionalCharge>(this as ConditionalCharge, _$identity);

  /// Serializes this ConditionalCharge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConditionalCharge&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,amount,unit);

@override
String toString() {
  return 'ConditionalCharge(code: $code, label: $label, amount: $amount, unit: $unit)';
}


}

/// @nodoc
abstract mixin class $ConditionalChargeCopyWith<$Res>  {
  factory $ConditionalChargeCopyWith(ConditionalCharge value, $Res Function(ConditionalCharge) _then) = _$ConditionalChargeCopyWithImpl;
@useResult
$Res call({
 String code, String label, Money amount, String? unit
});




}
/// @nodoc
class _$ConditionalChargeCopyWithImpl<$Res>
    implements $ConditionalChargeCopyWith<$Res> {
  _$ConditionalChargeCopyWithImpl(this._self, this._then);

  final ConditionalCharge _self;
  final $Res Function(ConditionalCharge) _then;

/// Create a copy of ConditionalCharge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,Object? amount = null,Object? unit = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConditionalCharge].
extension ConditionalChargePatterns on ConditionalCharge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConditionalCharge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConditionalCharge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConditionalCharge value)  $default,){
final _that = this;
switch (_that) {
case _ConditionalCharge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConditionalCharge value)?  $default,){
final _that = this;
switch (_that) {
case _ConditionalCharge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String label,  Money amount,  String? unit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConditionalCharge() when $default != null:
return $default(_that.code,_that.label,_that.amount,_that.unit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String label,  Money amount,  String? unit)  $default,) {final _that = this;
switch (_that) {
case _ConditionalCharge():
return $default(_that.code,_that.label,_that.amount,_that.unit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String label,  Money amount,  String? unit)?  $default,) {final _that = this;
switch (_that) {
case _ConditionalCharge() when $default != null:
return $default(_that.code,_that.label,_that.amount,_that.unit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConditionalCharge implements ConditionalCharge {
  const _ConditionalCharge({required this.code, required this.label, required this.amount, this.unit});
  factory _ConditionalCharge.fromJson(Map<String, dynamic> json) => _$ConditionalChargeFromJson(json);

@override final  String code;
@override final  String label;
@override final  Money amount;
@override final  String? unit;

/// Create a copy of ConditionalCharge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConditionalChargeCopyWith<_ConditionalCharge> get copyWith => __$ConditionalChargeCopyWithImpl<_ConditionalCharge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConditionalChargeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConditionalCharge&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,amount,unit);

@override
String toString() {
  return 'ConditionalCharge(code: $code, label: $label, amount: $amount, unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$ConditionalChargeCopyWith<$Res> implements $ConditionalChargeCopyWith<$Res> {
  factory _$ConditionalChargeCopyWith(_ConditionalCharge value, $Res Function(_ConditionalCharge) _then) = __$ConditionalChargeCopyWithImpl;
@override @useResult
$Res call({
 String code, String label, Money amount, String? unit
});




}
/// @nodoc
class __$ConditionalChargeCopyWithImpl<$Res>
    implements _$ConditionalChargeCopyWith<$Res> {
  __$ConditionalChargeCopyWithImpl(this._self, this._then);

  final _ConditionalCharge _self;
  final $Res Function(_ConditionalCharge) _then;

/// Create a copy of ConditionalCharge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,Object? amount = null,Object? unit = freezed,}) {
  return _then(_ConditionalCharge(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Quote {

 String get id; String get vehicleId; DateTime get pickupAt; DateTime get returnAt; int get days; List<LineItem> get lineItems; Money get total; Money get deposit; List<ConditionalCharge> get conditionalCharges; PolicyInfo get cancellationPolicy;@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode get bookingMode; DateTime get expiresAt;
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCopyWith<Quote> get copyWith => _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.pickupAt, pickupAt) || other.pickupAt == pickupAt)&&(identical(other.returnAt, returnAt) || other.returnAt == returnAt)&&(identical(other.days, days) || other.days == days)&&const DeepCollectionEquality().equals(other.lineItems, lineItems)&&(identical(other.total, total) || other.total == total)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&const DeepCollectionEquality().equals(other.conditionalCharges, conditionalCharges)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.bookingMode, bookingMode) || other.bookingMode == bookingMode)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,pickupAt,returnAt,days,const DeepCollectionEquality().hash(lineItems),total,deposit,const DeepCollectionEquality().hash(conditionalCharges),cancellationPolicy,bookingMode,expiresAt);

@override
String toString() {
  return 'Quote(id: $id, vehicleId: $vehicleId, pickupAt: $pickupAt, returnAt: $returnAt, days: $days, lineItems: $lineItems, total: $total, deposit: $deposit, conditionalCharges: $conditionalCharges, cancellationPolicy: $cancellationPolicy, bookingMode: $bookingMode, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res>  {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) = _$QuoteCopyWithImpl;
@useResult
$Res call({
 String id, String vehicleId, DateTime pickupAt, DateTime returnAt, int days, List<LineItem> lineItems, Money total, Money deposit, List<ConditionalCharge> conditionalCharges, PolicyInfo cancellationPolicy,@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode bookingMode, DateTime expiresAt
});


$PolicyInfoCopyWith<$Res> get cancellationPolicy;

}
/// @nodoc
class _$QuoteCopyWithImpl<$Res>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vehicleId = null,Object? pickupAt = null,Object? returnAt = null,Object? days = null,Object? lineItems = null,Object? total = null,Object? deposit = null,Object? conditionalCharges = null,Object? cancellationPolicy = null,Object? bookingMode = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,pickupAt: null == pickupAt ? _self.pickupAt : pickupAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnAt: null == returnAt ? _self.returnAt : returnAt // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<LineItem>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as Money,conditionalCharges: null == conditionalCharges ? _self.conditionalCharges : conditionalCharges // ignore: cast_nullable_to_non_nullable
as List<ConditionalCharge>,cancellationPolicy: null == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as PolicyInfo,bookingMode: null == bookingMode ? _self.bookingMode : bookingMode // ignore: cast_nullable_to_non_nullable
as BookingMode,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<$Res> get cancellationPolicy {
  
  return $PolicyInfoCopyWith<$Res>(_self.cancellationPolicy, (value) {
    return _then(_self.copyWith(cancellationPolicy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Quote].
extension QuotePatterns on Quote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quote value)  $default,){
final _that = this;
switch (_that) {
case _Quote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quote value)?  $default,){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vehicleId,  DateTime pickupAt,  DateTime returnAt,  int days,  List<LineItem> lineItems,  Money total,  Money deposit,  List<ConditionalCharge> conditionalCharges,  PolicyInfo cancellationPolicy, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.vehicleId,_that.pickupAt,_that.returnAt,_that.days,_that.lineItems,_that.total,_that.deposit,_that.conditionalCharges,_that.cancellationPolicy,_that.bookingMode,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vehicleId,  DateTime pickupAt,  DateTime returnAt,  int days,  List<LineItem> lineItems,  Money total,  Money deposit,  List<ConditionalCharge> conditionalCharges,  PolicyInfo cancellationPolicy, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _Quote():
return $default(_that.id,_that.vehicleId,_that.pickupAt,_that.returnAt,_that.days,_that.lineItems,_that.total,_that.deposit,_that.conditionalCharges,_that.cancellationPolicy,_that.bookingMode,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vehicleId,  DateTime pickupAt,  DateTime returnAt,  int days,  List<LineItem> lineItems,  Money total,  Money deposit,  List<ConditionalCharge> conditionalCharges,  PolicyInfo cancellationPolicy, @JsonKey(unknownEnumValue: BookingMode.unknown)  BookingMode bookingMode,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.vehicleId,_that.pickupAt,_that.returnAt,_that.days,_that.lineItems,_that.total,_that.deposit,_that.conditionalCharges,_that.cancellationPolicy,_that.bookingMode,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quote implements Quote {
  const _Quote({required this.id, required this.vehicleId, required this.pickupAt, required this.returnAt, required this.days, required final  List<LineItem> lineItems, required this.total, required this.deposit, final  List<ConditionalCharge> conditionalCharges = const <ConditionalCharge>[], required this.cancellationPolicy, @JsonKey(unknownEnumValue: BookingMode.unknown) required this.bookingMode, required this.expiresAt}): _lineItems = lineItems,_conditionalCharges = conditionalCharges;
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

@override final  String id;
@override final  String vehicleId;
@override final  DateTime pickupAt;
@override final  DateTime returnAt;
@override final  int days;
 final  List<LineItem> _lineItems;
@override List<LineItem> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}

@override final  Money total;
@override final  Money deposit;
 final  List<ConditionalCharge> _conditionalCharges;
@override@JsonKey() List<ConditionalCharge> get conditionalCharges {
  if (_conditionalCharges is EqualUnmodifiableListView) return _conditionalCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conditionalCharges);
}

@override final  PolicyInfo cancellationPolicy;
@override@JsonKey(unknownEnumValue: BookingMode.unknown) final  BookingMode bookingMode;
@override final  DateTime expiresAt;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteCopyWith<_Quote> get copyWith => __$QuoteCopyWithImpl<_Quote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.pickupAt, pickupAt) || other.pickupAt == pickupAt)&&(identical(other.returnAt, returnAt) || other.returnAt == returnAt)&&(identical(other.days, days) || other.days == days)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems)&&(identical(other.total, total) || other.total == total)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&const DeepCollectionEquality().equals(other._conditionalCharges, _conditionalCharges)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.bookingMode, bookingMode) || other.bookingMode == bookingMode)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,pickupAt,returnAt,days,const DeepCollectionEquality().hash(_lineItems),total,deposit,const DeepCollectionEquality().hash(_conditionalCharges),cancellationPolicy,bookingMode,expiresAt);

@override
String toString() {
  return 'Quote(id: $id, vehicleId: $vehicleId, pickupAt: $pickupAt, returnAt: $returnAt, days: $days, lineItems: $lineItems, total: $total, deposit: $deposit, conditionalCharges: $conditionalCharges, cancellationPolicy: $cancellationPolicy, bookingMode: $bookingMode, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) = __$QuoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String vehicleId, DateTime pickupAt, DateTime returnAt, int days, List<LineItem> lineItems, Money total, Money deposit, List<ConditionalCharge> conditionalCharges, PolicyInfo cancellationPolicy,@JsonKey(unknownEnumValue: BookingMode.unknown) BookingMode bookingMode, DateTime expiresAt
});


@override $PolicyInfoCopyWith<$Res> get cancellationPolicy;

}
/// @nodoc
class __$QuoteCopyWithImpl<$Res>
    implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vehicleId = null,Object? pickupAt = null,Object? returnAt = null,Object? days = null,Object? lineItems = null,Object? total = null,Object? deposit = null,Object? conditionalCharges = null,Object? cancellationPolicy = null,Object? bookingMode = null,Object? expiresAt = null,}) {
  return _then(_Quote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,pickupAt: null == pickupAt ? _self.pickupAt : pickupAt // ignore: cast_nullable_to_non_nullable
as DateTime,returnAt: null == returnAt ? _self.returnAt : returnAt // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<LineItem>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as Money,conditionalCharges: null == conditionalCharges ? _self._conditionalCharges : conditionalCharges // ignore: cast_nullable_to_non_nullable
as List<ConditionalCharge>,cancellationPolicy: null == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as PolicyInfo,bookingMode: null == bookingMode ? _self.bookingMode : bookingMode // ignore: cast_nullable_to_non_nullable
as BookingMode,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolicyInfoCopyWith<$Res> get cancellationPolicy {
  
  return $PolicyInfoCopyWith<$Res>(_self.cancellationPolicy, (value) {
    return _then(_self.copyWith(cancellationPolicy: value));
  });
}
}


/// @nodoc
mixin _$PaymentIntent {

 String get provider; String get intentId; String? get clientSecret; Money get amount; String get status;
/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<PaymentIntent> get copyWith => _$PaymentIntentCopyWithImpl<PaymentIntent>(this as PaymentIntent, _$identity);

  /// Serializes this PaymentIntent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntent&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.intentId, intentId) || other.intentId == intentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,intentId,clientSecret,amount,status);

@override
String toString() {
  return 'PaymentIntent(provider: $provider, intentId: $intentId, clientSecret: $clientSecret, amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentCopyWith<$Res>  {
  factory $PaymentIntentCopyWith(PaymentIntent value, $Res Function(PaymentIntent) _then) = _$PaymentIntentCopyWithImpl;
@useResult
$Res call({
 String provider, String intentId, String? clientSecret, Money amount, String status
});




}
/// @nodoc
class _$PaymentIntentCopyWithImpl<$Res>
    implements $PaymentIntentCopyWith<$Res> {
  _$PaymentIntentCopyWithImpl(this._self, this._then);

  final PaymentIntent _self;
  final $Res Function(PaymentIntent) _then;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? intentId = null,Object? clientSecret = freezed,Object? amount = null,Object? status = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,intentId: null == intentId ? _self.intentId : intentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentIntent].
extension PaymentIntentPatterns on PaymentIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentIntent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentIntent value)  $default,){
final _that = this;
switch (_that) {
case _PaymentIntent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentIntent value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  String intentId,  String? clientSecret,  Money amount,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
return $default(_that.provider,_that.intentId,_that.clientSecret,_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  String intentId,  String? clientSecret,  Money amount,  String status)  $default,) {final _that = this;
switch (_that) {
case _PaymentIntent():
return $default(_that.provider,_that.intentId,_that.clientSecret,_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  String intentId,  String? clientSecret,  Money amount,  String status)?  $default,) {final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
return $default(_that.provider,_that.intentId,_that.clientSecret,_that.amount,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentIntent implements PaymentIntent {
  const _PaymentIntent({required this.provider, required this.intentId, this.clientSecret, required this.amount, required this.status});
  factory _PaymentIntent.fromJson(Map<String, dynamic> json) => _$PaymentIntentFromJson(json);

@override final  String provider;
@override final  String intentId;
@override final  String? clientSecret;
@override final  Money amount;
@override final  String status;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentCopyWith<_PaymentIntent> get copyWith => __$PaymentIntentCopyWithImpl<_PaymentIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntent&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.intentId, intentId) || other.intentId == intentId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,intentId,clientSecret,amount,status);

@override
String toString() {
  return 'PaymentIntent(provider: $provider, intentId: $intentId, clientSecret: $clientSecret, amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentCopyWith<$Res> implements $PaymentIntentCopyWith<$Res> {
  factory _$PaymentIntentCopyWith(_PaymentIntent value, $Res Function(_PaymentIntent) _then) = __$PaymentIntentCopyWithImpl;
@override @useResult
$Res call({
 String provider, String intentId, String? clientSecret, Money amount, String status
});




}
/// @nodoc
class __$PaymentIntentCopyWithImpl<$Res>
    implements _$PaymentIntentCopyWith<$Res> {
  __$PaymentIntentCopyWithImpl(this._self, this._then);

  final _PaymentIntent _self;
  final $Res Function(_PaymentIntent) _then;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? intentId = null,Object? clientSecret = freezed,Object? amount = null,Object? status = null,}) {
  return _then(_PaymentIntent(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,intentId: null == intentId ? _self.intentId : intentId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CancellationPreview {

 bool get eligible; bool get free; Money get fee; Money get refund; String? get reason;
/// Create a copy of CancellationPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancellationPreviewCopyWith<CancellationPreview> get copyWith => _$CancellationPreviewCopyWithImpl<CancellationPreview>(this as CancellationPreview, _$identity);

  /// Serializes this CancellationPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancellationPreview&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.free, free) || other.free == free)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eligible,free,fee,refund,reason);

@override
String toString() {
  return 'CancellationPreview(eligible: $eligible, free: $free, fee: $fee, refund: $refund, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CancellationPreviewCopyWith<$Res>  {
  factory $CancellationPreviewCopyWith(CancellationPreview value, $Res Function(CancellationPreview) _then) = _$CancellationPreviewCopyWithImpl;
@useResult
$Res call({
 bool eligible, bool free, Money fee, Money refund, String? reason
});




}
/// @nodoc
class _$CancellationPreviewCopyWithImpl<$Res>
    implements $CancellationPreviewCopyWith<$Res> {
  _$CancellationPreviewCopyWithImpl(this._self, this._then);

  final CancellationPreview _self;
  final $Res Function(CancellationPreview) _then;

/// Create a copy of CancellationPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eligible = null,Object? free = null,Object? fee = null,Object? refund = null,Object? reason = freezed,}) {
  return _then(_self.copyWith(
eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as bool,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money,refund: null == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as Money,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CancellationPreview].
extension CancellationPreviewPatterns on CancellationPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CancellationPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CancellationPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CancellationPreview value)  $default,){
final _that = this;
switch (_that) {
case _CancellationPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CancellationPreview value)?  $default,){
final _that = this;
switch (_that) {
case _CancellationPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool eligible,  bool free,  Money fee,  Money refund,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CancellationPreview() when $default != null:
return $default(_that.eligible,_that.free,_that.fee,_that.refund,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool eligible,  bool free,  Money fee,  Money refund,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _CancellationPreview():
return $default(_that.eligible,_that.free,_that.fee,_that.refund,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool eligible,  bool free,  Money fee,  Money refund,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _CancellationPreview() when $default != null:
return $default(_that.eligible,_that.free,_that.fee,_that.refund,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CancellationPreview implements CancellationPreview {
  const _CancellationPreview({required this.eligible, this.free = false, required this.fee, required this.refund, this.reason});
  factory _CancellationPreview.fromJson(Map<String, dynamic> json) => _$CancellationPreviewFromJson(json);

@override final  bool eligible;
@override@JsonKey() final  bool free;
@override final  Money fee;
@override final  Money refund;
@override final  String? reason;

/// Create a copy of CancellationPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancellationPreviewCopyWith<_CancellationPreview> get copyWith => __$CancellationPreviewCopyWithImpl<_CancellationPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CancellationPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancellationPreview&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.free, free) || other.free == free)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eligible,free,fee,refund,reason);

@override
String toString() {
  return 'CancellationPreview(eligible: $eligible, free: $free, fee: $fee, refund: $refund, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CancellationPreviewCopyWith<$Res> implements $CancellationPreviewCopyWith<$Res> {
  factory _$CancellationPreviewCopyWith(_CancellationPreview value, $Res Function(_CancellationPreview) _then) = __$CancellationPreviewCopyWithImpl;
@override @useResult
$Res call({
 bool eligible, bool free, Money fee, Money refund, String? reason
});




}
/// @nodoc
class __$CancellationPreviewCopyWithImpl<$Res>
    implements _$CancellationPreviewCopyWith<$Res> {
  __$CancellationPreviewCopyWithImpl(this._self, this._then);

  final _CancellationPreview _self;
  final $Res Function(_CancellationPreview) _then;

/// Create a copy of CancellationPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eligible = null,Object? free = null,Object? fee = null,Object? refund = null,Object? reason = freezed,}) {
  return _then(_CancellationPreview(
eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as bool,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money,refund: null == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as Money,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
