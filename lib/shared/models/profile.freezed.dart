// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPrefs {

 bool get email; bool get push; bool get marketing;
/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<NotificationPrefs> get copyWith => _$NotificationPrefsCopyWithImpl<NotificationPrefs>(this as NotificationPrefs, _$identity);

  /// Serializes this NotificationPrefs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPrefs&&(identical(other.email, email) || other.email == email)&&(identical(other.push, push) || other.push == push)&&(identical(other.marketing, marketing) || other.marketing == marketing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,push,marketing);

@override
String toString() {
  return 'NotificationPrefs(email: $email, push: $push, marketing: $marketing)';
}


}

/// @nodoc
abstract mixin class $NotificationPrefsCopyWith<$Res>  {
  factory $NotificationPrefsCopyWith(NotificationPrefs value, $Res Function(NotificationPrefs) _then) = _$NotificationPrefsCopyWithImpl;
@useResult
$Res call({
 bool email, bool push, bool marketing
});




}
/// @nodoc
class _$NotificationPrefsCopyWithImpl<$Res>
    implements $NotificationPrefsCopyWith<$Res> {
  _$NotificationPrefsCopyWithImpl(this._self, this._then);

  final NotificationPrefs _self;
  final $Res Function(NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? push = null,Object? marketing = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as bool,push: null == push ? _self.push : push // ignore: cast_nullable_to_non_nullable
as bool,marketing: null == marketing ? _self.marketing : marketing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPrefs].
extension NotificationPrefsPatterns on NotificationPrefs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPrefs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPrefs value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPrefs value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool email,  bool push,  bool marketing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.email,_that.push,_that.marketing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool email,  bool push,  bool marketing)  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs():
return $default(_that.email,_that.push,_that.marketing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool email,  bool push,  bool marketing)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.email,_that.push,_that.marketing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPrefs implements NotificationPrefs {
  const _NotificationPrefs({this.email = true, this.push = true, this.marketing = false});
  factory _NotificationPrefs.fromJson(Map<String, dynamic> json) => _$NotificationPrefsFromJson(json);

@override@JsonKey() final  bool email;
@override@JsonKey() final  bool push;
@override@JsonKey() final  bool marketing;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPrefsCopyWith<_NotificationPrefs> get copyWith => __$NotificationPrefsCopyWithImpl<_NotificationPrefs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPrefsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPrefs&&(identical(other.email, email) || other.email == email)&&(identical(other.push, push) || other.push == push)&&(identical(other.marketing, marketing) || other.marketing == marketing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,push,marketing);

@override
String toString() {
  return 'NotificationPrefs(email: $email, push: $push, marketing: $marketing)';
}


}

