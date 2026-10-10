import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/time/zoned_time.dart';
import '../../models/booking.dart';
import '../../models/enums.dart';
import '../../models/pricing.dart';
import '../../models/profile.dart';
import '../../models/reference.dart';
import '../../models/vehicle.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/booking_repository.dart';
import '../../repositories/favorites_repository.dart';
import '../../repositories/payment_repository.dart';
import '../../repositories/profile_repository.dart';
import '../../repositories/reference_repository.dart';
import '../../repositories/support_repository.dart';
import '../../repositories/vehicle_repository.dart';
import 'mock_fixtures.dart';
import 'mock_rove_server.dart';

/// Simulated network latency for mock mode (zero in tests).
class MockLatency {
  const MockLatency([this.duration = const Duration(milliseconds: 350)]);
  const MockLatency.none() : duration = Duration.zero;
  final Duration duration;

  Future<void> call() =>
      duration == Duration.zero ? Future.value() : Future.delayed(duration);
}

/// Mock auth: no Supabase. "Continue with Google" signs in a fresh account
/// with an incomplete profile; dev email login accepts the seeded emails.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository({
    required this.server,
    this.latency = const MockLatency(),
    this.prefs,
  });

  static const _sessionKey = 'mock.session.email';

  final MockRoveServer server;
  final MockLatency latency;
  final SharedPreferences? prefs;
  final _changes = StreamController<AuthChange>.broadcast();
  AuthSession? _session;

  /// Test hook: what the next Google sign-in does.
  AuthErrorKind? nextGoogleError;

  String? get userId => _session?.userId;

  @override
  Stream<AuthChange> get changes => _changes.stream;

  @override
  AuthSession? get currentSession => _session;

  @override
  String? get accessToken => _session?.accessToken;

  AuthSession _sessionFor(String email) {
    final known = mockUsers[email];
    final id = known?['id'] as String? ?? 'mock-${email.hashCode.abs()}';
    server.ensureUser(id, email);
    return AuthSession(
      userId: id,
      email: email,
      accessToken: 'mock-token-$id',
      expiresAt: DateTime.now().toUtc().add(const Duration(hours: 1)),
    );
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final email = prefs?.getString(_sessionKey);
    if (email == null) return null;
    _session = _sessionFor(email);
    return _session;
  }

  @override
  Future<void> signInWithGoogle() async {
    await latency();
    final error = nextGoogleError;
    nextGoogleError = null;
    if (error != null) throw AuthException(error);
    // The real flow returns via a deep link; emulate that asynchronously.
    unawaited(
      Future<void>.delayed(latency.duration).then((_) {
        _session = _sessionFor('google.user@rove.test');
        unawaited(prefs?.setString(_sessionKey, 'google.user@rove.test'));
        _changes.add(AuthSignedIn(_session!));
      }),
    );
  }

  @override
  Future<AuthSession> signInWithEmail(String email, String password) async {
    await latency();
    final normalized = email.trim().toLowerCase();
    if (password.isEmpty || normalized.isEmpty) {
      throw const AuthException(AuthErrorKind.invalidCredentials);
    }
    _session = _sessionFor(normalized);
    await prefs?.setString(_sessionKey, normalized);
    _changes.add(AuthSignedIn(_session!));
    return _session!;
  }

  @override
  Future<void> signOut() async {
    _session = null;
    await prefs?.remove(_sessionKey);
    _changes.add(const AuthSignedOut());
  }

  @override
  Future<String?> refreshAccessToken() async => _session?.accessToken;

  @override
  Future<void> handleSessionExpired() async {
    _session = null;
    await prefs?.remove(_sessionKey);
    _changes.add(const AuthSignedOut(expired: true));
  }

  /// Requires a session, like a `[auth]` endpoint.
  String requireUser() {
    final id = _session?.userId;
    if (id == null) {
      throw const ApiFailure(
        code: ErrorCodes.unauthenticated,
        statusCode: 401,
        message: 'Please sign in.',
      );
    }
    return id;
  }
}

