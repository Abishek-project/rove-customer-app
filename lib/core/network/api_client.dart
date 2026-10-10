import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared/models/reference.dart';
import '../auth/session_token_source.dart';
import '../errors/api_failure.dart';
import 'interceptors.dart';

typedef JsonMap = Map<String, dynamic>;

/// Thin typed wrapper over Dio for the Rove `/api/v1` API: unwraps the
/// `{ data, meta }` envelope and converts every error into an [ApiFailure].
class ApiClient {
  ApiClient({
    required String baseUrl,
    required SessionTokenSource tokens,
    Dio? dio,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 20),
  }) : dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: connectTimeout,
               receiveTimeout: receiveTimeout,
               sendTimeout: const Duration(seconds: 60),
               responseType: ResponseType.json,
               headers: {'Accept': 'application/json'},
             ),
           ) {
    this.dio.interceptors.addAll([
      RequestIdInterceptor(),
      AuthInterceptor(tokens: tokens, dio: this.dio),
      GetRetryInterceptor(dio: this.dio),
    ]);
  }

  final Dio dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(Object? data) parse,
  }) async {
    final body = await _send(
      () => dio.get<dynamic>(path, queryParameters: _clean(query)),
    );
    return parse(_data(body));
  }

  Future<Paged<T>> getPage<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(JsonMap item) parseItem,
  }) async {
    final body = await _send(
      () => dio.get<dynamic>(path, queryParameters: _clean(query)),
    );
    final items = (_data(body) as List? ?? const [])
        .map((e) => parseItem(Map<String, dynamic>.from(e as Map)))
        .toList();
    final metaJson = body is Map ? body['meta'] : null;
    final meta = metaJson is Map
        ? PageMeta.fromJson(Map<String, dynamic>.from(metaJson))
        : PageMeta(total: items.length, pageSize: items.length);
    return Paged(items, meta);
  }

  Future<T> post<T>(
    String path, {
    Object? body,
    String? idempotencyKey,
    required T Function(Object? data) parse,
  }) async {
    final response = await _send(
      () => dio.post<dynamic>(
        path,
        data: body,
        options: _idempotent(idempotencyKey),
      ),
    );
    return parse(_data(response));
  }

  Future<T> patch<T>(
    String path, {
    Object? body,
    required T Function(Object? data) parse,
  }) async {
    final response = await _send(() => dio.patch<dynamic>(path, data: body));
    return parse(_data(response));
  }

  Future<void> delete(String path) async {
    await _send(() => dio.delete<dynamic>(path));
  }

  Future<T> upload<T>(
    String path, {
    required FormData form,
    required T Function(Object? data) parse,
  }) async {
    final response = await _send(() => dio.post<dynamic>(path, data: form));
    return parse(_data(response));
  }

  Options? _idempotent(String? key) =>
      key == null ? null : Options(headers: {'Idempotency-Key': key});

  static Map<String, dynamic>? _clean(Map<String, dynamic>? query) {
    if (query == null) return null;
    return Map.fromEntries(
      query.entries.where((e) => e.value != null && e.value != ''),
    );
  }

  static Object? _data(Object? body) =>
      body is Map && body.containsKey('data') ? body['data'] : body;

  Future<Object?> _send(Future<Response<dynamic>> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}

/// Maps a transport or HTTP error to a typed [ApiFailure].
ApiFailure mapDioException(DioException e) {
  final inner = e.error;
  if (inner is ApiFailure) return inner;
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const ApiFailure.timeout();
    case DioExceptionType.connectionError:
      return const ApiFailure.network();
    case DioExceptionType.badResponse:
      final failure = ApiFailure.fromEnvelope(
        e.response?.data,
        statusCode: e.response?.statusCode,
      );
      final retryAfter = e.response?.headers.value('retry-after');
      if (retryAfter != null && failure.code == ErrorCodes.rateLimited) {
        return ApiFailure(
          code: failure.code,
          message: failure.message,
          statusCode: failure.statusCode,
          details: {...failure.details, 'retryAfter': retryAfter},
          requestId: failure.requestId,
        );
      }
      return failure;
    case DioExceptionType.unknown:
      // Only transport errors mean "offline"; anything else (e.g. a file
      // that can't be read) is a generic failure.
      return e.error is SocketException || e.error is HttpException
          ? const ApiFailure.network()
          : ApiFailure.unknown(e.error?.runtimeType.toString());
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
      return const ApiFailure.unknown();
  }
}
