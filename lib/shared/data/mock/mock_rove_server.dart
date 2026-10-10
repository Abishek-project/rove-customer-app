import 'dart:math';

import '../../../core/errors/api_failure.dart';
import 'mock_fixtures.dart';

typedef Json = Map<String, dynamic>;

/// An in-memory stand-in for the Rove backend used in mock mode and tests.
///
/// It returns the exact JSON shapes from CONTRACTS.md and throws
/// [ApiFailure]s with contract error codes, so the app exercises the same
/// parsing and error handling as in live mode. Business rules (pricing,
/// availability, state machine, cancellation fees) follow CONTRACTS §6–§7.
class MockRoveServer {
  MockRoveServer({DateTime Function()? clock, Random? random, bool seed = true})
    : _clock = clock ?? (() => DateTime.now().toUtc()),
      _random = random ?? Random(7) {
    for (final entry in mockUsers.entries) {
      _profiles[entry.value['id']
          as String] = Map<String, dynamic>.from(entry.value['profile'] as Map)
        ..['notificationPrefs'] = Map<String, dynamic>.from(
          (entry.value['profile'] as Map)['notificationPrefs'] as Map,
        );
      _emails[entry.value['id'] as String] = entry.key;
    }
    _favorites[MockIds.userAe] = {'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad03'};
    if (seed) _seedBookings();
  }

  final DateTime Function() _clock;
  final Random _random;

  final Map<String, Json> _profiles = {};
  final Map<String, String> _emails = {};
  final Map<String, Set<String>> _favorites = {};
  final Map<String, List<Json>> _documents = {};
  final Map<String, Json> _quotes = {};
  final Map<String, Json> _bookings = {};
  final Map<String, Json> _intents = {};
  final Map<String, List<Json>> _support = {};
  final Map<String, Json> _idempotency = {};

  /// When true, the next payment confirmation fails regardless of input.
  bool failNextPayment = false;

  /// Request-mode bookings are accepted by the (simulated) partner after this.
  Duration partnerAutoAcceptAfter = const Duration(seconds: 20);

  DateTime get now => _clock();

  // ---------------------------------------------------------------- reference

  List<Json> countries() => mockCountries.map(Json.from).toList();

  List<Json> locations({required String countryCode, String? cityId}) {
    final cityIds = _citiesOf(countryCode).map((c) => c['id']).toSet();
    return mockLocations
        .where((l) => cityIds.contains(l['cityId']))
        .where((l) => cityId == null || l['cityId'] == cityId)
        .map(
          (l) => {
            'id': l['id'],
            'name': l['name'],
            'address': l['address'],
            'cityId': l['cityId'],
            'latitude': l['latitude'],
            'longitude': l['longitude'],
          },
        )
        .toList();
  }

  // ---------------------------------------------------------------- vehicles

  /// `GET /vehicles` → `{ data, meta }`.
  Json searchVehicles(Map<String, dynamic> q, {String? userId}) {
    final countryCode = q['countryCode'] as String?;
    if (countryCode == null || countryCode.isEmpty) {
      throw _validation({
        'countryCode': ['is required'],
      });
    }
    final pickupAt = _parseDate(q['pickupAt']);
    final returnAt = _parseDate(q['returnAt']);
    if ((pickupAt == null) != (returnAt == null)) {
      throw _validation({
        'returnAt': ['pickupAt and returnAt go together'],
      });
    }
    if (pickupAt != null) _validatePeriod(pickupAt, returnAt!);
    final cityIds = _citiesOf(countryCode).map((c) => c['id']).toSet();
    var list = mockVehicles.where((v) => cityIds.contains(v['cityId'])).where((
      v,
    ) {
      if (q['cityId'] != null && v['cityId'] != q['cityId']) return false;
      if (q['category'] != null && v['category'] != q['category']) return false;
      if (q['transmission'] != null && v['transmission'] != q['transmission']) {
        return false;
      }
      if (q['fuelType'] != null && v['fuelType'] != q['fuelType']) return false;
      final minSeats = _int(q['minSeats']);
      if (minSeats != null && (v['seats'] as int) < minSeats) return false;
      final maxRate = _int(q['maxDailyRateMinor']);
      if (maxRate != null && (v['dailyRateMinor'] as int) > maxRate) {
        return false;
      }
      if (_bool(q['deliveryAvailable']) == true &&
          v['deliveryAvailable'] != true) {
        return false;
      }
      if (_bool(q['featured']) == true && v['isFeatured'] != true) return false;
      if (pickupAt != null && !_isAvailable(v, pickupAt, returnAt!)) {
        return false;
      }
      return true;
    }).toList();

    switch (q['sort']) {
      case 'price_asc':
        list.sort(
          (a, b) => (a['dailyRateMinor'] as int).compareTo(
            b['dailyRateMinor'] as int,
          ),
        );
      case 'price_desc':
        list.sort(
          (a, b) => (b['dailyRateMinor'] as int).compareTo(
            a['dailyRateMinor'] as int,
          ),
        );
      case 'category':
        list.sort(
          (a, b) =>
              (a['category'] as String).compareTo(b['category'] as String),
        );
      default:
        list.sort((a, b) {
          final f =
              (b['isFeatured'] == true ? 1 : 0) -
              (a['isFeatured'] == true ? 1 : 0);
          return f != 0
              ? f
              : (a['make'] as String).compareTo(b['make'] as String);
        });
    }

    final page = max(1, _int(q['page']) ?? 1);
    final pageSize = min(100, max(1, _int(q['pageSize']) ?? 20));
    final total = list.length;
    final start = (page - 1) * pageSize;
    list = start >= total
        ? []
        : list.sublist(start, min(total, start + pageSize));
    return {
      'data': list
          .map(
            (v) => _summary(
              v,
              userId: userId,
              pickupAt: pickupAt,
              returnAt: returnAt,
            ),
          )
          .toList(),
      'meta': {
        'page': page,
        'pageSize': pageSize,
        'total': total,
        'totalPages': max(1, (total / pageSize).ceil()),
      },
    };
  }

