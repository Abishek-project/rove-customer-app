import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/favorites_repository.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = LoadStatus.initial,
    this.vehicles = const [],
    this.ids = const {},
    this.failure,
    this.toggleFailure,
  });

  final LoadStatus status;
  final List<VehicleSummary> vehicles;
  final Set<String> ids;
  final ApiFailure? failure;

  /// Set when an optimistic toggle had to be rolled back.
  final ApiFailure? toggleFailure;

  bool contains(String vehicleId) => ids.contains(vehicleId);

  FavoritesState copyWith({
    LoadStatus? status,
    List<VehicleSummary>? vehicles,
    Set<String>? ids,
    ApiFailure? Function()? failure,
    ApiFailure? Function()? toggleFailure,
  }) => FavoritesState(
    status: status ?? this.status,
    vehicles: vehicles ?? this.vehicles,
    ids: ids ?? this.ids,
    failure: failure != null ? failure() : this.failure,
    toggleFailure: toggleFailure != null ? toggleFailure() : this.toggleFailure,
  );

  @override
  List<Object?> get props => [status, vehicles, ids, failure, toggleFailure];
}

sealed class FavoritesEvent {
  const FavoritesEvent();
}

class FavoritesLoaded extends FavoritesEvent {
  const FavoritesLoaded();
}

class FavoriteToggled extends FavoritesEvent {
  const FavoriteToggled(this.vehicle);
  final VehicleSummary vehicle;
}

class FavoritesCleared extends FavoritesEvent {
  const FavoritesCleared();
}

/// Saved vehicles. Toggles are optimistic and rolled back on failure.
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._repository) : super(const FavoritesState()) {
    on<FavoritesLoaded>(_onLoad, transformer: restartable());
    on<FavoriteToggled>(_onToggle, transformer: sequential());
    on<FavoritesCleared>((_, emit) => emit(const FavoritesState()));
  }

  final FavoritesRepository _repository;

  Future<void> _onLoad(
    FavoritesLoaded event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading, failure: () => null));
    try {
      final list = await _repository.list();
      emit(
        FavoritesState(
          status: list.isEmpty ? LoadStatus.empty : LoadStatus.success,
          vehicles: list,
          ids: list.map((v) => v.id).toSet(),
        ),
      );
    } on ApiFailure catch (f) {
      emit(state.copyWith(status: LoadStatus.failure, failure: () => f));
    }
  }

  Future<void> _onToggle(
    FavoriteToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    final vehicle = event.vehicle;
    final wasSaved = state.contains(vehicle.id);
    final before = state;
    final vehicles = wasSaved
        ? state.vehicles.where((v) => v.id != vehicle.id).toList()
        : [vehicle.copyWith(isFavorite: true), ...state.vehicles];
    emit(
      state.copyWith(
        vehicles: vehicles,
        ids: vehicles.map((v) => v.id).toSet(),
        status: vehicles.isEmpty ? LoadStatus.empty : LoadStatus.success,
        toggleFailure: () => null,
      ),
    );
    try {
      if (wasSaved) {
        await _repository.remove(vehicle.id);
      } else {
        await _repository.add(vehicle.id);
      }
    } on ApiFailure catch (f) {
      emit(before.copyWith(toggleFailure: () => f));
    }
  }
}
