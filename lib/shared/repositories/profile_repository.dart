import 'package:equatable/equatable.dart';

import '../models/profile.dart';

/// A file chosen by the customer, uploaded once and not kept by the app.
class UploadFile extends Equatable {
  const UploadFile({
    required this.fileName,
    required this.contentType,
    this.path,
    this.bytes,
  }) : assert(path != null || bytes != null);

  final String fileName;
  final String contentType;
  final String? path;
  final List<int>? bytes;

  @override
  List<Object?> get props => [fileName, contentType, path, bytes?.length];
}

abstract interface class ProfileRepository {
  Future<Me> getMe();
  Future<Me> updateMe(ProfileUpdate update);
  Future<DateTime> requestDeletion();
  Future<VerificationState> getVerification();
  Future<CustomerDocument> uploadDocument({
    required String documentType,
    required UploadFile file,
    String? expiresOn,
  });
}
