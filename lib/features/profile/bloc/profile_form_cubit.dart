import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/profile_repository.dart';

enum SubmitStatus { idle, submitting, success, failure }

class ProfileFormState extends Equatable {
  const ProfileFormState({
    this.status = SubmitStatus.idle,
    this.me,
    this.failure,
  });

  final SubmitStatus status;
  final Me? me;
  final ApiFailure? failure;

  /// Server-side field errors (`details.fields`).
  Map<String, List<String>> get fieldErrors => failure?.fieldErrors ?? const {};

  @override
  List<Object?> get props => [status, me, failure];
}

/// Saves profile changes through `PATCH /me` (completion, edit, settings).
class ProfileFormCubit extends Cubit<ProfileFormState> {
  ProfileFormCubit(this._repository) : super(const ProfileFormState());

  final ProfileRepository _repository;

  Future<Me?> submit(ProfileUpdate update) async {
    if (state.status == SubmitStatus.submitting) return null;
    emit(const ProfileFormState(status: SubmitStatus.submitting));
    try {
      final me = await _repository.updateMe(update);
      emit(ProfileFormState(status: SubmitStatus.success, me: me));
      return me;
    } on ApiFailure catch (f) {
      emit(ProfileFormState(status: SubmitStatus.failure, failure: f));
      return null;
    }
  }
}