  Json vehicleDetail(
    String id, {
    String? userId,
    DateTime? pickupAt,
    DateTime? returnAt,
  }) {
    final v = _vehicleOr404(id);
    final city = _cityById(v['cityId'] as String);
    final partner = mockPartners[v['partnerId']]!;
    final currency = _currencyOfCity(v['cityId'] as String);
    final location = mockLocations
        .where((l) => l['id'] == v['pickupLocationId'])
        .firstOrNull;
    final hasDates = pickupAt != null && returnAt != null;
    return {
      ..._summary(
        v,
        userId: userId,
        pickupAt: pickupAt,
        returnAt: returnAt,
        ignoreAvailability: true,
      ),
      'images': [
        for (final (i, url) in (v['imageUrls'] as List<String>).indexed)
          {
            'id': '${v['id']}-img-$i',
            'url': url,
            'isCover': i == 0,
            'sortOrder': i,
          },
      ],
      'doors': v['doors'],
      'color': v['color'],
      'description': v['description'],
      'features': v['features'],
      'timezone': city['timezone'],
      'pickupLocation': location == null
          ? null
          : {
              'id': location['id'],
              'name': location['name'],
              'address': location['address'],
              'cityId': location['cityId'],
              'latitude': location['latitude'],
              'longitude': location['longitude'],
            },
      'deliveryFee': _money(v['deliveryFeeMinor'] as int, currency),
      'mileagePolicy': {
        'limitKmPerDay': v['mileageLimitKmPerDay'],
        'excessFeePerKm': _money(v['excessMileageFeeMinor'] as int, currency),
      },
      'fuelPolicy': v['fuelPolicy'],
      'deposit': _money(v['depositMinor'] as int, currency),
      'cancellationPolicy': _policy(v['cancellationPolicy'] as String),
      'insuranceInfo': v['insuranceInfo'],
      'minRentalDays': v['minRentalDays'],
      'bookingMode': v['bookingMode'],
      'partner': {
        'id': partner['id'],
        'displayName': partner['displayName'],
        'verified': partner['verified'],
        'cityName': partner['cityName'],
        'logoUrl': partner['logoUrl'],
      },
      'availability': {
        'checked': hasDates,
        'available': hasDates ? _isAvailable(v, pickupAt, returnAt) : null,
      },
    };
  }

  Json _summary(
    Json v, {
    String? userId,
    DateTime? pickupAt,
    DateTime? returnAt,
    bool ignoreAvailability = false,
  }) {
    final currency = _currencyOfCity(v['cityId'] as String);
    final city = _cityById(v['cityId'] as String);
    final partner = mockPartners[v['partnerId']]!;
    Json? estimate;
    int? days;
    if (pickupAt != null && returnAt != null) {
      final pricing = _price(v, pickupAt, returnAt, delivery: false);
      estimate = _money(pricing['total']!, currency);
      days = pricing['days'];
    }
    return {
      'id': v['id'],
      'make': v['make'],
      'model': v['model'],
      'year': v['year'],
      'category': v['category'],
      'transmission': v['transmission'],
      'fuelType': v['fuelType'],
      'seats': v['seats'],
      'luggage': v['luggage'],
      'coverImageUrl': (v['imageUrls'] as List<String>).firstOrNull,
      'dailyRate': _money(v['dailyRateMinor'] as int, currency),
      'estimatedTotal': estimate,
      'days': days,
      'city': {'id': city['id'], 'name': city['name']},
      'deliveryAvailable': v['deliveryAvailable'],
      'partner': {
        'id': partner['id'],
        'displayName': partner['displayName'],
        'verified': partner['verified'],
      },
      'isFavorite':
          userId != null && (_favorites[userId]?.contains(v['id']) ?? false),
    };
  }

  // ---------------------------------------------------------------- profile

  Json me(String userId) {
    final profile = _profiles[userId];
    if (profile == null) {
      throw const ApiFailure(code: ErrorCodes.unauthenticated, statusCode: 401);
    }
    final complete =
        _filled(profile['fullName']) &&
        _filled(profile['phone']) &&
        _filled(profile['countryCode']);
    return {
      'user': {'id': userId, 'email': _emails[userId]},
      'profile': Json.from(profile),
      'profileComplete': complete,
      'isAdmin': false,
      'partner': null,
    };
  }

  /// Creates a profile on first use (the backend upserts on first request).
  void ensureUser(String userId, String? email) {
    _emails.putIfAbsent(userId, () => email ?? '');
    _profiles.putIfAbsent(
      userId,
      () => {
        'fullName': null,
        'phone': null,
        'countryCode': null,
        'cityId': null,
        'preferredLanguage': 'en',
        'notificationPrefs': {'email': true, 'push': true, 'marketing': false},
        'verificationStatus': 'not_started',
        'deletionRequestedAt': null,
      },
    );
  }

  Json patchMe(String userId, Json body) {
    final profile = _profiles[userId]!;
    final errors = <String, List<String>>{};
    if (body.containsKey('fullName')) {
      final name = (body['fullName'] as String? ?? '').trim();
      if (name.length < 2) {
        errors['fullName'] = ['must be at least 2 characters'];
      }
    }
    if (body.containsKey('phone')) {
      final phone = (body['phone'] as String? ?? '').replaceAll(
        RegExp(r'[\s\-()]'),
        '',
      );
      if (!RegExp(r'^\+?\d{8,15}$').hasMatch(phone)) {
        errors['phone'] = ['must be a valid phone number'];
      }
    }
    if (body.containsKey('countryCode') &&
        !mockCountries.any((c) => c['code'] == body['countryCode'])) {
      errors['countryCode'] = ['is not supported'];
    }
    if (errors.isNotEmpty) throw _validation(errors);
    for (final key in [
      'fullName',
      'phone',
      'countryCode',
      'cityId',
      'preferredLanguage',
    ]) {
      if (body.containsKey(key)) profile[key] = body[key];
    }
    if (body['notificationPrefs'] is Map) {
      profile['notificationPrefs'] = {
        ...(profile['notificationPrefs'] as Map),
        ...(body['notificationPrefs'] as Map),
      };
    }
    return me(userId);
  }