/// @nodoc
abstract mixin class _$NotificationPrefsCopyWith<$Res> implements $NotificationPrefsCopyWith<$Res> {
  factory _$NotificationPrefsCopyWith(_NotificationPrefs value, $Res Function(_NotificationPrefs) _then) = __$NotificationPrefsCopyWithImpl;
@override @useResult
$Res call({
 bool email, bool push, bool marketing
});




}
/// @nodoc
class __$NotificationPrefsCopyWithImpl<$Res>
    implements _$NotificationPrefsCopyWith<$Res> {
  __$NotificationPrefsCopyWithImpl(this._self, this._then);

  final _NotificationPrefs _self;
  final $Res Function(_NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? push = null,Object? marketing = null,}) {
  return _then(_NotificationPrefs(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as bool,push: null == push ? _self.push : push // ignore: cast_nullable_to_non_nullable
as bool,marketing: null == marketing ? _self.marketing : marketing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AccountUser {

 String get id; String? get email;
/// Create a copy of AccountUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountUserCopyWith<AccountUser> get copyWith => _$AccountUserCopyWithImpl<AccountUser>(this as AccountUser, _$identity);

  /// Serializes this AccountUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email);

@override
String toString() {
  return 'AccountUser(id: $id, email: $email)';
}


}

/// @nodoc
abstract mixin class $AccountUserCopyWith<$Res>  {
  factory $AccountUserCopyWith(AccountUser value, $Res Function(AccountUser) _then) = _$AccountUserCopyWithImpl;
@useResult
$Res call({
 String id, String? email
});




}
/// @nodoc
class _$AccountUserCopyWithImpl<$Res>
    implements $AccountUserCopyWith<$Res> {
  _$AccountUserCopyWithImpl(this._self, this._then);

  final AccountUser _self;
  final $Res Function(AccountUser) _then;

/// Create a copy of AccountUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountUser].
extension AccountUserPatterns on AccountUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountUser value)  $default,){
final _that = this;
switch (_that) {
case _AccountUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountUser value)?  $default,){
final _that = this;
switch (_that) {
case _AccountUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountUser() when $default != null:
return $default(_that.id,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email)  $default,) {final _that = this;
switch (_that) {
case _AccountUser():
return $default(_that.id,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _AccountUser() when $default != null:
return $default(_that.id,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountUser implements AccountUser {
  const _AccountUser({required this.id, this.email});
  factory _AccountUser.fromJson(Map<String, dynamic> json) => _$AccountUserFromJson(json);

@override final  String id;
@override final  String? email;

/// Create a copy of AccountUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountUserCopyWith<_AccountUser> get copyWith => __$AccountUserCopyWithImpl<_AccountUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email);

@override
String toString() {
  return 'AccountUser(id: $id, email: $email)';
}


}

/// @nodoc
abstract mixin class _$AccountUserCopyWith<$Res> implements $AccountUserCopyWith<$Res> {
  factory _$AccountUserCopyWith(_AccountUser value, $Res Function(_AccountUser) _then) = __$AccountUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email
});




}
/// @nodoc
class __$AccountUserCopyWithImpl<$Res>
    implements _$AccountUserCopyWith<$Res> {
  __$AccountUserCopyWithImpl(this._self, this._then);

  final _AccountUser _self;
  final $Res Function(_AccountUser) _then;

/// Create a copy of AccountUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,}) {
  return _then(_AccountUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CustomerProfile {

 String? get fullName; String? get phone; String? get countryCode; String? get cityId; String get preferredLanguage; NotificationPrefs get notificationPrefs;@JsonKey(unknownEnumValue: VerificationStatus.unknown) VerificationStatus get verificationStatus; DateTime? get deletionRequestedAt;
/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerProfileCopyWith<CustomerProfile> get copyWith => _$CustomerProfileCopyWithImpl<CustomerProfile>(this as CustomerProfile, _$identity);

  /// Serializes this CustomerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerProfile&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.deletionRequestedAt, deletionRequestedAt) || other.deletionRequestedAt == deletionRequestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,phone,countryCode,cityId,preferredLanguage,notificationPrefs,verificationStatus,deletionRequestedAt);

@override
String toString() {
  return 'CustomerProfile(fullName: $fullName, phone: $phone, countryCode: $countryCode, cityId: $cityId, preferredLanguage: $preferredLanguage, notificationPrefs: $notificationPrefs, verificationStatus: $verificationStatus, deletionRequestedAt: $deletionRequestedAt)';
}


}

/// @nodoc
abstract mixin class $CustomerProfileCopyWith<$Res>  {
  factory $CustomerProfileCopyWith(CustomerProfile value, $Res Function(CustomerProfile) _then) = _$CustomerProfileCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? phone, String? countryCode, String? cityId, String preferredLanguage, NotificationPrefs notificationPrefs,@JsonKey(unknownEnumValue: VerificationStatus.unknown) VerificationStatus verificationStatus, DateTime? deletionRequestedAt
});


$NotificationPrefsCopyWith<$Res> get notificationPrefs;

}
/// @nodoc
class _$CustomerProfileCopyWithImpl<$Res>
    implements $CustomerProfileCopyWith<$Res> {
  _$CustomerProfileCopyWithImpl(this._self, this._then);

  final CustomerProfile _self;
  final $Res Function(CustomerProfile) _then;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? phone = freezed,Object? countryCode = freezed,Object? cityId = freezed,Object? preferredLanguage = null,Object? notificationPrefs = null,Object? verificationStatus = null,Object? deletionRequestedAt = freezed,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,notificationPrefs: null == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPrefs,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as VerificationStatus,deletionRequestedAt: freezed == deletionRequestedAt ? _self.deletionRequestedAt : deletionRequestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<$Res> get notificationPrefs {
  
  return $NotificationPrefsCopyWith<$Res>(_self.notificationPrefs, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerProfile].
extension CustomerProfilePatterns on CustomerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerProfile value)  $default,){
final _that = this;
switch (_that) {
case _CustomerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? phone,  String? countryCode,  String? cityId,  String preferredLanguage,  NotificationPrefs notificationPrefs, @JsonKey(unknownEnumValue: VerificationStatus.unknown)  VerificationStatus verificationStatus,  DateTime? deletionRequestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
return $default(_that.fullName,_that.phone,_that.countryCode,_that.cityId,_that.preferredLanguage,_that.notificationPrefs,_that.verificationStatus,_that.deletionRequestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? phone,  String? countryCode,  String? cityId,  String preferredLanguage,  NotificationPrefs notificationPrefs, @JsonKey(unknownEnumValue: VerificationStatus.unknown)  VerificationStatus verificationStatus,  DateTime? deletionRequestedAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerProfile():
return $default(_that.fullName,_that.phone,_that.countryCode,_that.cityId,_that.preferredLanguage,_that.notificationPrefs,_that.verificationStatus,_that.deletionRequestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? phone,  String? countryCode,  String? cityId,  String preferredLanguage,  NotificationPrefs notificationPrefs, @JsonKey(unknownEnumValue: VerificationStatus.unknown)  VerificationStatus verificationStatus,  DateTime? deletionRequestedAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
return $default(_that.fullName,_that.phone,_that.countryCode,_that.cityId,_that.preferredLanguage,_that.notificationPrefs,_that.verificationStatus,_that.deletionRequestedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerProfile implements CustomerProfile {
  const _CustomerProfile({this.fullName, this.phone, this.countryCode, this.cityId, this.preferredLanguage = 'en', this.notificationPrefs = const NotificationPrefs(), @JsonKey(unknownEnumValue: VerificationStatus.unknown) this.verificationStatus = VerificationStatus.notStarted, this.deletionRequestedAt});
  factory _CustomerProfile.fromJson(Map<String, dynamic> json) => _$CustomerProfileFromJson(json);

@override final  String? fullName;
@override final  String? phone;
@override final  String? countryCode;
@override final  String? cityId;
@override@JsonKey() final  String preferredLanguage;
@override@JsonKey() final  NotificationPrefs notificationPrefs;
@override@JsonKey(unknownEnumValue: VerificationStatus.unknown) final  VerificationStatus verificationStatus;
@override final  DateTime? deletionRequestedAt;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerProfileCopyWith<_CustomerProfile> get copyWith => __$CustomerProfileCopyWithImpl<_CustomerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerProfile&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.deletionRequestedAt, deletionRequestedAt) || other.deletionRequestedAt == deletionRequestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,phone,countryCode,cityId,preferredLanguage,notificationPrefs,verificationStatus,deletionRequestedAt);

@override
String toString() {
  return 'CustomerProfile(fullName: $fullName, phone: $phone, countryCode: $countryCode, cityId: $cityId, preferredLanguage: $preferredLanguage, notificationPrefs: $notificationPrefs, verificationStatus: $verificationStatus, deletionRequestedAt: $deletionRequestedAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerProfileCopyWith<$Res> implements $CustomerProfileCopyWith<$Res> {
  factory _$CustomerProfileCopyWith(_CustomerProfile value, $Res Function(_CustomerProfile) _then) = __$CustomerProfileCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? phone, String? countryCode, String? cityId, String preferredLanguage, NotificationPrefs notificationPrefs,@JsonKey(unknownEnumValue: VerificationStatus.unknown) VerificationStatus verificationStatus, DateTime? deletionRequestedAt
});


@override $NotificationPrefsCopyWith<$Res> get notificationPrefs;

}
/// @nodoc
class __$CustomerProfileCopyWithImpl<$Res>
    implements _$CustomerProfileCopyWith<$Res> {
  __$CustomerProfileCopyWithImpl(this._self, this._then);

  final _CustomerProfile _self;
  final $Res Function(_CustomerProfile) _then;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? phone = freezed,Object? countryCode = freezed,Object? cityId = freezed,Object? preferredLanguage = null,Object? notificationPrefs = null,Object? verificationStatus = null,Object? deletionRequestedAt = freezed,}) {
  return _then(_CustomerProfile(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,notificationPrefs: null == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPrefs,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as VerificationStatus,deletionRequestedAt: freezed == deletionRequestedAt ? _self.deletionRequestedAt : deletionRequestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<$Res> get notificationPrefs {
  
  return $NotificationPrefsCopyWith<$Res>(_self.notificationPrefs, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}


/// @nodoc
mixin _$PartnerMembership {

 String get id; String get displayName; String? get status; String? get role;
/// Create a copy of PartnerMembership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnerMembershipCopyWith<PartnerMembership> get copyWith => _$PartnerMembershipCopyWithImpl<PartnerMembership>(this as PartnerMembership, _$identity);

  /// Serializes this PartnerMembership to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerMembership&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,status,role);

@override
String toString() {
  return 'PartnerMembership(id: $id, displayName: $displayName, status: $status, role: $role)';
}


}

/// @nodoc
abstract mixin class $PartnerMembershipCopyWith<$Res>  {
  factory $PartnerMembershipCopyWith(PartnerMembership value, $Res Function(PartnerMembership) _then) = _$PartnerMembershipCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String? status, String? role
});




}
/// @nodoc
class _$PartnerMembershipCopyWithImpl<$Res>
    implements $PartnerMembershipCopyWith<$Res> {
  _$PartnerMembershipCopyWithImpl(this._self, this._then);

  final PartnerMembership _self;
  final $Res Function(PartnerMembership) _then;

/// Create a copy of PartnerMembership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? status = freezed,Object? role = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnerMembership].
extension PartnerMembershipPatterns on PartnerMembership {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnerMembership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnerMembership() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnerMembership value)  $default,){
final _that = this;
switch (_that) {
case _PartnerMembership():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnerMembership value)?  $default,){
final _that = this;
switch (_that) {
case _PartnerMembership() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String? status,  String? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnerMembership() when $default != null:
return $default(_that.id,_that.displayName,_that.status,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String? status,  String? role)  $default,) {final _that = this;
switch (_that) {
case _PartnerMembership():
return $default(_that.id,_that.displayName,_that.status,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String? status,  String? role)?  $default,) {final _that = this;
switch (_that) {
case _PartnerMembership() when $default != null:
return $default(_that.id,_that.displayName,_that.status,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnerMembership implements PartnerMembership {
  const _PartnerMembership({required this.id, required this.displayName, this.status, this.role});
  factory _PartnerMembership.fromJson(Map<String, dynamic> json) => _$PartnerMembershipFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String? status;
@override final  String? role;

/// Create a copy of PartnerMembership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnerMembershipCopyWith<_PartnerMembership> get copyWith => __$PartnerMembershipCopyWithImpl<_PartnerMembership>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnerMembershipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnerMembership&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,status,role);

@override
String toString() {
  return 'PartnerMembership(id: $id, displayName: $displayName, status: $status, role: $role)';
}


}

/// @nodoc
abstract mixin class _$PartnerMembershipCopyWith<$Res> implements $PartnerMembershipCopyWith<$Res> {
  factory _$PartnerMembershipCopyWith(_PartnerMembership value, $Res Function(_PartnerMembership) _then) = __$PartnerMembershipCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String? status, String? role
});




}
/// @nodoc
class __$PartnerMembershipCopyWithImpl<$Res>
    implements _$PartnerMembershipCopyWith<$Res> {
  __$PartnerMembershipCopyWithImpl(this._self, this._then);

  final _PartnerMembership _self;
  final $Res Function(_PartnerMembership) _then;

/// Create a copy of PartnerMembership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? status = freezed,Object? role = freezed,}) {
  return _then(_PartnerMembership(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Me {

 AccountUser get user; CustomerProfile get profile; bool get profileComplete; bool get isAdmin; PartnerMembership? get partner;
/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeCopyWith<Me> get copyWith => _$MeCopyWithImpl<Me>(this as Me, _$identity);

  /// Serializes this Me to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Me&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.profileComplete, profileComplete) || other.profileComplete == profileComplete)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.partner, partner) || other.partner == partner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,profile,profileComplete,isAdmin,partner);

@override
String toString() {
  return 'Me(user: $user, profile: $profile, profileComplete: $profileComplete, isAdmin: $isAdmin, partner: $partner)';
}


}

/// @nodoc
abstract mixin class $MeCopyWith<$Res>  {
  factory $MeCopyWith(Me value, $Res Function(Me) _then) = _$MeCopyWithImpl;
@useResult
$Res call({
 AccountUser user, CustomerProfile profile, bool profileComplete, bool isAdmin, PartnerMembership? partner
});


$AccountUserCopyWith<$Res> get user;$CustomerProfileCopyWith<$Res> get profile;$PartnerMembershipCopyWith<$Res>? get partner;

}
/// @nodoc
class _$MeCopyWithImpl<$Res>
    implements $MeCopyWith<$Res> {
  _$MeCopyWithImpl(this._self, this._then);

  final Me _self;
  final $Res Function(Me) _then;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? profile = null,Object? profileComplete = null,Object? isAdmin = null,Object? partner = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AccountUser,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,profileComplete: null == profileComplete ? _self.profileComplete : profileComplete // ignore: cast_nullable_to_non_nullable
as bool,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,partner: freezed == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerMembership?,
  ));
}
/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountUserCopyWith<$Res> get user {
  
  return $AccountUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerProfileCopyWith<$Res> get profile {
  
  return $CustomerProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerMembershipCopyWith<$Res>? get partner {
    if (_self.partner == null) {
    return null;
  }

  return $PartnerMembershipCopyWith<$Res>(_self.partner!, (value) {
    return _then(_self.copyWith(partner: value));
  });
}
}


/// Adds pattern-matching-related methods to [Me].
extension MePatterns on Me {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Me value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Me() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Me value)  $default,){
final _that = this;
switch (_that) {
case _Me():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Me value)?  $default,){
final _that = this;
switch (_that) {
case _Me() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountUser user,  CustomerProfile profile,  bool profileComplete,  bool isAdmin,  PartnerMembership? partner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Me() when $default != null:
return $default(_that.user,_that.profile,_that.profileComplete,_that.isAdmin,_that.partner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountUser user,  CustomerProfile profile,  bool profileComplete,  bool isAdmin,  PartnerMembership? partner)  $default,) {final _that = this;
switch (_that) {
case _Me():
return $default(_that.user,_that.profile,_that.profileComplete,_that.isAdmin,_that.partner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountUser user,  CustomerProfile profile,  bool profileComplete,  bool isAdmin,  PartnerMembership? partner)?  $default,) {final _that = this;
switch (_that) {
case _Me() when $default != null:
return $default(_that.user,_that.profile,_that.profileComplete,_that.isAdmin,_that.partner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Me implements Me {
  const _Me({required this.user, required this.profile, this.profileComplete = false, this.isAdmin = false, this.partner});
  factory _Me.fromJson(Map<String, dynamic> json) => _$MeFromJson(json);

@override final  AccountUser user;
@override final  CustomerProfile profile;
@override@JsonKey() final  bool profileComplete;
@override@JsonKey() final  bool isAdmin;
@override final  PartnerMembership? partner;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeCopyWith<_Me> get copyWith => __$MeCopyWithImpl<_Me>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Me&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.profileComplete, profileComplete) || other.profileComplete == profileComplete)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.partner, partner) || other.partner == partner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,profile,profileComplete,isAdmin,partner);

@override
String toString() {
  return 'Me(user: $user, profile: $profile, profileComplete: $profileComplete, isAdmin: $isAdmin, partner: $partner)';
}


}

/// @nodoc
abstract mixin class _$MeCopyWith<$Res> implements $MeCopyWith<$Res> {
  factory _$MeCopyWith(_Me value, $Res Function(_Me) _then) = __$MeCopyWithImpl;
@override @useResult
$Res call({
 AccountUser user, CustomerProfile profile, bool profileComplete, bool isAdmin, PartnerMembership? partner
});


@override $AccountUserCopyWith<$Res> get user;@override $CustomerProfileCopyWith<$Res> get profile;@override $PartnerMembershipCopyWith<$Res>? get partner;

}
/// @nodoc
class __$MeCopyWithImpl<$Res>
    implements _$MeCopyWith<$Res> {
  __$MeCopyWithImpl(this._self, this._then);

  final _Me _self;
  final $Res Function(_Me) _then;

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? profile = null,Object? profileComplete = null,Object? isAdmin = null,Object? partner = freezed,}) {
  return _then(_Me(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AccountUser,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,profileComplete: null == profileComplete ? _self.profileComplete : profileComplete // ignore: cast_nullable_to_non_nullable
as bool,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,partner: freezed == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerMembership?,
  ));
}

/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountUserCopyWith<$Res> get user {
  
  return $AccountUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerProfileCopyWith<$Res> get profile {
  
  return $CustomerProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of Me
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerMembershipCopyWith<$Res>? get partner {
    if (_self.partner == null) {
    return null;
  }

  return $PartnerMembershipCopyWith<$Res>(_self.partner!, (value) {
    return _then(_self.copyWith(partner: value));
  });
}
}


/// @nodoc
mixin _$ProfileUpdate {

 String? get fullName; String? get phone; String? get countryCode; String? get cityId; String? get preferredLanguage; NotificationPrefs? get notificationPrefs;
/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateCopyWith<ProfileUpdate> get copyWith => _$ProfileUpdateCopyWithImpl<ProfileUpdate>(this as ProfileUpdate, _$identity);

  /// Serializes this ProfileUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdate&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,phone,countryCode,cityId,preferredLanguage,notificationPrefs);

@override
String toString() {
  return 'ProfileUpdate(fullName: $fullName, phone: $phone, countryCode: $countryCode, cityId: $cityId, preferredLanguage: $preferredLanguage, notificationPrefs: $notificationPrefs)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateCopyWith<$Res>  {
  factory $ProfileUpdateCopyWith(ProfileUpdate value, $Res Function(ProfileUpdate) _then) = _$ProfileUpdateCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? phone, String? countryCode, String? cityId, String? preferredLanguage, NotificationPrefs? notificationPrefs
});


$NotificationPrefsCopyWith<$Res>? get notificationPrefs;

}
/// @nodoc
class _$ProfileUpdateCopyWithImpl<$Res>
    implements $ProfileUpdateCopyWith<$Res> {
  _$ProfileUpdateCopyWithImpl(this._self, this._then);

  final ProfileUpdate _self;
  final $Res Function(ProfileUpdate) _then;

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? phone = freezed,Object? countryCode = freezed,Object? cityId = freezed,Object? preferredLanguage = freezed,Object? notificationPrefs = freezed,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: freezed == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String?,notificationPrefs: freezed == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPrefs?,
  ));
}
/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<$Res>? get notificationPrefs {
    if (_self.notificationPrefs == null) {
    return null;
  }

  return $NotificationPrefsCopyWith<$Res>(_self.notificationPrefs!, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileUpdate].
extension ProfileUpdatePatterns on ProfileUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileUpdate value)  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? phone,  String? countryCode,  String? cityId,  String? preferredLanguage,  NotificationPrefs? notificationPrefs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
return $default(_that.fullName,_that.phone,_that.countryCode,_that.cityId,_that.preferredLanguage,_that.notificationPrefs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? phone,  String? countryCode,  String? cityId,  String? preferredLanguage,  NotificationPrefs? notificationPrefs)  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdate():
return $default(_that.fullName,_that.phone,_that.countryCode,_that.cityId,_that.preferredLanguage,_that.notificationPrefs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? phone,  String? countryCode,  String? cityId,  String? preferredLanguage,  NotificationPrefs? notificationPrefs)?  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
return $default(_that.fullName,_that.phone,_that.countryCode,_that.cityId,_that.preferredLanguage,_that.notificationPrefs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileUpdate implements ProfileUpdate {
  const _ProfileUpdate({this.fullName, this.phone, this.countryCode, this.cityId, this.preferredLanguage, this.notificationPrefs});
  factory _ProfileUpdate.fromJson(Map<String, dynamic> json) => _$ProfileUpdateFromJson(json);

@override final  String? fullName;
@override final  String? phone;
@override final  String? countryCode;
@override final  String? cityId;
@override final  String? preferredLanguage;
@override final  NotificationPrefs? notificationPrefs;

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUpdateCopyWith<_ProfileUpdate> get copyWith => __$ProfileUpdateCopyWithImpl<_ProfileUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUpdate&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.notificationPrefs, notificationPrefs) || other.notificationPrefs == notificationPrefs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,phone,countryCode,cityId,preferredLanguage,notificationPrefs);

@override
String toString() {
  return 'ProfileUpdate(fullName: $fullName, phone: $phone, countryCode: $countryCode, cityId: $cityId, preferredLanguage: $preferredLanguage, notificationPrefs: $notificationPrefs)';
}


}

/// @nodoc
abstract mixin class _$ProfileUpdateCopyWith<$Res> implements $ProfileUpdateCopyWith<$Res> {
  factory _$ProfileUpdateCopyWith(_ProfileUpdate value, $Res Function(_ProfileUpdate) _then) = __$ProfileUpdateCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? phone, String? countryCode, String? cityId, String? preferredLanguage, NotificationPrefs? notificationPrefs
});


@override $NotificationPrefsCopyWith<$Res>? get notificationPrefs;

}
/// @nodoc
class __$ProfileUpdateCopyWithImpl<$Res>
    implements _$ProfileUpdateCopyWith<$Res> {
  __$ProfileUpdateCopyWithImpl(this._self, this._then);

  final _ProfileUpdate _self;
  final $Res Function(_ProfileUpdate) _then;

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? phone = freezed,Object? countryCode = freezed,Object? cityId = freezed,Object? preferredLanguage = freezed,Object? notificationPrefs = freezed,}) {
  return _then(_ProfileUpdate(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: freezed == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String?,notificationPrefs: freezed == notificationPrefs ? _self.notificationPrefs : notificationPrefs // ignore: cast_nullable_to_non_nullable
as NotificationPrefs?,
  ));
}

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<$Res>? get notificationPrefs {
    if (_self.notificationPrefs == null) {
    return null;
  }

  return $NotificationPrefsCopyWith<$Res>(_self.notificationPrefs!, (value) {
    return _then(_self.copyWith(notificationPrefs: value));
  });
}
}


/// @nodoc
mixin _$RequiredDocument {

 String get documentType; String get label; bool get isRequired;@JsonKey(unknownEnumValue: DocumentStatus.unknown) DocumentStatus get status; String? get rejectionReason;
/// Create a copy of RequiredDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredDocumentCopyWith<RequiredDocument> get copyWith => _$RequiredDocumentCopyWithImpl<RequiredDocument>(this as RequiredDocument, _$identity);

  /// Serializes this RequiredDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredDocument&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.label, label) || other.label == label)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentType,label,isRequired,status,rejectionReason);

@override
String toString() {
  return 'RequiredDocument(documentType: $documentType, label: $label, isRequired: $isRequired, status: $status, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $RequiredDocumentCopyWith<$Res>  {
  factory $RequiredDocumentCopyWith(RequiredDocument value, $Res Function(RequiredDocument) _then) = _$RequiredDocumentCopyWithImpl;
@useResult
$Res call({
 String documentType, String label, bool isRequired,@JsonKey(unknownEnumValue: DocumentStatus.unknown) DocumentStatus status, String? rejectionReason
});




}
/// @nodoc
class _$RequiredDocumentCopyWithImpl<$Res>
    implements $RequiredDocumentCopyWith<$Res> {
  _$RequiredDocumentCopyWithImpl(this._self, this._then);

  final RequiredDocument _self;
  final $Res Function(RequiredDocument) _then;

/// Create a copy of RequiredDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentType = null,Object? label = null,Object? isRequired = null,Object? status = null,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequiredDocument].
extension RequiredDocumentPatterns on RequiredDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequiredDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequiredDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequiredDocument value)  $default,){
final _that = this;
switch (_that) {
case _RequiredDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequiredDocument value)?  $default,){
final _that = this;
switch (_that) {
case _RequiredDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String documentType,  String label,  bool isRequired, @JsonKey(unknownEnumValue: DocumentStatus.unknown)  DocumentStatus status,  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequiredDocument() when $default != null:
return $default(_that.documentType,_that.label,_that.isRequired,_that.status,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String documentType,  String label,  bool isRequired, @JsonKey(unknownEnumValue: DocumentStatus.unknown)  DocumentStatus status,  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _RequiredDocument():
return $default(_that.documentType,_that.label,_that.isRequired,_that.status,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String documentType,  String label,  bool isRequired, @JsonKey(unknownEnumValue: DocumentStatus.unknown)  DocumentStatus status,  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _RequiredDocument() when $default != null:
return $default(_that.documentType,_that.label,_that.isRequired,_that.status,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequiredDocument implements RequiredDocument {
  const _RequiredDocument({required this.documentType, required this.label, this.isRequired = true, @JsonKey(unknownEnumValue: DocumentStatus.unknown) required this.status, this.rejectionReason});
  factory _RequiredDocument.fromJson(Map<String, dynamic> json) => _$RequiredDocumentFromJson(json);

@override final  String documentType;
@override final  String label;
@override@JsonKey() final  bool isRequired;
@override@JsonKey(unknownEnumValue: DocumentStatus.unknown) final  DocumentStatus status;
@override final  String? rejectionReason;

/// Create a copy of RequiredDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequiredDocumentCopyWith<_RequiredDocument> get copyWith => __$RequiredDocumentCopyWithImpl<_RequiredDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequiredDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequiredDocument&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.label, label) || other.label == label)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentType,label,isRequired,status,rejectionReason);

@override
String toString() {
  return 'RequiredDocument(documentType: $documentType, label: $label, isRequired: $isRequired, status: $status, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$RequiredDocumentCopyWith<$Res> implements $RequiredDocumentCopyWith<$Res> {
  factory _$RequiredDocumentCopyWith(_RequiredDocument value, $Res Function(_RequiredDocument) _then) = __$RequiredDocumentCopyWithImpl;
@override @useResult
$Res call({
 String documentType, String label, bool isRequired,@JsonKey(unknownEnumValue: DocumentStatus.unknown) DocumentStatus status, String? rejectionReason
});




}
/// @nodoc
class __$RequiredDocumentCopyWithImpl<$Res>
    implements _$RequiredDocumentCopyWith<$Res> {
  __$RequiredDocumentCopyWithImpl(this._self, this._then);

  final _RequiredDocument _self;
  final $Res Function(_RequiredDocument) _then;

/// Create a copy of RequiredDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentType = null,Object? label = null,Object? isRequired = null,Object? status = null,Object? rejectionReason = freezed,}) {
  return _then(_RequiredDocument(
documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VerificationState {

@JsonKey(unknownEnumValue: VerificationStatus.unknown) VerificationStatus get status; List<RequiredDocument> get requiredDocuments;
/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationStateCopyWith<VerificationState> get copyWith => _$VerificationStateCopyWithImpl<VerificationState>(this as VerificationState, _$identity);

  /// Serializes this VerificationState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.requiredDocuments, requiredDocuments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(requiredDocuments));

@override
String toString() {
  return 'VerificationState(status: $status, requiredDocuments: $requiredDocuments)';
}


}

/// @nodoc
abstract mixin class $VerificationStateCopyWith<$Res>  {
  factory $VerificationStateCopyWith(VerificationState value, $Res Function(VerificationState) _then) = _$VerificationStateCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: VerificationStatus.unknown) VerificationStatus status, List<RequiredDocument> requiredDocuments
});




}
/// @nodoc
class _$VerificationStateCopyWithImpl<$Res>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._self, this._then);

  final VerificationState _self;
  final $Res Function(VerificationState) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? requiredDocuments = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VerificationStatus,requiredDocuments: null == requiredDocuments ? _self.requiredDocuments : requiredDocuments // ignore: cast_nullable_to_non_nullable
as List<RequiredDocument>,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationState].
extension VerificationStatePatterns on VerificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationState value)  $default,){
final _that = this;
switch (_that) {
case _VerificationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationState value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: VerificationStatus.unknown)  VerificationStatus status,  List<RequiredDocument> requiredDocuments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that.status,_that.requiredDocuments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: VerificationStatus.unknown)  VerificationStatus status,  List<RequiredDocument> requiredDocuments)  $default,) {final _that = this;
switch (_that) {
case _VerificationState():
return $default(_that.status,_that.requiredDocuments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: VerificationStatus.unknown)  VerificationStatus status,  List<RequiredDocument> requiredDocuments)?  $default,) {final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that.status,_that.requiredDocuments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerificationState extends VerificationState {
  const _VerificationState({@JsonKey(unknownEnumValue: VerificationStatus.unknown) required this.status, final  List<RequiredDocument> requiredDocuments = const <RequiredDocument>[]}): _requiredDocuments = requiredDocuments,super._();
  factory _VerificationState.fromJson(Map<String, dynamic> json) => _$VerificationStateFromJson(json);

@override@JsonKey(unknownEnumValue: VerificationStatus.unknown) final  VerificationStatus status;
 final  List<RequiredDocument> _requiredDocuments;
@override@JsonKey() List<RequiredDocument> get requiredDocuments {
  if (_requiredDocuments is EqualUnmodifiableListView) return _requiredDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredDocuments);
}


/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationStateCopyWith<_VerificationState> get copyWith => __$VerificationStateCopyWithImpl<_VerificationState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerificationStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._requiredDocuments, _requiredDocuments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_requiredDocuments));

@override
String toString() {
  return 'VerificationState(status: $status, requiredDocuments: $requiredDocuments)';
}


}

/// @nodoc
abstract mixin class _$VerificationStateCopyWith<$Res> implements $VerificationStateCopyWith<$Res> {
  factory _$VerificationStateCopyWith(_VerificationState value, $Res Function(_VerificationState) _then) = __$VerificationStateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: VerificationStatus.unknown) VerificationStatus status, List<RequiredDocument> requiredDocuments
});




}
/// @nodoc
class __$VerificationStateCopyWithImpl<$Res>
    implements _$VerificationStateCopyWith<$Res> {
  __$VerificationStateCopyWithImpl(this._self, this._then);

  final _VerificationState _self;
  final $Res Function(_VerificationState) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? requiredDocuments = null,}) {
  return _then(_VerificationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VerificationStatus,requiredDocuments: null == requiredDocuments ? _self._requiredDocuments : requiredDocuments // ignore: cast_nullable_to_non_nullable
as List<RequiredDocument>,
  ));
}


}


