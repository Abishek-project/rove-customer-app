import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/reference.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query,
    this.status = LoadStatus.initial,
    this.vehicles = const [],
    this.meta = const PageMeta(),
    this.failure,
    this.loadingMore = false,
    this.loadMoreFailure,
  });

  final VehicleQuery? query;
  final LoadStatus status;
  final List<VehicleSummary> vehicles;
  final PageMeta meta;
  final ApiFailure? failure;
  final bool loadingMore;
  final ApiFailure? loadMoreFailure;

  bool get hasMore => meta.hasMore;

  SearchState copyWith({
    VehicleQuery? query,
    LoadStatus? status,
    List<VehicleSummary>? vehicles,
    PageMeta? meta,
    ApiFailure? Function()? failure,
    bool? loadingMore,
    ApiFailure? Function()? loadMoreFailure,
  }) => SearchState(
    query: query ?? this.query,
    status: status ?? this.status,
    vehicles: vehicles ?? this.vehicles,
    meta: meta ?? this.meta,
    failure: failure != null ? failure() : this.failure,
    loadingMore: loadingMore ?? this.loadingMore,
    loadMoreFailure: loadMoreFailure != null
        ? loadMoreFailure()
        : this.loadMoreFailure,
  );

  @override
  List<Object?> get props => [
    query,
    status,
    vehicles,
    meta,
    failure,
    loadingMore,
    loadMoreFailure,
  ];
}

sealed class SearchEvent {
  const SearchEvent();
}

/// Run a new search (first page). Replaces any search in flight.
class SearchRequested extends SearchEvent {
  const SearchRequested(this.query);
  final VehicleQuery query;
}

class SearchSortChanged extends SearchEvent {
  const SearchSortChanged(this.sort);
  final VehicleSort sort;
}

class SearchFiltersCleared extends SearchEvent {
  const SearchFiltersCleared();
}

class SearchNextPageRequested extends SearchEvent {
  const SearchNextPageRequested();
}

class SearchRetried extends SearchEvent {
  const SearchRetried();
}

/// Vehicle search against `GET /vehicles`. The backend decides availability;
/// this bloc never filters results on the client.
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._repository) : super(const SearchState()) {
    on<SearchRequested>(
      (e, emit) => _search(e.query.copyWith(page: 1), emit),
      transformer: restartable(),
    );
    on<SearchSortChanged>((e, emit) {
      final q = state.query;
      if (q == null) return Future.value();
      return _search(q.copyWith(sort: e.sort, page: 1), emit);
    }, transformer: restartable());
    on<SearchFiltersCleared>((e, emit) {
      final q = state.query;
      if (q == null) return Future.value();
      return _search(q.clearFilters(), emit);
    }, transformer: restartable());
    on<SearchRetried>((e, emit) {
      final q = state.query;
      if (q == null) return Future.value();
      return _search(q.copyWith(page: 1), emit);
    }, transformer: restartable());
    on<SearchNextPageRequested>(_nextPage, transformer: droppable());
  }

  final VehicleRepository _repository;

  Future<void> _search(VehicleQuery query, Emitter<SearchState> emit) async {
    emit(SearchState(query: query, status: LoadStatus.loading));
    try {
      final page = await _repository.search(query);
      emit(
        state.copyWith(
          status: page.items.isEmpty ? LoadStatus.empty : LoadStatus.success,
          vehicles: page.items,
          meta: page.meta,
          failure: () => null,
        ),
      );
    } on ApiFailure catch (f) {
      emit(state.copyWith(status: LoadStatus.failure, failure: () => f));
    }
  }

  Future<void> _nextPage(
    SearchNextPageRequested event,
    Emitter<SearchState> emit,
  ) async {
    final query = state.query;
    if (query == null ||
        state.status != LoadStatus.success ||
        !state.hasMore ||
        state.loadingMore) {
      return;
    }
    emit(state.copyWith(loadingMore: true, loadMoreFailure: () => null));
    try {
      final next = query.copyWith(page: state.meta.page + 1);
      final page = await _repository.search(next);
      // Ignore results for a query that was replaced meanwhile.
      if (state.query != query) return;
      final seen = state.vehicles.map((v) => v.id).toSet();
      emit(
        state.copyWith(
          vehicles: [
            ...state.vehicles,
            ...page.items.where((v) => !seen.contains(v.id)),
          ],
          meta: page.meta,
          loadingMore: false,
        ),
      );
    } on ApiFailure catch (f) {
      emit(state.copyWith(loadingMore: false, loadMoreFailure: () => f));
    }
  }
}
