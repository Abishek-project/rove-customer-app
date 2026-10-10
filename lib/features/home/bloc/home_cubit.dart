import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = LoadStatus.initial,
    this.featured = const [],
    this.failure,
    this.countryCode,
    this.cityId,
  });

  final LoadStatus status;
  final List<VehicleSummary> featured;
  final ApiFailure? failure;
  final String? countryCode;
  final String? cityId;

  @override
  List<Object?> get props => [status, featured, failure, countryCode, cityId];
}

/// Featured vehicles for the selected country and city.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._vehicles) : super(const HomeState());

  final VehicleRepository _vehicles;

  Future<void> load({
    required String countryCode,
    String? cityId,
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
      ),
    );
    try {
      final page = await _vehicles.search(
        VehicleQuery(
          countryCode: countryCode,
          cityId: cityId,
          featured: true,
          pageSize: 8,
        ),
      );
      if (state.countryCode != countryCode || state.cityId != cityId) return;
      emit(
        HomeState(
          status: page.items.isEmpty ? LoadStatus.empty : LoadStatus.success,
          featured: page.items,
          countryCode: countryCode,
          cityId: cityId,
        ),
      );
    } on ApiFailure catch (f) {
      if (state.countryCode != countryCode || state.cityId != cityId) return;
      emit(
        HomeState(
          status: LoadStatus.failure,
          failure: f,
          countryCode: countryCode,
          cityId: cityId,
        ),
      );
    }
  }
}
