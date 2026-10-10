import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../auth/session_token_source.dart';

const _retriedAfterRefresh = 'rove.retriedAfterRefresh';
const _getRetryCount = 'rove.getRetryCount';

/// Adds a request id to every call so client and server logs correlate.
class RequestIdInterceptor extends Interceptor {
  RequestIdInterceptor({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent('x-request-id', () => 'app_${_uuid.v4()}');
    handler.next(options);
  }
}

/// Attaches the bearer token and, on a 401, refreshes the session once and
/// retries the request once. A second 401 ends the session. Concurrent 401s
/// share one refresh.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokens, required this.dio});

  final SessionTokenSource tokens;

  /// The Dio instance used to replay the request after a refresh.
  final Dio dio;

  Future<String?>? _refreshing;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = tokens.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  Future<String?> _refreshOnce() {
    return _refreshing ??= tokens.refreshAccessToken().whenComplete(() {
      _refreshing = null;
    });
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    if (err.response?.statusCode != 401) return handler.next(err);
    if (options.extra[_retriedAfterRefresh] == true) {
      await tokens.handleSessionExpired();
      return handler.next(err);
    }
    final hadToken = options.headers['Authorization'] != null;
    final newToken = hadToken ? await _refreshOnce() : null;
    if (newToken == null) {
      if (hadToken) await tokens.handleSessionExpired();
      return handler.next(err);
    }
    try {
      final retryOptions = options.copyWith(
        headers: {...options.headers, 'Authorization': 'Bearer $newToken'},
        extra: {...options.extra, _retriedAfterRefresh: true},
      );
      handler.resolve(await dio.fetch<dynamic>(retryOptions));
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}

/// Retries idempotent GETs on transport errors and 502/503/504, at most
/// [maxRetries] times with linear backoff. Writes are never auto-retried.
class GetRetryInterceptor extends Interceptor {
  GetRetryInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 400),
  });

  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;

  bool _isRetryable(DioException err) {
    if (err.requestOptions.method.toUpperCase() != 'GET') return false;
    switch (err.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return true;
      case DioExceptionType.badResponse:
        final status = err.response?.statusCode ?? 0;
        return status == 502 || status == 503 || status == 504;
      default:
        return false;
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final attempt = (err.requestOptions.extra[_getRetryCount] as int?) ?? 0;
    if (!_isRetryable(err) || attempt >= maxRetries) {
      return handler.next(err);
    }
    await Future<void>.delayed(baseDelay * (attempt + 1));
    try {
      final options = err.requestOptions.copyWith(
        extra: {...err.requestOptions.extra, _getRetryCount: attempt + 1},
      );
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}