  Json requestDeletion(String userId) {
    final at = now.toIso8601String();
    _profiles[userId]!['deletionRequestedAt'] = at;
    return {'deletionRequestedAt': at};
  }

  Json verification(String userId) {
    final profile = _profiles[userId]!;
    final country = profile['countryCode'] as String? ?? 'AE';
    final docs = _documents[userId] ?? const [];
    final seededSubmitted =
        profile['verificationStatus'] != 'not_started' && docs.isEmpty;
    return {
      'status': profile['verificationStatus'],
      'requiredDocuments': [
        for (final req in mockDocumentRequirements[country] ?? const <Json>[])
          {
            ...req,
            'status': seededSubmitted
                ? 'submitted'
                : (docs.lastWhere(
                    (d) => d['documentType'] == req['documentType'],
                    orElse: () => {'status': 'missing'},
                  )['status']),
            'rejectionReason': null,
          },
      ],
    };
  }

  Json uploadDocument(
    String userId, {
    required String documentType,
    required String fileName,
    required String contentType,
    required int sizeBytes,
    String? expiresOn,
  }) {
    if (!['application/pdf', 'image/jpeg', 'image/png'].contains(contentType)) {
      throw const ApiFailure(
        code: ErrorCodes.unsupportedFileType,
        statusCode: 415,
        message: 'Upload a PDF, JPEG or PNG file.',
      );
    }
    if (sizeBytes > 15 * 1024 * 1024) {
      throw const ApiFailure(
        code: ErrorCodes.fileTooLarge,
        statusCode: 413,
        message: 'Documents must be 15 MB or smaller.',
      );
    }
    final doc = {
      'id': _uuid(),
      'documentType': documentType,
      'fileName': fileName,
      'status': 'submitted',
      'expiresOn': expiresOn,
      'createdAt': now.toIso8601String(),
    };
    (_documents[userId] ??= []).add(doc);
    final profile = _profiles[userId]!;
    final country = profile['countryCode'] as String? ?? 'AE';
    final required = (mockDocumentRequirements[country] ?? const <Json>[])
        .where((r) => r['isRequired'] == true)
        .map((r) => r['documentType'])
        .toSet();
    final present = _documents[userId]!.map((d) => d['documentType']).toSet();
    if (required.difference(present).isEmpty &&
        profile['verificationStatus'] != 'verified') {
      profile['verificationStatus'] = 'submitted';
    }
    return doc;
  }

  // ---------------------------------------------------------------- favorites

  List<Json> favorites(String userId) => [
    for (final id in _favorites[userId] ?? const <String>{})
      if (mockVehicles.any((v) => v['id'] == id))
        _summary(_vehicleOr404(id), userId: userId),
  ];

  void addFavorite(String userId, String vehicleId) {
    _vehicleOr404(vehicleId);
    (_favorites[userId] ??= {}).add(vehicleId);
  }

  void removeFavorite(String userId, String vehicleId) {
    _favorites[userId]?.remove(vehicleId);
  }

  // ---------------------------------------------------------------- bookings

  Json quote(String userId, Json body) {
    final v = _vehicleOr404(body['vehicleId'] as String);
    final pickupAt = _parseDate(body['pickupAt']);
    final returnAt = _parseDate(body['returnAt']);
    if (pickupAt == null || returnAt == null) {
      throw _validation({
        'pickupAt': ['is required'],
        'returnAt': ['is required'],
      });
    }
    _validatePeriod(pickupAt, returnAt);
    final delivery = (body['delivery'] as Map?)?['enabled'] == true;
    final address = (body['delivery'] as Map?)?['address'] as String?;
    if (delivery && v['deliveryAvailable'] != true) {
      throw _validation({
        'delivery': ['is not available for this vehicle'],
      });
    }
    if (delivery && (address == null || address.trim().length < 5)) {
      throw _validation({
        'delivery.address': ['is required for delivery'],
      });
    }
    _expireStale();
    if (!_isAvailable(v, pickupAt, returnAt)) throw _unavailable();
    final currency = _currencyOfCity(v['cityId'] as String);
    final pricing = _price(v, pickupAt, returnAt, delivery: delivery);
    final quote = {
      'id': _uuid(),
      'vehicleId': v['id'],
      'pickupAt': pickupAt.toIso8601String(),
      'returnAt': returnAt.toIso8601String(),
      'days': pricing['days'],
      'lineItems': _lineItems(v, pricing, currency),
      'total': _money(pricing['total']!, currency),
      'deposit': _money(v['depositMinor'] as int, currency),
      'conditionalCharges': _conditionalCharges(v, currency),
      'cancellationPolicy': _policy(v['cancellationPolicy'] as String),
      'bookingMode': v['bookingMode'],
      'expiresAt': now.add(const Duration(minutes: 15)).toIso8601String(),
    };
    _quotes[quote['id'] as String] = {
      ...quote,
      '_userId': userId,
      '_delivery': delivery,
      '_address': address,
      '_pricing': pricing,
    };
    return quote;
  }

