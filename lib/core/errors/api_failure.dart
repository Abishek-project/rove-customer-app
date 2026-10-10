import 'package:equatable/equatable.dart';

/// Error codes from the shared API contract, plus client-side codes for
/// failures that never reached the server.
abstract final class ErrorCodes {
  static const validationFailed = 'VALIDATION_FAILED';
  static const unauthenticated = 'UNAUTHENTICATED';
  static const forbidden = 'FORBIDDEN';
  static const notFound = 'NOT_FOUND';
  static const conflict = 'CONFLICT';
  static const vehicleUnavailable = 'VEHICLE_UNAVAILABLE';
  static const quoteExpired = 'QUOTE_EXPIRED';
  static const holdExpired = 'HOLD_EXPIRED';
  static const invalidStateTransition = 'INVALID_STATE_TRANSITION';
  static const idempotencyConflict = 'IDEMPOTENCY_CONFLICT';
  static const paymentFailed = 'PAYMENT_FAILED';
  static const fileTooLarge = 'FILE_TOO_LARGE';
  static const unsupportedFileType = 'UNSUPPORTED_FILE_TYPE';
  static const rateLimited = 'RATE_LIMITED';
  static const internalError = 'INTERNAL_ERROR';
  static const serviceUnavailable = 'SERVICE_UNAVAILABLE';

  // Client-side only.
  static const network = 'NETWORK_ERROR';
  static const timeout = 'TIMEOUT';
  static const sessionExpired = 'SESSION_EXPIRED';
  static const unknown = 'UNKNOWN';
}

/// A typed failure mapped from the API error envelope
/// `{ "error": { code, message, details, requestId } }` or from a transport
/// error. Repositories throw this; blocs catch it and expose it in state.
class ApiFailure extends Equatable implements Exception {
  const ApiFailure({
    required this.code,
    this.message,
    this.statusCode,
    this.details = const {},
    this.requestId,
  });

  const ApiFailure.network()
    : code = ErrorCodes.network,
      message = null,
      statusCode = null,
      details = const {},
      requestId = null;

  const ApiFailure.timeout()
    : code = ErrorCodes.timeout,
      message = null,
      statusCode = null,
      details = const {},
      requestId = null;

  const ApiFailure.unknown([this.message])
    : code = ErrorCodes.unknown,
      statusCode = null,
      details = const {},
      requestId = null;

  /// Builds a failure from a decoded error envelope body.
  factory ApiFailure.fromEnvelope(Object? body, {int? statusCode}) {
    if (body is Map && body['error'] is Map) {
      final error = Map<String, dynamic>.from(body['error'] as Map);
      final details = error['details'];
      return ApiFailure(
        code: (error['code'] as String?) ?? _codeForStatus(statusCode),
        message: error['message'] as String?,
        statusCode: statusCode,
        details: details is Map ? Map<String, dynamic>.from(details) : const {},
        requestId: error['requestId'] as String?,
      );
    }
    return ApiFailure(code: _codeForStatus(statusCode), statusCode: statusCode);
  }

  static String _codeForStatus(int? status) => switch (status) {
    400 || 422 => ErrorCodes.validationFailed,
    401 => ErrorCodes.unauthenticated,
    403 => ErrorCodes.forbidden,
    404 => ErrorCodes.notFound,
    409 => ErrorCodes.conflict,
    402 => ErrorCodes.paymentFailed,
    413 => ErrorCodes.fileTooLarge,
    415 => ErrorCodes.unsupportedFileType,
    429 => ErrorCodes.rateLimited,
    503 => ErrorCodes.serviceUnavailable,
    final int s when s >= 500 => ErrorCodes.internalError,
    _ => ErrorCodes.unknown,
  };

  final String code;

  /// User-safe server message (shown for 4xx responses).
  final String? message;
  final int? statusCode;
  final Map<String, dynamic> details;
  final String? requestId;

  /// Field validation errors: `details.fields`.
  Map<String, List<String>> get fieldErrors {
    final fields = details['fields'];
    if (fields is! Map) return const {};
    return fields.map(
      (key, value) => MapEntry(
        key.toString(),
        value is List
            ? value.map((e) => e.toString()).toList()
            : [value.toString()],
      ),
    );
  }

  /// `details.reason` (e.g. `verification_required`, `profile_incomplete`).
  String? get reason => details['reason'] as String?;

  bool get isNetwork =>
      code == ErrorCodes.network || code == ErrorCodes.timeout;
  bool get isServerError =>
      (statusCode != null && statusCode! >= 500) ||
      code == ErrorCodes.internalError ||
      code == ErrorCodes.serviceUnavailable;
  bool get isClientError =>
      statusCode != null && statusCode! >= 400 && statusCode! < 500;

  /// Whether the server message is safe and useful to show verbatim.
  bool get hasDisplayableMessage =>
      isClientError && message != null && message!.isNotEmpty;

  @override
  List<Object?> get props => [code, message, statusCode, details, requestId];

  @override
  String toString() => 'ApiFailure($code, $statusCode, $message)';
}
