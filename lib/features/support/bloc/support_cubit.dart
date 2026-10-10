import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/support_repository.dart';

class SupportState extends Equatable {
  const SupportState({
    this.status = LoadStatus.initial,
    this.requests = const [],
    this.failure,
    this.sending = false,
    this.sendFailure,
    this.sent,
  });

  final LoadStatus status;
  final List<SupportRequest> requests;
  final ApiFailure? failure;
  final bool sending;
  final ApiFailure? sendFailure;
  final SupportRequest? sent;

  @override
  List<Object?> get props => [
    status,
    requests,
    failure,
    sending,
    sendFailure,
    sent,
  ];
}

class SupportCubit extends Cubit<SupportState> {
  SupportCubit(this._repository) : super(const SupportState());

  final SupportRepository _repository;

  Future<void> load() async {
    emit(SupportState(status: LoadStatus.loading, requests: state.requests));
    try {
      final list = await _repository.list();
      emit(
        SupportState(
          status: list.isEmpty ? LoadStatus.empty : LoadStatus.success,
          requests: list,
        ),
      );
    } on ApiFailure catch (f) {
      emit(
        SupportState(
          status: LoadStatus.failure,
          requests: state.requests,
          failure: f,
        ),
      );
    }
  }

  Future<bool> send({
    required String subject,
    required String message,
    String? bookingId,
  }) async {
    if (state.sending) return false;
    emit(
      SupportState(
        status: state.status,
        requests: state.requests,
        sending: true,
      ),
    );
    try {
      final request = await _repository.create(
        subject: subject,
        message: message,
        bookingId: bookingId,
      );
      emit(
        SupportState(
          status: LoadStatus.success,
          requests: [request, ...state.requests],
          sent: request,
        ),
      );
      return true;
    } on ApiFailure catch (f) {
      emit(
        SupportState(
          status: state.status,
          requests: state.requests,
          sendFailure: f,
        ),
      );
      return false;
    }
  }
}