  Json createBooking(
    String userId,
    Json body, {
    required String idempotencyKey,
  }) {
    return _idempotent(userId, 'POST /bookings', idempotencyKey, body, () {
      final quote = _quotes[body['quoteId']];
      if (quote == null || quote['_userId'] != userId) {
        throw const ApiFailure(
          code: ErrorCodes.notFound,
          statusCode: 404,
          message: 'Quote not found.',
        );
      }
      if (DateTime.parse(quote['expiresAt'] as String).isBefore(now)) {
        throw const ApiFailure(
          code: ErrorCodes.quoteExpired,
          statusCode: 409,
          message:
              'Your price quote has expired. Please review the updated price.',
        );
      }
      if (body['termsAccepted'] != true) {
        throw _validation({
          'termsAccepted': ['must be accepted'],
        });
      }
      final meJson = me(userId);
      if (meJson['profileComplete'] != true) {
        throw const ApiFailure(
          code: ErrorCodes.validationFailed,
          statusCode: 422,
          message: 'Complete your profile before booking.',
          details: {'reason': 'profile_incomplete'},
        );
      }
      final status = _profiles[userId]!['verificationStatus'];
      if (status != 'submitted' && status != 'verified') {
        throw const ApiFailure(
          code: ErrorCodes.validationFailed,
          statusCode: 422,
          message: 'Upload your driving licence and ID before booking.',
          details: {'reason': 'verification_required'},
        );
      }
      final driver = Map<String, dynamic>.from(body['driver'] as Map);
      final dob = DateTime.tryParse(driver['dateOfBirth'] as String? ?? '');
      if (dob == null || _age(dob, now) < 21) {
        throw const ApiFailure(
          code: ErrorCodes.validationFailed,
          statusCode: 422,
          message: 'The driver must be at least 21 years old.',
          details: {
            'reason': 'driver_age',
            'fields': {
              'driver.dateOfBirth': ['driver must be at least 21'],
            },
          },
        );
      }
      final v = _vehicleOr404(quote['vehicleId'] as String);
      final pickupAt = DateTime.parse(quote['pickupAt'] as String);
      final returnAt = DateTime.parse(quote['returnAt'] as String);
      _expireStale();
      if (!_isAvailable(v, pickupAt, returnAt)) throw _unavailable();
      final pricing = quote['_pricing'] as Map<String, int>;
      final id = _uuid();
      final booking = <String, dynamic>{
        'id': id,
        'reference': _reference(),
        'customerId': userId,
        'vehicleId': v['id'],
        'status': 'held',
        'paymentStatus': 'unpaid',
        'depositStatus': 'not_held',
        'bookingMode': v['bookingMode'],
        'pickupAt': pickupAt.toIso8601String(),
        'returnAt': returnAt.toIso8601String(),
        'days': pricing['days'],
        'delivery': quote['_delivery'],
        'deliveryAddress': quote['_address'],
        'lineItems': quote['lineItems'],
        'totalMinor': pricing['total'],
        'rentalFeeMinor': pricing['rentalFee'],
        'driver': {'fullName': driver['fullName'], 'phone': driver['phone']},
        'holdExpiresAt': now.add(const Duration(minutes: 15)).toIso8601String(),
        'partnerResponseDueAt': null,
        'cancellationFeeMinor': 0,
        'refundMinor': 0,
        'events': <Json>[],
        'createdAt': now.toIso8601String(),
      };
      _event(booking, 'created', 'held', 'customer');
      _bookings[id] = booking;
      final currency = _currencyOfCity(v['cityId'] as String);
      final intent = {
        'provider': 'mock',
        'intentId': 'pi_mock_${_uuid().substring(0, 12)}',
        'clientSecret': 'mock_secret_${_uuid().substring(0, 8)}',
        'amount': _money(pricing['total']!, currency),
        'status': 'requires_confirmation',
      };
      _intents[intent['intentId'] as String] = {...intent, '_bookingId': id};
      booking['_intent'] = intent;
      return {'booking': _bookingJson(booking, userId), 'payment': intent};
    });
  }

  Json confirmPayment(
    String userId,
    String bookingId,
    Json body, {
    required String idempotencyKey,
  }) {
    return _idempotent(
      userId,
      'POST /bookings/$bookingId/payment/confirm',
      idempotencyKey,
      body,
      () {
        final booking = _ownedBooking(userId, bookingId);
        _expireStale();
        final intent = _intents[body['intentId']];
        if (intent == null || intent['_bookingId'] != bookingId) {
          throw _validation({
            'intentId': ['does not belong to this booking'],
          });
        }
        if (booking['status'] == 'expired') {
          throw const ApiFailure(
            code: ErrorCodes.holdExpired,
            statusCode: 409,
            message:
                'Your booking hold has expired. Please start a new booking.',
          );
        }
        if (booking['status'] != 'held') {
          // Already paid: replay the current state.
          return _bookingJson(booking, userId);
        }
        final fail = failNextPayment || body['simulateOutcome'] == 'fail';
        failNextPayment = false;
        if (fail) {
          booking['paymentStatus'] = 'failed';
          _event(booking, 'payment_failed', 'held', 'system');
          throw ApiFailure(
            code: ErrorCodes.paymentFailed,
            statusCode: 402,
            message: 'Your payment was declined. No money was taken.',
            details: {'booking': _bookingJson(booking, userId)},
          );
        }
        if (booking['bookingMode'] == 'instant') {
          booking['status'] = 'confirmed';
          booking['paymentStatus'] = 'captured';
          _event(booking, 'payment_captured', 'confirmed', 'system');
        } else {
          booking['status'] = 'pending_partner';
          booking['paymentStatus'] = 'authorized';
          final pickup = DateTime.parse(booking['pickupAt'] as String);
          var due = now.add(const Duration(hours: 24));
          final latest = pickup.subtract(const Duration(hours: 2));
          if (latest.isBefore(due)) due = latest;
          booking['partnerResponseDueAt'] = due.toIso8601String();
          booking['_autoAcceptAt'] = now
              .add(partnerAutoAcceptAfter)
              .toIso8601String();
          _event(booking, 'payment_authorized', 'pending_partner', 'system');
        }
        booking.remove('_intent');
        return _bookingJson(booking, userId);
      },
    );
  }

