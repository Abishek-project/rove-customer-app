import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/auth/session_token_source.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/core/localization/l10n.dart';
import 'package:rove_customer_app/core/network/api_client.dart';
import 'package:rove_customer_app/l10n/gen/app_localizations_en.dart';

/// Replays queued responses and records requests.
class FakeAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  final responses = <Object>[]; // ResponseBody or DioExceptionType

  void reply(int status, Object? body, {Map<String, List<String>>? headers}) {
    responses.add(
      ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
          ...?headers,
        },
      ),
    );
  }

  void fail(DioExceptionType type) => responses.add(type);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final next = responses.removeAt(0);
    if (next is DioExceptionType) {
      throw DioException(requestOptions: options, type: next);
    }
    return next as ResponseBody;
  }

  @override
  void close({bool force = false}) {}
}

class FakeTokens implements SessionTokenSource {
  FakeTokens({this.token = 'old', this.refreshed});
  @override
  String? accessToken;
  String token;
  final String? refreshed;
  int refreshCalls = 0;
  int expiredCalls = 0;

  @override
  Future<String?> refreshAccessToken() async {
    refreshCalls++;
    if (refreshed != null) accessToken = refreshed;
    return refreshed;
  }

  @override
  Future<void> handleSessionExpired() async => expiredCalls++;
}

