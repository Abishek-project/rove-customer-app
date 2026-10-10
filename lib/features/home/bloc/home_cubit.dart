import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = LoadStatus.initial,
    this.featured = const [],
    this.failure,
    this.countryCode,
    this.cityId,
    this.category,
  });

  final LoadStatus status;

  /// Featured cars, or the cars of [category] when one is selected.
  final List<VehicleSummary> featured;
  final ApiFailure? failure;
  final String? countryCode;
  final String? cityId;

  /// Selected category tile; null shows featured cars.
  final VehicleCategory? category;

  @override
  List<Object?> get props => [
    status,
    featured,
    failure,
    countryCode,
    cityId,
    category,
  ];
}

/// The home list for the selected country and city: featured cars, or the
/// cars of the selected category tile.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._vehicles) : super(const HomeState());

  final VehicleRepository _vehicles;

  Future<void> load({
    required String countryCode,
    String? cityId,
    bool force = false,
  }) => _load(
    countryCode: countryCode,
    cityId: cityId,
    category: state.category,
    force: force,
  );

  /// Selects a category tile, or clears it when it is already selected.
  Future<void> toggleCategory(VehicleCategory category) {
    final code = state.countryCode;
    if (code == null) return Future.value();
    return _load(
      countryCode: code,
      cityId: state.cityId,
      category: state.category == category ? null : category,
      force: true,
    );
  }

  Future<void> _load({
    required String countryCode,
    String? cityId,
    VehicleCategory? category,
    bool force = false,
  }) async {
    if (!force &&
        state.countryCode == countryCode &&
        state.cityId == cityId &&
        (state.status == LoadStatus.success ||
            state.status == LoadStatus.empty ||
            state.status == LoadStatus.loading)) {
      return;
    }
    emit(
      HomeState(
        status: LoadStatus.loading,
        countryCode: countryCode,
        cityId: cityId,
        category: category,
      ),
    );
    try {
      final page = await _vehicles.search(
        VehicleQuery(
          countryCode: countryCode,
          cityId: cityId,
          featured: category == null ? true : null,
          category: category,
          pageSize: 8,
        ),
      );
      if (_stale(countryCode, cityId, category)) return;
      emit(
        HomeState(
          status: page.items.isEmpty ? LoadStatus.empty : LoadStatus.success,
          featured: page.items,
          countryCode: countryCode,
          cityId: cityId,
          category: category,
        ),
      );
    } on ApiFailure catch (f) {
      if (_stale(countryCode, cityId, category)) return;
      emit(
        HomeState(
          status: LoadStatus.failure,
          failure: f,
          countryCode: countryCode,
          cityId: cityId,
          category: category,
        ),
      );
    }
  }

  bool _stale(String countryCode, String? cityId, VehicleCategory? category) =>
      state.countryCode != countryCode ||
      state.cityId != cityId ||
      state.category != category;
}