  Json listBookings(
    String userId,
    String group, {
    int page = 1,
    int pageSize = 20,
  }) {
    _expireStale();
    final statuses = switch (group) {
      'upcoming' => {'confirmed'},
      'pending' => {'held', 'pending_partner'},
      'active' => {'active'},
      'completed' => {'completed'},
      'cancelled' => {'cancelled', 'rejected', 'expired'},
      _ => throw _validation({
        'group': ['is invalid'],
      }),
    };
    final list =
        _bookings.values
            .where(
              (b) =>
                  b['customerId'] == userId && statuses.contains(b['status']),
            )
            .toList()
          ..sort(
            (a, b) =>
                (a['pickupAt'] as String).compareTo(b['pickupAt'] as String),
          );
    if (group == 'completed' || group == 'cancelled') {
      list.setAll(0, list.reversed.toList());
    }
    final total = list.length;
    final start = (page - 1) * pageSize;
    final slice = start >= total
        ? <Json>[]
        : list.sublist(start, min(total, start + pageSize));
    return {
      'data': slice.map((b) => _bookingSummaryJson(b)).toList(),
      'meta': {
        'page': page,
        'pageSize': pageSize,
        'total': total,
        'totalPages': max(1, (total / pageSize).ceil()),
      },
    };
  }

  Json getBooking(String userId, String bookingId) {
    _expireStale();
    return _bookingJson(_ownedBooking(userId, bookingId), userId);
  }

  Json cancellationPreview(String userId, String bookingId) {
    _expireStale();
    final b = _ownedBooking(userId, bookingId);
    final currency = (b['lineItems'] as List).isEmpty
        ? 'AED'
        : ((b['lineItems'] as List).first['amount'] as Map)['currency']
              as String;
    if (!{'held', 'pending_partner', 'confirmed'}.contains(b['status'])) {
      return {
        'eligible': false,
        'free': false,
        'fee': _money(0, currency),
        'refund': _money(0, currency),
        'reason': 'This booking can no longer be cancelled.',
      };
    }
    final fee = _cancellationFee(b);
    final total = b['totalMinor'] as int;
    final paid = b['paymentStatus'] == 'captured';
    return {
      'eligible': true,
      'free': fee == 0,
      'fee': _money(fee, currency),
      'refund': _money(paid ? total - fee : 0, currency),
    };
  }

  Json cancel(
    String userId,
    String bookingId,
    Json body, {
    required String idempotencyKey,
  }) {
    return _idempotent(
      userId,
      'POST /bookings/$bookingId/cancel',
      idempotencyKey,
      body,
      () {
        _expireStale();
        final b = _ownedBooking(userId, bookingId);
        if (!{'held', 'pending_partner', 'confirmed'}.contains(b['status'])) {
          throw const ApiFailure(
            code: ErrorCodes.invalidStateTransition,
            statusCode: 409,
            message: 'This booking can no longer be cancelled.',
          );
        }
        final fee = _cancellationFee(b);
        final captured = b['paymentStatus'] == 'captured';
        b['status'] = 'cancelled';
        b['cancellationFeeMinor'] = fee;
        if (captured) {
          b['refundMinor'] = (b['totalMinor'] as int) - fee;
          b['paymentStatus'] = fee == 0 ? 'refunded' : 'partially_refunded';
        } else if (b['paymentStatus'] == 'authorized') {
          b['paymentStatus'] = 'voided';
        }
        b['cancelledBy'] = 'customer';
        b['cancellationReason'] = body['reason'];
        _event(b, 'cancelled', 'cancelled', 'customer');
        return _bookingJson(b, userId);
      },
    );
  }

  // ---------------------------------------------------------------- support

  Json createSupport(String userId, Json body) {
    final subject = (body['subject'] as String? ?? '').trim();
    final message = (body['message'] as String? ?? '').trim();
    final errors = <String, List<String>>{};
    if (subject.length < 3) {
      errors['subject'] = ['must be at least 3 characters'];
    }
    if (message.length < 10) {
      errors['message'] = ['must be at least 10 characters'];
    }
    if (errors.isNotEmpty) throw _validation(errors);
    final request = {
      'id': _uuid(),
      'subject': subject,
      'message': message,
      'status': 'open',
      'bookingId': body['bookingId'],
      'createdAt': now.toIso8601String(),
    };
    (_support[userId] ??= []).insert(0, request);
    return request;
  }

  List<Json> listSupport(String userId) => [...?_support[userId]];

  // ---------------------------------------------------------------- helpers

  /// Moves bookings along time-based transitions (hold expiry, simulated
  /// partner response), like the backend's scheduled job.
  void _expireStale() {
    for (final b in _bookings.values) {
      if (b['status'] == 'held' &&
          DateTime.parse(b['holdExpiresAt'] as String).isBefore(now)) {
        b['status'] = 'expired';
        if (b['paymentStatus'] != 'failed') b['paymentStatus'] = 'voided';
        _event(b, 'hold_expired', 'expired', 'system');
      }
      final autoAccept = b['_autoAcceptAt'] as String?;
      if (b['status'] == 'pending_partner' &&
          autoAccept != null &&
          DateTime.parse(autoAccept).isBefore(now)) {
        b['status'] = 'confirmed';
        b['paymentStatus'] = 'captured';
        _event(b, 'partner_accepted', 'confirmed', 'partner');
      }
    }
  }