/// Runs a server call after the simulated latency and maps nothing else:
/// the server already throws contract-shaped [ApiFailure]s.
mixin _MockCall {
  MockLatency get latency;

  Future<T> respond<T>(T Function() run) async {
    await latency();
    return run();
  }
}

class MockReferenceRepository with _MockCall implements ReferenceRepository {
  MockReferenceRepository(this.server, {this.latency = const MockLatency()});

  final MockRoveServer server;
  @override
  final MockLatency latency;

  @override
  Future<List<Country>> getCountries() =>
      respond(() => server.countries().map(Country.fromJson).toList());

  @override
  Future<List<PickupLocation>> getLocations({
    required String countryCode,
    String? cityId,
  }) => respond(
    () => server
        .locations(countryCode: countryCode, cityId: cityId)
        .map(PickupLocation.fromJson)
        .toList(),
  );
}

class MockVehicleRepository with _MockCall implements VehicleRepository {
  MockVehicleRepository(
    this.server,
    this.auth, {
    this.latency = const MockLatency(),
  });

  final MockRoveServer server;
  final MockAuthRepository auth;
  @override
  final MockLatency latency;

  @override
  Future<Paged<VehicleSummary>> search(VehicleQuery query) => respond(() {
    final body = server.searchVehicles(
      query.toQueryParameters(),
      userId: auth.userId,
    );
    return Paged(
      (body['data'] as List)
          .map((e) => VehicleSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      PageMeta.fromJson(body['meta'] as Map<String, dynamic>),
    );
  });

  @override
  Future<VehicleDetail> getVehicle(
    String vehicleId, {
    DateTime? pickupAt,
    DateTime? returnAt,
  }) => respond(
    () => VehicleDetail.fromJson(
      server.vehicleDetail(
        vehicleId,
        userId: auth.userId,
        pickupAt: pickupAt,
        returnAt: returnAt,
      ),
    ),
  );
}

class MockFavoritesRepository with _MockCall implements FavoritesRepository {
  MockFavoritesRepository(
    this.server,
    this.auth, {
    this.latency = const MockLatency(),
  });

  final MockRoveServer server;
  final MockAuthRepository auth;
  @override
  final MockLatency latency;

  @override
  Future<List<VehicleSummary>> list() => respond(
    () => server
        .favorites(auth.requireUser())
        .map(VehicleSummary.fromJson)
        .toList(),
  );

  @override
  Future<void> add(String vehicleId) =>
      respond(() => server.addFavorite(auth.requireUser(), vehicleId));

  @override
  Future<void> remove(String vehicleId) =>
      respond(() => server.removeFavorite(auth.requireUser(), vehicleId));
}

class MockBookingRepository with _MockCall implements BookingRepository {
  MockBookingRepository(
    this.server,
    this.auth, {
    this.latency = const MockLatency(),
  });

  final MockRoveServer server;
  final MockAuthRepository auth;
  @override
  final MockLatency latency;

  @override
  Future<Quote> quote(QuoteRequest request) => respond(
    () => Quote.fromJson(
      server.quote(auth.requireUser(), {
        'vehicleId': request.vehicleId,
        'pickupAt': ZonedTime.toIso(request.pickupAt),
        'returnAt': ZonedTime.toIso(request.returnAt),
        'delivery': {
          'enabled': request.delivery,
          if (request.deliveryAddress != null)
            'address': request.deliveryAddress,
        },
      }),
    ),
  );

  @override
  Future<BookingCreation> create({
    required String quoteId,
    required DriverDetails driver,
    required String idempotencyKey,
  }) => respond(
    () => BookingCreation.fromJson(
      server.createBooking(auth.requireUser(), {
        'quoteId': quoteId,
        'driver': {
          'fullName': driver.fullName,
          'phone': driver.phone,
          'dateOfBirth': driver.dateOfBirthIso,
        },
        'termsAccepted': true,
      }, idempotencyKey: idempotencyKey),
    ),
  );

  @override
  Future<Paged<BookingSummary>> list(BookingGroup group, {int page = 1}) =>
      respond(() {
        final body = server.listBookings(
          auth.requireUser(),
          group.name,
          page: page,
        );
        return Paged(
          (body['data'] as List)
              .map((e) => BookingSummary.fromJson(e as Map<String, dynamic>))
              .toList(),
          PageMeta.fromJson(body['meta'] as Map<String, dynamic>),
        );
      });

