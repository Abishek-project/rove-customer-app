import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/pricing.dart';
import '../../../shared/repositories/booking_repository.dart';

enum CancelStatus { idle, previewing, ready, cancelling, cancelled, failure }

class BookingDetailState extends Equatable {
  const BookingDetailState({
    this.status = LoadStatus.initial,
    this.booking,
    this.failure,
    this.cancelStatus = CancelStatus.idle,
    this.preview,
    this.cancelFailure,
    this.cancelKey,
  });

  final LoadStatus status;
  final Booking? booking;
  final ApiFailure? failure;
  final CancelStatus cancelStatus;
  final CancellationPreview? preview;
  final ApiFailure? cancelFailure;

  /// Idempotency key for the cancel action currently being confirmed.
  final String? cancelKey;

  BookingDetailState copyWith({
    LoadStatus? status,
    Booking? booking,
    ApiFailure? Function()? failure,
    CancelStatus? cancelStatus,
    CancellationPreview? Function()? preview,
    ApiFailure? Function()? cancelFailure,
    String? Function()? cancelKey,
  }) => BookingDetailState(
    status: status ?? this.status,
    booking: booking ?? this.booking,
    failure: failure != null ? failure() : this.failure,
    cancelStatus: cancelStatus ?? this.cancelStatus,
    preview: preview != null ? preview() : this.preview,
    cancelFailure: cancelFailure != null ? cancelFailure() : this.cancelFailure,
    cancelKey: cancelKey != null ? cancelKey() : this.cancelKey,
  );

  @override
  List<Object?> get props => [
    status,
    booking,
    failure,
    cancelStatus,
    preview,
    cancelFailure,
    cancelKey,
  ];
}

/// A booking's details plus the cancellation flow: preview the backend's
/// fee/refund, confirm, then show the booking the backend returns.
class BookingDetailCubit extends Cubit<BookingDetailState> {
  BookingDetailCubit(this._repository, this.bookingId, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid(),
      super(const BookingDetailState());

  final BookingRepository _repository;
  final String bookingId;
  final Uuid _uuid;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, failure: () => null));
    try {
      final booking = await _repository.get(bookingId);
      emit(state.copyWith(status: LoadStatus.success, booking: booking));
    } on ApiFailure catch (f) {
      emit(state.copyWith(status: LoadStatus.failure, failure: () => f));
    }
  }

  void replace(Booking booking) =>
      emit(state.copyWith(status: LoadStatus.success, booking: booking));

  Future<void> previewCancellation() async {
    if (state.cancelStatus == CancelStatus.previewing ||
        state.cancelStatus == CancelStatus.cancelling) {
      return;
    }
    emit(
      state.copyWith(
        cancelStatus: CancelStatus.previewing,
        preview: () => null,
        cancelFailure: () => null,
        cancelKey: () => _uuid.v4(),
      ),
    );
    try {
      final preview = await _repository.cancellationPreview(bookingId);
      emit(
        state.copyWith(
          cancelStatus: CancelStatus.ready,
          preview: () => preview,
        ),
      );
    } on ApiFailure catch (f) {
      emit(
        state.copyWith(
          cancelStatus: CancelStatus.failure,
          cancelFailure: () => f,
        ),
      );
    }
  }

  Future<void> confirmCancellation({String? reason}) async {
    if (state.cancelStatus == CancelStatus.cancelling) return;
    final key = state.cancelKey ?? _uuid.v4();
    emit(
      state.copyWith(
        cancelStatus: CancelStatus.cancelling,
        cancelFailure: () => null,
        cancelKey: () => key,
      ),
    );
    try {
      final booking = await _repository.cancel(
        bookingId,
        reason: reason,
        idempotencyKey: key,
      );
      emit(
        state.copyWith(
          cancelStatus: CancelStatus.cancelled,
          booking: booking,
          cancelKey: () => null,
        ),
      );
    } on ApiFailure catch (f) {
      emit(
        state.copyWith(
          cancelStatus: CancelStatus.failure,
          cancelFailure: () => f,
        ),
      );
    }
  }

  void resetCancellation() => emit(
    state.copyWith(
      cancelStatus: CancelStatus.idle,
      preview: () => null,
      cancelFailure: () => null,
    ),
  );
}