  Map<String, int> _price(
    Json v,
    DateTime pickupAt,
    DateTime returnAt, {
    required bool delivery,
  }) {
    final country = _countryOfCity(v['cityId'] as String);
    final hours = returnAt.difference(pickupAt).inMinutes;
    final rawDays = (hours + 24 * 60 - 1) ~/ (24 * 60);
    final days = max(rawDays, v['minRentalDays'] as int);
    final rentalFee = (v['dailyRateMinor'] as int) * days;
    final discount = days >= 7
        ? _roundBps(rentalFee, v['weeklyDiscountBps'] as int)
        : 0;
    final deliveryFee = delivery ? v['deliveryFeeMinor'] as int : 0;
    final subtotal = rentalFee - discount + deliveryFee;
    final platformFee = _roundBps(subtotal, country['platformFeeBps'] as int);
    final tax = _roundBps(subtotal + platformFee, country['taxRateBps'] as int);
    return {
      'days': days,
      'rentalFee': rentalFee,
      'discount': discount,
      'deliveryFee': deliveryFee,
      'platformFee': platformFee,
      'tax': tax,
      'total': subtotal + platformFee + tax,
    };
  }

  /// Round-half-up of `amount × bps / 10000` on integers.
  static int _roundBps(int amount, int bps) => (amount * bps + 5000) ~/ 10000;

  List<Json> _lineItems(Json v, Map<String, int> p, String currency) {
    final country = _countryOfCity(v['cityId'] as String);
    final rate = v['dailyRateMinor'] as int;
    final rateText =
        '$currency ${rate ~/ 100}.${(rate % 100).toString().padLeft(2, '0')}';
    final taxPct = (country['taxRateBps'] as int) / 100;
    return [
      {
        'code': 'rental_fee',
        'label':
            'Rental (${p['days']} ${p['days'] == 1 ? 'day' : 'days'} × $rateText)',
        'amount': _money(p['rentalFee']!, currency),
      },
      if (p['discount']! > 0)
        {
          'code': 'discount',
          'label': 'Weekly discount',
          'amount': _money(-p['discount']!, currency),
        },
      if (p['deliveryFee']! > 0)
        {
          'code': 'delivery_fee',
          'label': 'Delivery',
          'amount': _money(p['deliveryFee']!, currency),
        },
      if (p['platformFee']! > 0)
        {
          'code': 'platform_fee',
          'label': 'Service fee',
          'amount': _money(p['platformFee']!, currency),
        },
      if (p['tax']! > 0)
        {
          'code': 'tax',
          'label':
              '${country['taxLabel']} (${taxPct.toStringAsFixed(taxPct % 1 == 0 ? 0 : 1)}%)',
          'amount': _money(p['tax']!, currency),
        },
    ];
  }

  List<Json> _conditionalCharges(Json v, String currency) => [
    if (v['mileageLimitKmPerDay'] != null &&
        (v['excessMileageFeeMinor'] as int) > 0)
      {
        'code': 'excess_mileage',
        'label': 'Extra km beyond ${v['mileageLimitKmPerDay']} km/day',
        'amount': _money(v['excessMileageFeeMinor'] as int, currency),
        'unit': 'per_km',
      },
  ];

  int _cancellationFee(Json b) {
    if (b['status'] == 'held' || b['status'] == 'pending_partner') return 0;
    final v = _vehicleOr404(b['vehicleId'] as String);
    final pickup = DateTime.parse(b['pickupAt'] as String);
    final lead = pickup.difference(now);
    final rentalFee = b['rentalFeeMinor'] as int;
    switch (v['cancellationPolicy']) {
      case 'flexible':
        return lead >= const Duration(hours: 24)
            ? 0
            : min(v['dailyRateMinor'] as int, rentalFee);
      case 'moderate':
        return lead >= const Duration(hours: 72)
            ? 0
            : _roundBps(rentalFee, 5000);
      case 'strict':
        if (lead >= const Duration(days: 7)) return 0;
        return lead >= const Duration(hours: 48)
            ? _roundBps(rentalFee, 5000)
            : rentalFee;
      default:
        return 0;
    }
  }

  Json _policy(String code) => {
    'code': code,
    'summary': switch (code) {
      'flexible' =>
        'Free cancellation up to 24 hours before pickup. After that, one day\'s rental is charged.',
      'moderate' =>
        'Free cancellation up to 72 hours before pickup. After that, 50% of the rental fee is charged.',
      'strict' =>
        'Free cancellation up to 7 days before pickup. 50% of the rental fee within 7 days, 100% within 48 hours.',
      _ => 'See rental terms.',
    },
  };

  bool _isAvailable(Json v, DateTime pickupAt, DateTime returnAt) {
    final buffer = Duration(hours: v['bufferHours'] as int);
    for (final b in _bookings.values) {
      if (b['vehicleId'] != v['id']) continue;
      if (!{
        'held',
        'pending_partner',
        'confirmed',
        'active',
      }.contains(b['status'])) {
        continue;
      }
      final start = DateTime.parse(b['pickupAt'] as String);
      final end = DateTime.parse(b['returnAt'] as String).add(buffer);
      if (start.isBefore(returnAt.add(buffer)) && pickupAt.isBefore(end)) {
        return false;
      }
    }
    return true;
  }

  void _validatePeriod(DateTime pickupAt, DateTime returnAt) {
    final errors = <String, List<String>>{};
    if (pickupAt.isBefore(now.add(const Duration(hours: 2)))) {
      errors['pickupAt'] = ['must be at least 2 hours from now'];
    } else if (pickupAt.isAfter(now.add(const Duration(days: 180)))) {
      errors['pickupAt'] = ['must be within 180 days'];
    }
    final length = returnAt.difference(pickupAt);
    if (!returnAt.isAfter(pickupAt)) {
      errors['returnAt'] = ['must be after pickupAt'];
    } else if (length < const Duration(hours: 24)) {
      errors['returnAt'] = ['rental must be at least 24 hours'];
    } else if (length > const Duration(days: 30)) {
      errors['returnAt'] = ['rental must be at most 30 days'];
    }
    if (errors.isNotEmpty) throw _validation(errors);
  }

