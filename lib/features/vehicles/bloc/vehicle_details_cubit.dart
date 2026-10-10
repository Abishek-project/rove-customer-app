import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';

class VehicleDetailsState extends Equatable {
  const VehicleDetailsState({
    this.status = LoadStatus.initial,
    this.vehicle,
    this.failure,
    this.pickupAt,
    this.returnAt,
  });

  final LoadStatus status;
  final VehicleDetail? vehicle;
  final ApiFailure? failure;
  final DateTime? pickupAt;
  final DateTime? returnAt;

  bool get hasDates => pickupAt != null && returnAt != null;

  /// Bookable only when the backend checked these dates and said yes.
  bool get isBookable =>
      vehicle != null &&
      hasDates &&
      vehicle!.availability.checked &&
      vehicle!.availability.available == true;

  bool get isUnavailable =>
      vehicle != null &&
      vehicle!.availability.checked &&
      vehicle!.availability.available == false;

  @override
  List<Object?> get props => [status, vehicle, failure, pickupAt, returnAt];
}

class VehicleDetailsCubit extends Cubit<VehicleDetailsState> {
  VehicleDetailsCubit(this._repository, this.vehicleId, {this.onLoaded})
    : super(const VehicleDetailsState());

  final VehicleRepository _repository;
  final String vehicleId;
  final void Function(VehicleDetail)? onLoaded;

  /// Loads the vehicle; with valid dates the backend checks availability
  /// and returns an estimated total.
  Future<void> load({DateTime? pickupAt, DateTime? returnAt}) async {
    final keepVehicle = state.vehicle;
    emit(
      VehicleDetailsState(
        status: LoadStatus.loading,
        vehicle: keepVehicle,
        pickupAt: pickupAt,
        returnAt: returnAt,
      ),
    );
    try {
      final vehicle = await _repository.getVehicle(
        vehicleId,
        pickupAt: pickupAt,
        returnAt: returnAt,
      );
      emit(
        VehicleDetailsState(
          status: LoadStatus.success,
          vehicle: vehicle,
          pickupAt: pickupAt,
          returnAt: returnAt,
        ),
      );
      onLoaded?.call(vehicle);
    } on ApiFailure catch (f) {
      emit(
        VehicleDetailsState(
          status: LoadStatus.failure,
          vehicle: keepVehicle,
          failure: f,
          pickupAt: pickupAt,
          returnAt: returnAt,
        ),
      );
    }
  }
}
