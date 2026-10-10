// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPrefs _$NotificationPrefsFromJson(Map<String, dynamic> json) =>
    _NotificationPrefs(
      email: json['email'] as bool? ?? true,
      push: json['push'] as bool? ?? true,
      marketing: json['marketing'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationPrefsToJson(_NotificationPrefs instance) =>
    <String, dynamic>{
      'email': instance.email,
      'push': instance.push,
      'marketing': instance.marketing,
    };

_AccountUser _$AccountUserFromJson(Map<String, dynamic> json) =>
    _AccountUser(id: json['id'] as String, email: json['email'] as String?);

Map<String, dynamic> _$AccountUserToJson(_AccountUser instance) =>
    <String, dynamic>{'id': instance.id, 'email': ?instance.email};

_CustomerProfile _$CustomerProfileFromJson(Map<String, dynamic> json) =>
    _CustomerProfile(
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      cityId: json['cityId'] as String?,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
      notificationPrefs: json['notificationPrefs'] == null
          ? const NotificationPrefs()
          : NotificationPrefs.fromJson(
              json['notificationPrefs'] as Map<String, dynamic>,
            ),
      verificationStatus:
          $enumDecodeNullable(
            _$VerificationStatusEnumMap,
            json['verificationStatus'],
            unknownValue: VerificationStatus.unknown,
          ) ??
          VerificationStatus.notStarted,
      deletionRequestedAt: json['deletionRequestedAt'] == null
          ? null
          : DateTime.parse(json['deletionRequestedAt'] as String),
    );

Map<String, dynamic> _$CustomerProfileToJson(_CustomerProfile instance) =>
    <String, dynamic>{
      'fullName': ?instance.fullName,
      'phone': ?instance.phone,
      'countryCode': ?instance.countryCode,
      'cityId': ?instance.cityId,
      'preferredLanguage': instance.preferredLanguage,
      'notificationPrefs': instance.notificationPrefs.toJson(),
      'verificationStatus':
          _$VerificationStatusEnumMap[instance.verificationStatus]!,
      'deletionRequestedAt': ?instance.deletionRequestedAt?.toIso8601String(),
    };

const _$VerificationStatusEnumMap = {
  VerificationStatus.notStarted: 'not_started',
  VerificationStatus.submitted: 'submitted',
  VerificationStatus.verified: 'verified',
  VerificationStatus.rejected: 'rejected',
  VerificationStatus.unknown: 'unknown',
};

_PartnerMembership _$PartnerMembershipFromJson(Map<String, dynamic> json) =>
    _PartnerMembership(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      status: json['status'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$PartnerMembershipToJson(_PartnerMembership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'status': ?instance.status,
      'role': ?instance.role,
    };

_Me _$MeFromJson(Map<String, dynamic> json) => _Me(
  user: AccountUser.fromJson(json['user'] as Map<String, dynamic>),
  profile: CustomerProfile.fromJson(json['profile'] as Map<String, dynamic>),
  profileComplete: json['profileComplete'] as bool? ?? false,
  isAdmin: json['isAdmin'] as bool? ?? false,
  partner: json['partner'] == null
      ? null
      : PartnerMembership.fromJson(json['partner'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MeToJson(_Me instance) => <String, dynamic>{
  'user': instance.user.toJson(),
  'profile': instance.profile.toJson(),
  'profileComplete': instance.profileComplete,
  'isAdmin': instance.isAdmin,
  'partner': ?instance.partner?.toJson(),
};

_ProfileUpdate _$ProfileUpdateFromJson(Map<String, dynamic> json) =>
    _ProfileUpdate(
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      cityId: json['cityId'] as String?,
      preferredLanguage: json['preferredLanguage'] as String?,
      notificationPrefs: json['notificationPrefs'] == null
          ? null
          : NotificationPrefs.fromJson(
              json['notificationPrefs'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProfileUpdateToJson(_ProfileUpdate instance) =>
    <String, dynamic>{
      'fullName': ?instance.fullName,
      'phone': ?instance.phone,
      'countryCode': ?instance.countryCode,
      'cityId': ?instance.cityId,
      'preferredLanguage': ?instance.preferredLanguage,
      'notificationPrefs': ?instance.notificationPrefs?.toJson(),
    };

_RequiredDocument _$RequiredDocumentFromJson(Map<String, dynamic> json) =>
    _RequiredDocument(
      documentType: json['documentType'] as String,
      label: json['label'] as String,
      isRequired: json['isRequired'] as bool? ?? true,
      status: $enumDecode(
        _$DocumentStatusEnumMap,
        json['status'],
        unknownValue: DocumentStatus.unknown,
      ),
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$RequiredDocumentToJson(_RequiredDocument instance) =>
    <String, dynamic>{
      'documentType': instance.documentType,
      'label': instance.label,
      'isRequired': instance.isRequired,
      'status': _$DocumentStatusEnumMap[instance.status]!,
      'rejectionReason': ?instance.rejectionReason,
    };

const _$DocumentStatusEnumMap = {
  DocumentStatus.missing: 'missing',
  DocumentStatus.submitted: 'submitted',
  DocumentStatus.approved: 'approved',
  DocumentStatus.rejected: 'rejected',
  DocumentStatus.expired: 'expired',
  DocumentStatus.unknown: 'unknown',
};

_VerificationState _$VerificationStateFromJson(Map<String, dynamic> json) =>
    _VerificationState(
      status: $enumDecode(
        _$VerificationStatusEnumMap,
        json['status'],
        unknownValue: VerificationStatus.unknown,
      ),
      requiredDocuments:
          (json['requiredDocuments'] as List<dynamic>?)
              ?.map((e) => RequiredDocument.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RequiredDocument>[],
    );

Map<String, dynamic> _$VerificationStateToJson(_VerificationState instance) =>
    <String, dynamic>{
      'status': _$VerificationStatusEnumMap[instance.status]!,
      'requiredDocuments': instance.requiredDocuments
          .map((e) => e.toJson())
          .toList(),
    };

_CustomerDocument _$CustomerDocumentFromJson(Map<String, dynamic> json) =>
    _CustomerDocument(
      id: json['id'] as String,
      documentType: json['documentType'] as String,
      fileName: json['fileName'] as String?,
      status: $enumDecode(
        _$DocumentStatusEnumMap,
        json['status'],
        unknownValue: DocumentStatus.unknown,
      ),
      expiresOn: json['expiresOn'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CustomerDocumentToJson(_CustomerDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentType': instance.documentType,
      'fileName': ?instance.fileName,
      'status': _$DocumentStatusEnumMap[instance.status]!,
      'expiresOn': ?instance.expiresOn,
      'createdAt': ?instance.createdAt?.toIso8601String(),
    };

_SupportRequest _$SupportRequestFromJson(Map<String, dynamic> json) =>
    _SupportRequest(
      id: json['id'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      status:
          $enumDecodeNullable(
            _$SupportStatusEnumMap,
            json['status'],
            unknownValue: SupportStatus.unknown,
          ) ??
          SupportStatus.open,
      bookingId: json['bookingId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SupportRequestToJson(_SupportRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'message': instance.message,
      'status': _$SupportStatusEnumMap[instance.status]!,
      'bookingId': ?instance.bookingId,
      'createdAt': ?instance.createdAt?.toIso8601String(),
    };

const _$SupportStatusEnumMap = {
  SupportStatus.open: 'open',
  SupportStatus.inProgress: 'in_progress',
  SupportStatus.resolved: 'resolved',
  SupportStatus.unknown: 'unknown',
};