  Json _ownedBooking(String userId, String bookingId) {
    final b = _bookings[bookingId];
    if (b == null || b['customerId'] != userId) {
      throw const ApiFailure(
        code: ErrorCodes.notFound,
        statusCode: 404,
        message: 'Booking not found.',
      );
    }
    return b;
  }

  Json _bookingSummaryJson(Json b) {
    final v = _vehicleOr404(b['vehicleId'] as String);
    final city = _cityById(v['cityId'] as String);
    final partner = mockPartners[v['partnerId']]!;
    final currency = _currencyOfCity(v['cityId'] as String);
    return {
      'id': b['id'],
      'reference': b['reference'],
      'status': b['status'],
      'paymentStatus': b['paymentStatus'],
      'pickupAt': b['pickupAt'],
      'returnAt': b['returnAt'],
      'total': _money(b['totalMinor'] as int, currency),
      'vehicle': {
        'id': v['id'],
        'make': v['make'],
        'model': v['model'],
        'year': v['year'],
        'coverImageUrl': (v['imageUrls'] as List<String>).firstOrNull,
      },
      'partner': {'id': partner['id'], 'displayName': partner['displayName']},
      'city': {'id': city['id'], 'name': city['name']},
      'timezone': city['timezone'],
    };
  }

  Json _bookingJson(Json b, String userId) {
    final v = _vehicleOr404(b['vehicleId'] as String);
    final currency = _currencyOfCity(v['cityId'] as String);
    final status = b['status'] as String;
    final location = mockLocations
        .where((l) => l['id'] == v['pickupLocationId'])
        .firstOrNull;
    final actions = <String>[
      if (status == 'held' && b['_intent'] != null) 'pay',
      if ({'held', 'pending_partner', 'confirmed'}.contains(status)) 'cancel',
      'contact_support',
    ];
    final country = _countryOfCity(v['cityId'] as String);
    return {
      ..._bookingSummaryJson(b),
      'days': b['days'],
      'bookingMode': b['bookingMode'],
      'depositStatus': b['depositStatus'],
      'delivery': {
        'enabled': b['delivery'] == true,
        'address': b['deliveryAddress'],
      },
      'pickupLocation': location == null
          ? null
          : {
              'id': location['id'],
              'name': location['name'],
              'address': location['address'],
              'cityId': location['cityId'],
              'latitude': location['latitude'],
              'longitude': location['longitude'],
            },
      'lineItems': b['lineItems'],
      'deposit': _money(v['depositMinor'] as int, currency),
      'conditionalCharges': _conditionalCharges(v, currency),
      'cancellationPolicy': _policy(v['cancellationPolicy'] as String),
      'cancellationFee': _money(b['cancellationFeeMinor'] as int, currency),
      'refund': _money(b['refundMinor'] as int, currency),
      'holdExpiresAt': b['holdExpiresAt'],
      'partnerResponseDueAt': b['partnerResponseDueAt'],
      'driver': b['driver'],
      'pickupInstructions': mockPickupInstructions,
      'returnInstructions': mockReturnInstructions,
      'requiredDocuments': [
        for (final r
            in mockDocumentRequirements[country['code']] ?? const <Json>[])
          r['label'] as String,
      ],
      'pickupReport': b['pickupReport'],
      'returnReport': b['returnReport'],
      'events': b['events'],
      'allowedActions': actions,
      'createdAt': b['createdAt'],
      if (status == 'held' && b['_intent'] != null) 'payment': b['_intent'],
    };
  }

  void _event(Json b, String type, String toStatus, String actor) {
    (b['events'] as List).add({
      'type': type,
      'toStatus': toStatus,
      'at': now.toIso8601String(),
      'actorRole': actor,
    });
  }

  Json _idempotent(
    String userId,
    String endpoint,
    String key,
    Json body,
    Json Function() run,
  ) {
    final storeKey = '$userId|$key';
    final hash = '$endpoint|${body.toString()}';
    final stored = _idempotency[storeKey];
    if (stored != null) {
      if (stored['hash'] != hash) {
        throw const ApiFailure(
          code: ErrorCodes.idempotencyConflict,
          statusCode: 409,
          message: 'This request was already used with different details.',
        );
      }
      final failure = stored['failure'];
      if (failure is ApiFailure) throw failure;
      return stored['response'] as Json;
    }
    try {
      final response = run();
      _idempotency[storeKey] = {'hash': hash, 'response': response};
      return response;
    } on ApiFailure catch (f) {
      // Only completed outcomes are replayed; validation errors can be retried.
      if (f.code == ErrorCodes.paymentFailed) {
        _idempotency[storeKey] = {'hash': hash, 'failure': f};
      }
      rethrow;
    }
  }

