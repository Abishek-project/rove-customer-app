import 'package:dio/dio.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/network/api_client.dart';
import '../../../core/time/zoned_time.dart';
import '../../models/booking.dart';
import '../../models/enums.dart';
import '../../models/pricing.dart';
import '../../models/profile.dart';
import '../../models/reference.dart';
import '../../models/vehicle.dart';
import '../../repositories/booking_repository.dart';
import '../../repositories/favorites_repository.dart';
import '../../repositories/payment_repository.dart';
import '../../repositories/profile_repository.dart';
import '../../repositories/reference_repository.dart';
import '../../repositories/support_repository.dart';
import '../../repositories/vehicle_repository.dart';

JsonMap _map(Object? data) => Map<String, dynamic>.from(data! as Map);

List<T> _list<T>(Object? data, T Function(JsonMap) parse) =>
    (data as List? ?? const []).map((e) => parse(_map(e))).toList();

class ApiReferenceRepository implements ReferenceRepository {
  ApiReferenceRepository(this._api);
  final ApiClient _api;

  @override
  Future<List<Country>> getCountries() =>
      _api.get('/countries', parse: (d) => _list(d, Country.fromJson));

  @override
  Future<List<PickupLocation>> getLocations({
    required String countryCode,
    String? cityId,
  }) => _api.get(
    '/locations',
    query: {'countryCode': countryCode, 'cityId': cityId},
    parse: (d) => _list(d, PickupLocation.fromJson),
  );
}

class ApiVehicleRepository implements VehicleRepository {
  ApiVehicleRepository(this._api);
  final ApiClient _api;

  @override
  Future<Paged<VehicleSummary>> search(VehicleQuery query) => _api.getPage(
    '/vehicles',
    query: query.toQueryParameters(),
    parseItem: VehicleSummary.fromJson,
  );

  @override
  Future<VehicleDetail> getVehicle(
    String vehicleId, {
    DateTime? pickupAt,
    DateTime? returnAt,
  }) => _api.get(
    '/vehicles/$vehicleId',
    query: {
      if (pickupAt != null && returnAt != null) ...{
        'pickupAt': ZonedTime.toIso(pickupAt),
        'returnAt': ZonedTime.toIso(returnAt),
      },
    },
    parse: (d) => VehicleDetail.fromJson(_map(d)),
  );
}

class ApiFavoritesRepository implements FavoritesRepository {
  ApiFavoritesRepository(this._api);
  final ApiClient _api;

  @override
  Future<List<VehicleSummary>> list() =>
      _api.get('/favorites', parse: (d) => _list(d, VehicleSummary.fromJson));

  @override
  Future<void> add(String vehicleId) =>
      _api.post('/favorites', body: {'vehicleId': vehicleId}, parse: (_) {});

  @override
  Future<void> remove(String vehicleId) => _api.delete('/favorites/$vehicleId');
}

class ApiBookingRepository implements BookingRepository {
  ApiBookingRepository(this._api);
  final ApiClient _api;

  @override
  Future<Quote> quote(QuoteRequest request) => _api.post(
    '/bookings/quote',
    body: {
      'vehicleId': request.vehicleId,
      'pickupAt': ZonedTime.toIso(request.pickupAt),
      'returnAt': ZonedTime.toIso(request.returnAt),
      'delivery': {
        'enabled': request.delivery,
        if (request.delivery && request.deliveryAddress != null)
          'address': request.deliveryAddress,
      },
    },
    parse: (d) => Quote.fromJson(_map(d)),
  );

  @override
  Future<BookingCreation> create({
    required String quoteId,
    required DriverDetails driver,
    required String idempotencyKey,
  }) => _api.post(
    '/bookings',
    idempotencyKey: idempotencyKey,
    body: {
      'quoteId': quoteId,
      'driver': {
        'fullName': driver.fullName,
        'phone': driver.phone,
        'dateOfBirth': driver.dateOfBirthIso,
      },
      'termsAccepted': true,
    },
    parse: (d) => BookingCreation.fromJson(_map(d)),
  );

