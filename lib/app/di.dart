import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../core/config/app_env.dart';
import '../core/location/location_service.dart';
import '../core/network/api_client.dart';
import '../shared/data/api/api_repositories.dart';
import '../shared/data/api/supabase_auth_repository.dart';
import '../shared/data/mock/mock_repositories.dart';
import '../shared/data/mock/mock_rove_server.dart';
import '../shared/repositories/auth_repository.dart';
import '../shared/repositories/booking_repository.dart';
import '../shared/repositories/favorites_repository.dart';
import '../shared/repositories/payment_repository.dart';
import '../shared/repositories/profile_repository.dart';
import '../shared/repositories/reference_repository.dart';
import '../shared/repositories/support_repository.dart';
import '../shared/repositories/vehicle_repository.dart';

/// Every dependency the UI needs, chosen once at start-up by `API_MODE`.
class AppDependencies {
  const AppDependencies({
    required this.env,
    required this.prefs,
    required this.auth,
    required this.reference,
    required this.vehicles,
    required this.favorites,
    required this.bookings,
    required this.payments,
    required this.profile,
    required this.support,
    required this.location,
  });

  /// Mock mode: an in-memory backend with contract-exact fixtures.
  factory AppDependencies.mock({
    required AppEnv env,
    required SharedPreferences prefs,
    MockRoveServer? server,
    MockLatency latency = const MockLatency(),
    LocationService? location,
  }) {
    final backend = server ?? MockRoveServer();
    final auth = MockAuthRepository(
      server: backend,
      latency: latency,
      prefs: prefs,
    );
    return AppDependencies(
      env: env,
      prefs: prefs,
      auth: auth,
      reference: MockReferenceRepository(backend, latency: latency),
      vehicles: MockVehicleRepository(backend, auth, latency: latency),
      favorites: MockFavoritesRepository(backend, auth, latency: latency),
      bookings: MockBookingRepository(backend, auth, latency: latency),
      payments: MockPaymentRepository(backend, auth, latency: latency),
      profile: MockProfileRepository(backend, auth, latency: latency),
      support: MockSupportRepository(backend, auth, latency: latency),
      location: location ?? const DeviceLocationService(),
    );
  }

  /// Live mode: Supabase for auth only, the NestJS API for everything else.
  /// `Supabase.initialize` must have run first.
  factory AppDependencies.live({
    required AppEnv env,
    required SharedPreferences prefs,
  }) {
    final auth = SupabaseAuthRepository(
      sb.Supabase.instance.client,
      redirectUrl: env.oauthRedirectUrl,
    );
    final api = ApiClient(baseUrl: env.apiV1Url, tokens: auth);
    return AppDependencies(
      env: env,
      prefs: prefs,
      auth: auth,
      reference: ApiReferenceRepository(api),
      vehicles: ApiVehicleRepository(api),
      favorites: ApiFavoritesRepository(api),
      bookings: ApiBookingRepository(api),
      payments: ApiPaymentRepository(api),
      profile: ApiProfileRepository(api),
      support: ApiSupportRepository(api),
      location: const DeviceLocationService(),
    );
  }

  final AppEnv env;
  final SharedPreferences prefs;
  final AuthRepository auth;
  final ReferenceRepository reference;
  final VehicleRepository vehicles;
  final FavoritesRepository favorites;
  final BookingRepository bookings;
  final PaymentRepository payments;
  final ProfileRepository profile;
  final SupportRepository support;
  final LocationService location;
}