void main() {
  late FakeAdapter adapter;
  late FakeTokens tokens;
  late ApiClient api;

  ApiClient build(FakeTokens t) {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/api/v1'));
    dio.httpClientAdapter = adapter;
    return ApiClient(baseUrl: 'http://api.test/api/v1', tokens: t, dio: dio);
  }

  setUp(() {
    adapter = FakeAdapter();
    tokens = FakeTokens(refreshed: 'new')..accessToken = 'old';
    api = build(tokens);
  });

  test('unwraps the data envelope and sends the bearer token', () async {
    adapter.reply(200, {
      'data': {'ok': true},
    });
    final data = await api.get('/me', parse: (d) => d! as Map);
    expect(data['ok'], isTrue);
    expect(adapter.requests.single.headers['Authorization'], 'Bearer old');
    expect(adapter.requests.single.headers['x-request-id'], startsWith('app_'));
  });

  test('parses pagination meta', () async {
    adapter.reply(200, {
      'data': [
        {'id': 1},
        {'id': 2},
      ],
      'meta': {'page': 1, 'pageSize': 2, 'total': 5, 'totalPages': 3},
    });
    final page = await api.getPage('/vehicles', parseItem: (j) => j['id']);
    expect(page.items, [1, 2]);
    expect(page.meta.hasMore, isTrue);
  });

  test('maps the error envelope to a typed failure', () async {
    adapter.reply(409, {
      'error': {
        'code': 'VEHICLE_UNAVAILABLE',
        'message':
            'This vehicle is no longer available for the selected dates.',
        'details': {},
        'requestId': 'req_1',
      },
    });
    await expectLater(
      api.post('/bookings', body: {}, parse: (d) => d),
      throwsA(
        isA<ApiFailure>()
            .having((f) => f.code, 'code', ErrorCodes.vehicleUnavailable)
            .having((f) => f.statusCode, 'status', 409)
            .having((f) => f.requestId, 'requestId', 'req_1'),
      ),
    );
  });

  test('exposes validation field errors and reasons', () async {
    adapter.reply(422, {
      'error': {
        'code': 'VALIDATION_FAILED',
        'message': 'Upload your documents first.',
        'details': {
          'reason': 'verification_required',
          'fields': {
            'driver.dateOfBirth': ['too young'],
          },
        },
      },
    });
    try {
      await api.post('/bookings', body: {}, parse: (d) => d);
      fail('should throw');
    } on ApiFailure catch (f) {
      expect(f.reason, 'verification_required');
      expect(f.fieldErrors['driver.dateOfBirth'], ['too young']);
    }
  });

  test('refreshes once on 401 and retries with the new token', () async {
    adapter.reply(401, {
      'error': {'code': 'UNAUTHENTICATED', 'message': 'x'},
    });
    adapter.reply(200, {'data': 'ok'});
    final result = await api.get('/me', parse: (d) => d);
    expect(result, 'ok');
    expect(tokens.refreshCalls, 1);
    expect(adapter.requests.last.headers['Authorization'], 'Bearer new');
  });

  test('a second 401 after refresh ends the session', () async {
    adapter.reply(401, {
      'error': {'code': 'UNAUTHENTICATED', 'message': 'x'},
    });
    adapter.reply(401, {
      'error': {'code': 'UNAUTHENTICATED', 'message': 'x'},
    });
    await expectLater(
      api.get('/me', parse: (d) => d),
      throwsA(
        isA<ApiFailure>().having(
          (f) => f.code,
          'code',
          ErrorCodes.unauthenticated,
        ),
      ),
    );
    expect(tokens.refreshCalls, 1);
    expect(tokens.expiredCalls, 1);
  });

  test('failed refresh signs out without retrying', () async {
    tokens = FakeTokens()..accessToken = 'old';
    api = build(tokens);
    adapter.reply(401, {
      'error': {'code': 'UNAUTHENTICATED', 'message': 'x'},
    });
    await expectLater(
      api.get('/me', parse: (d) => d),
      throwsA(isA<ApiFailure>()),
    );
    expect(adapter.requests, hasLength(1));
    expect(tokens.expiredCalls, 1);
  });

  test('retries GETs on 503 but never POSTs', () async {
    adapter.reply(503, {
      'error': {'code': 'SERVICE_UNAVAILABLE', 'message': 'x'},
    });
    adapter.reply(200, {'data': 'ok'});
    expect(await api.get('/countries', parse: (d) => d), 'ok');
    expect(adapter.requests, hasLength(2));

    adapter.requests.clear();
    adapter.reply(503, {
      'error': {'code': 'SERVICE_UNAVAILABLE', 'message': 'x'},
    });
    await expectLater(
      api.post('/bookings', body: {}, idempotencyKey: 'k1', parse: (d) => d),
      throwsA(
        isA<ApiFailure>().having((f) => f.isServerError, 'server', isTrue),
      ),
    );
    expect(adapter.requests, hasLength(1));
    expect(adapter.requests.single.headers['Idempotency-Key'], 'k1');
  });

  test('network and timeout errors become client failures', () async {
    adapter.fail(DioExceptionType.connectionError);
    adapter.fail(DioExceptionType.connectionError);
    adapter.fail(DioExceptionType.connectionError);
    await expectLater(
      api.get('/countries', parse: (d) => d),
      throwsA(
        isA<ApiFailure>().having((f) => f.code, 'code', ErrorCodes.network),
      ),
    );
    adapter.fail(DioExceptionType.receiveTimeout);
    await expectLater(
      api.post('/bookings/quote', body: {}, parse: (d) => d),
      throwsA(
        isA<ApiFailure>().having((f) => f.code, 'code', ErrorCodes.timeout),
      ),
    );
  });

  test('rate limits carry Retry-After', () async {
    adapter.reply(
      429,
      {
        'error': {'code': 'RATE_LIMITED', 'message': 'Slow down'},
      },
      headers: {
        'retry-after': ['30'],
      },
    );
    try {
      await api.post('/favorites', body: {}, parse: (d) => d);
      fail('should throw');
    } on ApiFailure catch (f) {
      expect(f.code, ErrorCodes.rateLimited);
      expect(f.details['retryAfter'], '30');
    }
  });

  group('user-facing messages', () {
    final l10n = AppLocalizationsEn();

    test('4xx shows the server message', () {
      const f = ApiFailure(
        code: 'QUOTE_EXPIRED',
        statusCode: 409,
        message: 'Expired.',
      );
      expect(l10n.failure(f), 'Expired.');
    });

    test('5xx and network never leak details', () {
      const f = ApiFailure(
        code: 'INTERNAL_ERROR',
        statusCode: 500,
        message: 'stack…',
      );
      expect(l10n.failure(f), l10n.errorServer);
      expect(l10n.failure(const ApiFailure.network()), l10n.errorNetwork);
      expect(l10n.failure(const ApiFailure.timeout()), l10n.errorTimeout);
    });

    test('codes without a message get a localized fallback', () {
      expect(
        l10n.failure(
          const ApiFailure(code: 'VEHICLE_UNAVAILABLE', statusCode: 409),
        ),
        l10n.errorVehicleUnavailable,
      );
      expect(
        l10n.failure(ApiFailure.fromEnvelope(null, statusCode: 404)),
        l10n.errorNotFound,
      );
    });
  });
}
