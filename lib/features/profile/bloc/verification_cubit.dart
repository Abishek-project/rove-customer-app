import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/profile_repository.dart';

class VerificationCubitState extends Equatable {
  const VerificationCubitState({
    this.status = LoadStatus.initial,
    this.verification,
    this.failure,
    this.uploadingType,
    this.uploadFailure,
    this.uploadFailureType,
  });

  final LoadStatus status;
  final VerificationState? verification;
  final ApiFailure? failure;

  /// Document type currently uploading.
  final String? uploadingType;
  final ApiFailure? uploadFailure;
  final String? uploadFailureType;

  bool get allowsBooking => verification?.allowsBooking ?? false;

  @override
  List<Object?> get props => [
    status,
    verification,
    failure,
    uploadingType,
    uploadFailure,
    uploadFailureType,
  ];
}

/// Licence/ID verification status and uploads via `/me/documents`.
/// Picked files are sent once and deleted from the device afterwards.
class VerificationCubit extends Cubit<VerificationCubitState> {
  VerificationCubit(this._repository) : super(const VerificationCubitState());

  final ProfileRepository _repository;

  Future<void> load() async {
    emit(
      VerificationCubitState(
        status: LoadStatus.loading,
        verification: state.verification,
      ),
    );
    try {
      final v = await _repository.getVerification();
      emit(VerificationCubitState(status: LoadStatus.success, verification: v));
    } on ApiFailure catch (f) {
      emit(
        VerificationCubitState(
          status: LoadStatus.failure,
          verification: state.verification,
          failure: f,
        ),
      );
    }
  }

  Future<void> upload(
    String documentType,
    UploadFile file, {
    bool deleteAfter = false,
  }) async {
    if (state.uploadingType != null) return;
    emit(
      VerificationCubitState(
        status: state.status,
        verification: state.verification,
        uploadingType: documentType,
      ),
    );
    try {
      await _repository.uploadDocument(documentType: documentType, file: file);
      final v = await _repository.getVerification();
      emit(VerificationCubitState(status: LoadStatus.success, verification: v));
    } on ApiFailure catch (f) {
      emit(
        VerificationCubitState(
          status: state.status,
          verification: state.verification,
          uploadFailure: f,
          uploadFailureType: documentType,
        ),
      );
    } finally {
      if (deleteAfter && file.path != null) {
        try {
          await File(file.path!).delete();
        } on FileSystemException {
          // Temporary copy already gone.
        }
      }
    }
  }
}