  void _seedBookings() {
    void seed({
      required String userId,
      required String vehicleId,
      required int startOffsetDays,
      required int days,
      required String status,
      required String paymentStatus,
      required String depositStatus,
      bool reports = false,
    }) {
      final v = _vehicleOr404(vehicleId);
      final currency = _currencyOfCity(v['cityId'] as String);
      final base = DateTime.utc(now.year, now.month, now.day, 6);
      final pickupAt = base.add(Duration(days: startOffsetDays));
      final returnAt = pickupAt.add(Duration(days: days));
      final pricing = _price(v, pickupAt, returnAt, delivery: false);
      final id = _uuid();
      final booking = <String, dynamic>{
        'id': id,
        'reference': _reference(),
        'customerId': userId,
        'vehicleId': vehicleId,
        'status': status,
        'paymentStatus': paymentStatus,
        'depositStatus': depositStatus,
        'bookingMode': v['bookingMode'],
        'pickupAt': pickupAt.toIso8601String(),
        'returnAt': returnAt.toIso8601String(),
        'days': pricing['days'],
        'delivery': false,
        'deliveryAddress': null,
        'lineItems': _lineItems(v, pricing, currency),
        'totalMinor': pricing['total'],
        'rentalFeeMinor': pricing['rentalFee'],
        'driver': {
          'fullName': _profiles[userId]!['fullName'],
          'phone': _profiles[userId]!['phone'],
        },
        'holdExpiresAt': null,
        'partnerResponseDueAt': null,
        'cancellationFeeMinor': 0,
        'refundMinor': status == 'cancelled' ? pricing['total'] : 0,
        'events': <Json>[],
        'createdAt': pickupAt
            .subtract(const Duration(days: 10))
            .toIso8601String(),
        if (reports)
          'pickupReport': {
            'recordedAt': pickupAt.toIso8601String(),
            'odometerKm': 18250,
            'fuelLevelPct': 100,
            'damages': [
              {
                'area': 'Rear bumper',
                'severity': 'minor',
                'description': 'Light scratch',
                'isNew': false,
              },
            ],
            'photoCount': 6,
          },
        if (reports && status == 'completed')
          'returnReport': {
            'recordedAt': returnAt.toIso8601String(),
            'odometerKm': 18790,
            'fuelLevelPct': 100,
            'damages': <Json>[],
            'photoCount': 6,
          },
      };
      _event(booking, 'created', 'held', 'customer');
      _event(
        booking,
        'payment_captured',
        status == 'cancelled' ? 'confirmed' : status,
        'system',
      );
      if (status == 'cancelled') {
        _event(booking, 'cancelled', 'cancelled', 'customer');
      }
      _bookings[id] = booking;
    }

    seed(
      userId: MockIds.userAe,
      vehicleId: 'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad01',
      startOffsetDays: 12,
      days: 3,
      status: 'confirmed',
      paymentStatus: 'captured',
      depositStatus: 'not_held',
    );
    seed(
      userId: MockIds.userAe,
      vehicleId: 'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad05',
      startOffsetDays: -1,
      days: 4,
      status: 'active',
      paymentStatus: 'captured',
      depositStatus: 'held',
      reports: true,
    );
    seed(
      userId: MockIds.userAe,
      vehicleId: 'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad02',
      startOffsetDays: -30,
      days: 5,
      status: 'completed',
      paymentStatus: 'captured',
      depositStatus: 'released',
      reports: true,
    );
    seed(
      userId: MockIds.userAe,
      vehicleId: 'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad06',
      startOffsetDays: -14,
      days: 2,
      status: 'cancelled',
      paymentStatus: 'refunded',
      depositStatus: 'not_held',
    );
    seed(
      userId: MockIds.userIn,
      vehicleId: 'd2e7c7b4-6d1b-40b7-b064-7d8c9bab0e01',
      startOffsetDays: -40,
      days: 3,
      status: 'completed',
      paymentStatus: 'captured',
      depositStatus: 'released',
      reports: true,
    );
  }

  Json _vehicleOr404(String id) {
    final v = mockVehicles.where((v) => v['id'] == id).firstOrNull;
    if (v == null) {
      throw const ApiFailure(
        code: ErrorCodes.notFound,
        statusCode: 404,
        message: 'Vehicle not found.',
      );
    }
    return v;
  }

  List<Json> _citiesOf(String countryCode) {
    final country = mockCountries
        .where((c) => c['code'] == countryCode)
        .firstOrNull;
    return country == null
        ? const []
        : (country['cities'] as List).cast<Json>();
  }

  Json _cityById(String id) {
    for (final c in mockCountries) {
      for (final city in (c['cities'] as List).cast<Json>()) {
        if (city['id'] == id) return city;
      }
    }
    throw const ApiFailure(code: ErrorCodes.notFound, statusCode: 404);
  }

  Json _countryOfCity(String cityId) => mockCountries.firstWhere(
    (c) => (c['cities'] as List).any((city) => (city as Map)['id'] == cityId),
  );

  String _currencyOfCity(String cityId) =>
      _countryOfCity(cityId)['currency'] as String;

  static Json _money(int amountMinor, String currency) => {
    'amountMinor': amountMinor,
    'currency': currency,
  };

  static ApiFailure _validation(Map<String, List<String>> fields) => ApiFailure(
    code: ErrorCodes.validationFailed,
    statusCode: 422,
    message: 'Some details need your attention.',
    details: {'fields': fields},
  );

  static ApiFailure _unavailable() => const ApiFailure(
    code: ErrorCodes.vehicleUnavailable,
    statusCode: 409,
    message: 'This vehicle is no longer available for the selected dates.',
  );

  static DateTime? _parseDate(Object? value) => value is String
      ? DateTime.tryParse(value)?.toUtc()
      : (value is DateTime ? value.toUtc() : null);

  static int? _int(Object? value) =>
      value is int ? value : int.tryParse('${value ?? ''}');

  static bool? _bool(Object? value) =>
      value is bool ? value : (value == 'true' ? true : null);

  static bool _filled(Object? value) =>
      value is String && value.trim().isNotEmpty;

  static int _age(DateTime dob, DateTime today) {
    var age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  String _reference() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return 'RV-${List.generate(6, (_) => chars[_random.nextInt(chars.length)]).join()}';
  }

  String _uuid() {
    String hex(int n) =>
        List.generate(n, (_) => _random.nextInt(16).toRadixString(16)).join();
    return '${hex(8)}-${hex(4)}-4${hex(3)}-a${hex(3)}-${hex(12)}';
  }
}
