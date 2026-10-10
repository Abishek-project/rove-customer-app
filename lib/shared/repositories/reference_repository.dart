import '../models/reference.dart';

abstract interface class ReferenceRepository {
  /// `GET /countries` — the only source of currency, tax and city config.
  Future<List<Country>> getCountries();

  /// `GET /locations?countryCode=&cityId=`
  Future<List<PickupLocation>> getLocations({
    required String countryCode,
    String? cityId,
  });
}
