import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/reference.dart';
import '../../../shared/repositories/booking_repository.dart';

class BookingListState extends Equatable {
  const BookingListState({
    required this.group,
    this.status = LoadStatus.initial,
    this.bookings = const [],
    this.meta = const PageMeta(),
    this.failure,
    this.loadingMore = false,
  });

  final BookingGroup group;
  final LoadStatus status;
  final List<BookingSummary> bookings;
  final PageMeta meta;
  final ApiFailure? failure;
  final bool loadingMore;

  @override
  List<Object?> get props => [
    group,
    status,
    bookings,
    meta,
    failure,
    loadingMore,
  ];
}

/// One tab of My Bookings (`GET /bookings?group=`), paginated.
class BookingListCubit extends Cubit<BookingListState> {
  BookingListCubit(this._repository, BookingGroup group)
    : super(BookingListState(group: group));

  final BookingRepository _repository;

  Future<void> load() async {
    emit(
      BookingListState(
        group: state.group,
        status: LoadStatus.loading,
        bookings: state.bookings,
      ),
    );
    try {
      final page = await _repository.list(state.group);
      emit(
        BookingListState(
          group: state.group,
          status: page.items.isEmpty ? LoadStatus.empty : LoadStatus.success,
          bookings: page.items,
          meta: page.meta,
        ),
      );
    } on ApiFailure catch (f) {
      emit(
        BookingListState(
          group: state.group,
          status: LoadStatus.failure,
          bookings: state.bookings,
          failure: f,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.loadingMore || !state.meta.hasMore) return;
    emit(
      BookingListState(
        group: state.group,
        status: state.status,
        bookings: state.bookings,
        meta: state.meta,
        loadingMore: true,
      ),
    );
    try {
      final page = await _repository.list(
        state.group,
        page: state.meta.page + 1,
      );
      emit(
        BookingListState(
          group: state.group,
          status: LoadStatus.success,
          bookings: [...state.bookings, ...page.items],
          meta: page.meta,
        ),
      );
    } on ApiFailure {
      emit(
        BookingListState(
          group: state.group,
          status: state.status,
          bookings: state.bookings,
          meta: state.meta,
        ),
      );
    }
  }
}