/// @nodoc
mixin _$CustomerDocument {

 String get id; String get documentType; String? get fileName;@JsonKey(unknownEnumValue: DocumentStatus.unknown) DocumentStatus get status; String? get expiresOn; DateTime? get createdAt;
/// Create a copy of CustomerDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerDocumentCopyWith<CustomerDocument> get copyWith => _$CustomerDocumentCopyWithImpl<CustomerDocument>(this as CustomerDocument, _$identity);

  /// Serializes this CustomerDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresOn, expiresOn) || other.expiresOn == expiresOn)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentType,fileName,status,expiresOn,createdAt);

@override
String toString() {
  return 'CustomerDocument(id: $id, documentType: $documentType, fileName: $fileName, status: $status, expiresOn: $expiresOn, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CustomerDocumentCopyWith<$Res>  {
  factory $CustomerDocumentCopyWith(CustomerDocument value, $Res Function(CustomerDocument) _then) = _$CustomerDocumentCopyWithImpl;
@useResult
$Res call({
 String id, String documentType, String? fileName,@JsonKey(unknownEnumValue: DocumentStatus.unknown) DocumentStatus status, String? expiresOn, DateTime? createdAt
});




}
/// @nodoc
class _$CustomerDocumentCopyWithImpl<$Res>
    implements $CustomerDocumentCopyWith<$Res> {
  _$CustomerDocumentCopyWithImpl(this._self, this._then);

  final CustomerDocument _self;
  final $Res Function(CustomerDocument) _then;

/// Create a copy of CustomerDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentType = null,Object? fileName = freezed,Object? status = null,Object? expiresOn = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,expiresOn: freezed == expiresOn ? _self.expiresOn : expiresOn // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerDocument].
extension CustomerDocumentPatterns on CustomerDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerDocument value)  $default,){
final _that = this;
switch (_that) {
case _CustomerDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerDocument value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String documentType,  String? fileName, @JsonKey(unknownEnumValue: DocumentStatus.unknown)  DocumentStatus status,  String? expiresOn,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerDocument() when $default != null:
return $default(_that.id,_that.documentType,_that.fileName,_that.status,_that.expiresOn,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String documentType,  String? fileName, @JsonKey(unknownEnumValue: DocumentStatus.unknown)  DocumentStatus status,  String? expiresOn,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerDocument():
return $default(_that.id,_that.documentType,_that.fileName,_that.status,_that.expiresOn,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String documentType,  String? fileName, @JsonKey(unknownEnumValue: DocumentStatus.unknown)  DocumentStatus status,  String? expiresOn,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerDocument() when $default != null:
return $default(_that.id,_that.documentType,_that.fileName,_that.status,_that.expiresOn,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerDocument implements CustomerDocument {
  const _CustomerDocument({required this.id, required this.documentType, this.fileName, @JsonKey(unknownEnumValue: DocumentStatus.unknown) required this.status, this.expiresOn, this.createdAt});
  factory _CustomerDocument.fromJson(Map<String, dynamic> json) => _$CustomerDocumentFromJson(json);

@override final  String id;
@override final  String documentType;
@override final  String? fileName;
@override@JsonKey(unknownEnumValue: DocumentStatus.unknown) final  DocumentStatus status;
@override final  String? expiresOn;
@override final  DateTime? createdAt;

/// Create a copy of CustomerDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerDocumentCopyWith<_CustomerDocument> get copyWith => __$CustomerDocumentCopyWithImpl<_CustomerDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresOn, expiresOn) || other.expiresOn == expiresOn)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentType,fileName,status,expiresOn,createdAt);

@override
String toString() {
  return 'CustomerDocument(id: $id, documentType: $documentType, fileName: $fileName, status: $status, expiresOn: $expiresOn, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerDocumentCopyWith<$Res> implements $CustomerDocumentCopyWith<$Res> {
  factory _$CustomerDocumentCopyWith(_CustomerDocument value, $Res Function(_CustomerDocument) _then) = __$CustomerDocumentCopyWithImpl;
@override @useResult
$Res call({
 String id, String documentType, String? fileName,@JsonKey(unknownEnumValue: DocumentStatus.unknown) DocumentStatus status, String? expiresOn, DateTime? createdAt
});




}
/// @nodoc
class __$CustomerDocumentCopyWithImpl<$Res>
    implements _$CustomerDocumentCopyWith<$Res> {
  __$CustomerDocumentCopyWithImpl(this._self, this._then);

  final _CustomerDocument _self;
  final $Res Function(_CustomerDocument) _then;

/// Create a copy of CustomerDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentType = null,Object? fileName = freezed,Object? status = null,Object? expiresOn = freezed,Object? createdAt = freezed,}) {
  return _then(_CustomerDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,expiresOn: freezed == expiresOn ? _self.expiresOn : expiresOn // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SupportRequest {

 String get id; String get subject; String get message;@JsonKey(unknownEnumValue: SupportStatus.unknown) SupportStatus get status; String? get bookingId; DateTime? get createdAt;
/// Create a copy of SupportRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportRequestCopyWith<SupportRequest> get copyWith => _$SupportRequestCopyWithImpl<SupportRequest>(this as SupportRequest, _$identity);

  /// Serializes this SupportRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,message,status,bookingId,createdAt);

@override
String toString() {
  return 'SupportRequest(id: $id, subject: $subject, message: $message, status: $status, bookingId: $bookingId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SupportRequestCopyWith<$Res>  {
  factory $SupportRequestCopyWith(SupportRequest value, $Res Function(SupportRequest) _then) = _$SupportRequestCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String message,@JsonKey(unknownEnumValue: SupportStatus.unknown) SupportStatus status, String? bookingId, DateTime? createdAt
});




}
/// @nodoc
class _$SupportRequestCopyWithImpl<$Res>
    implements $SupportRequestCopyWith<$Res> {
  _$SupportRequestCopyWithImpl(this._self, this._then);

  final SupportRequest _self;
  final $Res Function(SupportRequest) _then;

/// Create a copy of SupportRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? message = null,Object? status = null,Object? bookingId = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SupportStatus,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportRequest].
extension SupportRequestPatterns on SupportRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportRequest value)  $default,){
final _that = this;
switch (_that) {
case _SupportRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SupportRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subject,  String message, @JsonKey(unknownEnumValue: SupportStatus.unknown)  SupportStatus status,  String? bookingId,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportRequest() when $default != null:
return $default(_that.id,_that.subject,_that.message,_that.status,_that.bookingId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subject,  String message, @JsonKey(unknownEnumValue: SupportStatus.unknown)  SupportStatus status,  String? bookingId,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SupportRequest():
return $default(_that.id,_that.subject,_that.message,_that.status,_that.bookingId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subject,  String message, @JsonKey(unknownEnumValue: SupportStatus.unknown)  SupportStatus status,  String? bookingId,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SupportRequest() when $default != null:
return $default(_that.id,_that.subject,_that.message,_that.status,_that.bookingId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportRequest implements SupportRequest {
  const _SupportRequest({required this.id, required this.subject, required this.message, @JsonKey(unknownEnumValue: SupportStatus.unknown) this.status = SupportStatus.open, this.bookingId, this.createdAt});
  factory _SupportRequest.fromJson(Map<String, dynamic> json) => _$SupportRequestFromJson(json);

@override final  String id;
@override final  String subject;
@override final  String message;
@override@JsonKey(unknownEnumValue: SupportStatus.unknown) final  SupportStatus status;
@override final  String? bookingId;
@override final  DateTime? createdAt;

/// Create a copy of SupportRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportRequestCopyWith<_SupportRequest> get copyWith => __$SupportRequestCopyWithImpl<_SupportRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,message,status,bookingId,createdAt);

@override
String toString() {
  return 'SupportRequest(id: $id, subject: $subject, message: $message, status: $status, bookingId: $bookingId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SupportRequestCopyWith<$Res> implements $SupportRequestCopyWith<$Res> {
  factory _$SupportRequestCopyWith(_SupportRequest value, $Res Function(_SupportRequest) _then) = __$SupportRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String message,@JsonKey(unknownEnumValue: SupportStatus.unknown) SupportStatus status, String? bookingId, DateTime? createdAt
});




}
/// @nodoc
class __$SupportRequestCopyWithImpl<$Res>
    implements _$SupportRequestCopyWith<$Res> {
  __$SupportRequestCopyWithImpl(this._self, this._then);

  final _SupportRequest _self;
  final $Res Function(_SupportRequest) _then;

/// Create a copy of SupportRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? message = null,Object? status = null,Object? bookingId = freezed,Object? createdAt = freezed,}) {
  return _then(_SupportRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SupportStatus,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