  @override
  Future<Paged<BookingSummary>> list(BookingGroup group, {int page = 1}) =>
      _api.getPage(
        '/bookings',
        query: {'group': group.name, 'page': page, 'pageSize': 20},
        parseItem: BookingSummary.fromJson,
      );

  @override
  Future<Booking> get(String bookingId) =>
      _api.get('/bookings/$bookingId', parse: (d) => Booking.fromJson(_map(d)));

  @override
  Future<CancellationPreview> cancellationPreview(String bookingId) => _api.get(
    '/bookings/$bookingId/cancellation-preview',
    parse: (d) => CancellationPreview.fromJson(_map(d)),
  );

  @override
  Future<Booking> cancel(
    String bookingId, {
    String? reason,
    required String idempotencyKey,
  }) => _api.post(
    '/bookings/$bookingId/cancel',
    idempotencyKey: idempotencyKey,
    body: {if (reason != null && reason.isNotEmpty) 'reason': reason},
    parse: (d) => Booking.fromJson(_map(d)),
  );
}

class ApiPaymentRepository implements PaymentRepository {
  ApiPaymentRepository(this._api);
  final ApiClient _api;

  @override
  Future<Booking> confirm({
    required String bookingId,
    required String intentId,
    required String idempotencyKey,
    SimulatedOutcome? simulateOutcome,
  }) async {
    try {
      return await _api.post(
        '/bookings/$bookingId/payment/confirm',
        idempotencyKey: idempotencyKey,
        body: {
          'intentId': intentId,
          if (simulateOutcome != null) 'simulateOutcome': simulateOutcome.name,
        },
        parse: (d) => Booking.fromJson(_map(d)),
      );
    } on ApiFailure catch (f) {
      if (f.code == ErrorCodes.paymentFailed) {
        final booking = f.details['booking'];
        throw PaymentDeclined(
          f,
          booking is Map ? Booking.fromJson(_map(booking)) : null,
        );
      }
      rethrow;
    }
  }
}

class ApiProfileRepository implements ProfileRepository {
  ApiProfileRepository(this._api);
  final ApiClient _api;

  @override
  Future<Me> getMe() => _api.get('/me', parse: (d) => Me.fromJson(_map(d)));

  @override
  Future<Me> updateMe(ProfileUpdate update) => _api.patch(
    '/me',
    body: update.toJson(),
    parse: (d) => Me.fromJson(_map(d)),
  );

  @override
  Future<DateTime> requestDeletion() => _api.post(
    '/me/deletion-request',
    parse: (d) => DateTime.parse(_map(d)['deletionRequestedAt'] as String),
  );

  @override
  Future<VerificationState> getVerification() => _api.get(
    '/me/verification',
    parse: (d) => VerificationState.fromJson(_map(d)),
  );

  @override
  Future<CustomerDocument> uploadDocument({
    required String documentType,
    required UploadFile file,
    String? expiresOn,
  }) async {
    final contentType = DioMediaType.parse(file.contentType);
    final multipart = file.path != null
        ? await MultipartFile.fromFile(
            file.path!,
            filename: file.fileName,
            contentType: contentType,
          )
        : MultipartFile.fromBytes(
            file.bytes!,
            filename: file.fileName,
            contentType: contentType,
          );
    return _api.upload(
      '/me/documents',
      form: FormData.fromMap({
        'file': multipart,
        'documentType': documentType,
        'expiresOn': ?expiresOn,
      }),
      parse: (d) => CustomerDocument.fromJson(_map(d)),
    );
  }
}

class ApiSupportRepository implements SupportRepository {
  ApiSupportRepository(this._api);
  final ApiClient _api;

  @override
  Future<SupportRequest> create({
    required String subject,
    required String message,
    String? bookingId,
  }) => _api.post(
    '/support/requests',
    body: {'subject': subject, 'message': message, 'bookingId': ?bookingId},
    parse: (d) => SupportRequest.fromJson(_map(d)),
  );

  @override
  Future<List<SupportRequest>> list() => _api.get(
    '/support/requests',
    parse: (d) => _list(d, SupportRequest.fromJson),
  );
}
