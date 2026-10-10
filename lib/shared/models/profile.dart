import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class NotificationPrefs with _$NotificationPrefs {
  const factory NotificationPrefs({
    @Default(true) bool email,
    @Default(true) bool push,
    @Default(false) bool marketing,
  }) = _NotificationPrefs;

  factory NotificationPrefs.fromJson(Map<String, dynamic> json) =>
      _$NotificationPrefsFromJson(json);
}

@freezed
abstract class AccountUser with _$AccountUser {
  const factory AccountUser({required String id, String? email}) = _AccountUser;

  factory AccountUser.fromJson(Map<String, dynamic> json) =>
      _$AccountUserFromJson(json);
}

@freezed
abstract class CustomerProfile with _$CustomerProfile {
  const factory CustomerProfile({
    String? fullName,
    String? phone,
    String? countryCode,
    String? cityId,
    @Default('en') String preferredLanguage,
    @Default(NotificationPrefs()) NotificationPrefs notificationPrefs,
    @JsonKey(unknownEnumValue: VerificationStatus.unknown)
    @Default(VerificationStatus.notStarted)
    VerificationStatus verificationStatus,
    DateTime? deletionRequestedAt,
  }) = _CustomerProfile;

  factory CustomerProfile.fromJson(Map<String, dynamic> json) =>
      _$CustomerProfileFromJson(json);
}

@freezed
abstract class PartnerMembership with _$PartnerMembership {
  const factory PartnerMembership({
    required String id,
    required String displayName,
    String? status,
    String? role,
  }) = _PartnerMembership;

  factory PartnerMembership.fromJson(Map<String, dynamic> json) =>
      _$PartnerMembershipFromJson(json);
}

/// `GET /me`.
@freezed
abstract class Me with _$Me {
  const factory Me({
    required AccountUser user,
    required CustomerProfile profile,
    @Default(false) bool profileComplete,
    @Default(false) bool isAdmin,
    PartnerMembership? partner,
  }) = _Me;

  factory Me.fromJson(Map<String, dynamic> json) => _$MeFromJson(json);
}

/// `PATCH /me` body. Only non-null fields are sent.
@freezed
abstract class ProfileUpdate with _$ProfileUpdate {
  const factory ProfileUpdate({
    String? fullName,
    String? phone,
    String? countryCode,
    String? cityId,
    String? preferredLanguage,
    NotificationPrefs? notificationPrefs,
  }) = _ProfileUpdate;

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateFromJson(json);
}

@freezed
abstract class RequiredDocument with _$RequiredDocument {
  const factory RequiredDocument({
    required String documentType,
    required String label,
    @Default(true) bool isRequired,
    @JsonKey(unknownEnumValue: DocumentStatus.unknown)
    required DocumentStatus status,
    String? rejectionReason,
  }) = _RequiredDocument;

  factory RequiredDocument.fromJson(Map<String, dynamic> json) =>
      _$RequiredDocumentFromJson(json);
}

/// `GET /me/verification`.
@freezed
abstract class VerificationState with _$VerificationState {
  const VerificationState._();

  const factory VerificationState({
    @JsonKey(unknownEnumValue: VerificationStatus.unknown)
    required VerificationStatus status,
    @Default(<RequiredDocument>[]) List<RequiredDocument> requiredDocuments,
  }) = _VerificationState;

  factory VerificationState.fromJson(Map<String, dynamic> json) =>
      _$VerificationStateFromJson(json);

  /// Booking requires `submitted` or `verified` (CONTRACTS §9.4).
  bool get allowsBooking =>
      status == VerificationStatus.submitted ||
      status == VerificationStatus.verified;

  List<RequiredDocument> get outstanding => requiredDocuments
      .where(
        (d) =>
            d.isRequired &&
            (d.status == DocumentStatus.missing ||
                d.status == DocumentStatus.rejected ||
                d.status == DocumentStatus.expired),
      )
      .toList();
}

@freezed
abstract class CustomerDocument with _$CustomerDocument {
  const factory CustomerDocument({
    required String id,
    required String documentType,
    String? fileName,
    @JsonKey(unknownEnumValue: DocumentStatus.unknown)
    required DocumentStatus status,
    String? expiresOn,
    DateTime? createdAt,
  }) = _CustomerDocument;

  factory CustomerDocument.fromJson(Map<String, dynamic> json) =>
      _$CustomerDocumentFromJson(json);
}

@freezed
abstract class SupportRequest with _$SupportRequest {
  const factory SupportRequest({
    required String id,
    required String subject,
    required String message,
    @JsonKey(unknownEnumValue: SupportStatus.unknown)
    @Default(SupportStatus.open)
    SupportStatus status,
    String? bookingId,
    DateTime? createdAt,
  }) = _SupportRequest;

  factory SupportRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportRequestFromJson(json);
}
