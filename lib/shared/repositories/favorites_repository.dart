import '../models/vehicle.dart';

abstract interface class FavoritesRepository {
  Future<List<VehicleSummary>> list();
  Future<void> add(String vehicleId);
  Future<void> remove(String vehicleId);
}
