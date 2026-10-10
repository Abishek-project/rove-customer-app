import 'dart:math';

import 'package:geolocator/geolocator.dart';

import '../../shared/models/reference.dart';

sealed class LocationResult {
  const LocationResult();
}

class LocationFound extends LocationResult {
  const LocationFound(this.latitude, this.longitude);
  final double latitude;
  final double longitude;
}

class LocationDenied extends LocationResult {
  const LocationDenied();
}

class LocationUnavailable extends LocationResult {
  const LocationUnavailable();
}

/// Device location, requested only when the customer taps "Use my location"
/// (never at launch).
abstract interface class LocationService {
  Future<LocationResult> currentLocation();
}

class DeviceLocationService implements LocationService {
  const DeviceLocationService();

  @override
  Future<LocationResult> currentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const LocationUnavailable();
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const LocationDenied();
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return LocationFound(position.latitude, position.longitude);
    } on Exception {
      return const LocationUnavailable();
    }
  }
}

/// The city of the pickup location closest to the given point, if any is
/// within [maxKm].
String? nearestCityId(
  double latitude,
  double longitude,
  List<PickupLocation> locations, {
  double maxKm = 150,
}) {
  String? best;
  var bestKm = double.infinity;
  for (final l in locations) {
    if (l.latitude == null || l.longitude == null || l.cityId == null) continue;
    final km = _haversineKm(latitude, longitude, l.latitude!, l.longitude!);
    if (km < bestKm) {
      bestKm = km;
      best = l.cityId;
    }
  }
  return bestKm <= maxKm ? best : null;
}

double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371.0;
  double rad(double d) => d * pi / 180;
  final dLat = rad(lat2 - lat1);
  final dLon = rad(lon2 - lon1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(rad(lat1)) * cos(rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  return 2 * r * asin(sqrt(a));
}