  @override
  Future<Booking> get(String bookingId) => respond(
    () => Booking.fromJson(server.getBooking(auth.requireUser(), bookingId)),
  );

  @override
  Future<CancellationPreview> cancellationPreview(String bookingId) => respond(
    () => CancellationPreview.fromJson(
      server.cancellationPreview(auth.requireUser(), bookingId),
    ),
  );

  @override
  Future<Booking> cancel(
    String bookingId, {
    String? reason,
    required String idempotencyKey,
  }) => respond(
    () => Booking.fromJson(
      server.cancel(auth.requireUser(), bookingId, {
        if (reason != null && reason.isNotEmpty) 'reason': reason,
      }, idempotencyKey: idempotencyKey),
    ),
  );
}

class MockPaymentRepository with _MockCall implements PaymentRepository {
  MockPaymentRepository(
    this.server,
    this.auth, {
    this.latency = const MockLatency(),
  });

  final MockRoveServer server;
  final MockAuthRepository auth;
  @override
  final MockLatency latency;

  @override
  Future<Booking> confirm({
    required String bookingId,
    required String intentId,
    required String idempotencyKey,
    SimulatedOutcome? simulateOutcome,
  }) async {
    await latency();
    try {
      return Booking.fromJson(
        server.confirmPayment(auth.requireUser(), bookingId, {
          'intentId': intentId,
          if (simulateOutcome != null) 'simulateOutcome': simulateOutcome.name,
        }, idempotencyKey: idempotencyKey),
      );
    } on ApiFailure catch (f) {
      if (f.code == ErrorCodes.paymentFailed) {
        final booking = f.details['booking'];
        throw PaymentDeclined(
          f,
          booking is Map<String, dynamic> ? Booking.fromJson(booking) : null,
        );
      }
      rethrow;
    }
  }
}

class MockProfileRepository with _MockCall implements ProfileRepository {
  MockProfileRepository(
    this.server,
    this.auth, {
    this.latency = const MockLatency(),
  });

  final MockRoveServer server;
  final MockAuthRepository auth;
  @override
  final MockLatency latency;

  @override
  Future<Me> getMe() =>
      respond(() => Me.fromJson(server.me(auth.requireUser())));

  @override
  Future<Me> updateMe(ProfileUpdate update) => respond(
    () => Me.fromJson(server.patchMe(auth.requireUser(), update.toJson())),
  );

  @override
  Future<DateTime> requestDeletion() => respond(
    () => DateTime.parse(
      server.requestDeletion(auth.requireUser())['deletionRequestedAt']
          as String,
    ),
  );

  @override
  Future<VerificationState> getVerification() => respond(
    () => VerificationState.fromJson(server.verification(auth.requireUser())),
  );

  @override
  Future<CustomerDocument> uploadDocument({
    required String documentType,
    required UploadFile file,
    String? expiresOn,
  }) => respond(
    () => CustomerDocument.fromJson(
      server.uploadDocument(
        auth.requireUser(),
        documentType: documentType,
        fileName: file.fileName,
        contentType: file.contentType,
        sizeBytes: file.bytes?.length ?? 1024,
        expiresOn: expiresOn,
      ),
    ),
  );
}

class MockSupportRepository with _MockCall implements SupportRepository {
  MockSupportRepository(
    this.server,
    this.auth, {
    this.latency = const MockLatency(),
  });

  final MockRoveServer server;
  final MockAuthRepository auth;
  @override
  final MockLatency latency;

  @override
  Future<SupportRequest> create({
    required String subject,
    required String message,
    String? bookingId,
  }) => respond(
    () => SupportRequest.fromJson(
      server.createSupport(auth.requireUser(), {
        'subject': subject,
        'message': message,
        'bookingId': ?bookingId,
      }),
    ),
  );

  @override
  Future<List<SupportRequest>> list() => respond(
    () => server
        .listSupport(auth.requireUser())
        .map(SupportRequest.fromJson)
        .toList(),
  );
}
