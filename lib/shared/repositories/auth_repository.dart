import 'package:equatable/equatable.dart';

import '../../core/auth/session_token_source.dart';

class AuthSession extends Equatable {
  const AuthSession({
    required this.userId,
    required this.accessToken,
    this.email,
    this.expiresAt,
  });

  final String userId;
  final String? email;
  final String accessToken;
  final DateTime? expiresAt;

  @override
  List<Object?> get props => [userId, email, accessToken, expiresAt];
}

/// Session changes pushed by the auth provider.
sealed class AuthChange {
  const AuthChange();
}

class AuthSignedIn extends AuthChange {
  const AuthSignedIn(this.session);
  final AuthSession session;
}

class AuthSignedOut extends AuthChange {
  const AuthSignedOut({this.expired = false});

  /// True when the session ended because it could not be refreshed.
  final bool expired;
}

/// The OAuth redirect came back with an error (e.g. access denied).
class AuthCallbackFailed extends AuthChange {
  const AuthCallbackFailed(this.message);
  final String? message;
}

enum AuthErrorKind {
  cancelled,
  invalidCredentials,
  network,
  launchFailed,
  unknown,
}

class AuthException implements Exception {
  const AuthException(this.kind, [this.message]);
  final AuthErrorKind kind;
  final String? message;

  @override
  String toString() => 'AuthException($kind, $message)';
}

/// Supabase Auth (Google OAuth; email+password only in local development).
/// Account roles and authorization are never decided here — only the
/// backend does that.
abstract interface class AuthRepository implements SessionTokenSource {
  Stream<AuthChange> get changes;

  AuthSession? get currentSession;

  /// Restores a persisted session (refreshing it if needed). Returns null if
  /// there is none or it can no longer be refreshed.
  Future<AuthSession?> restoreSession();

  /// Opens the Google consent screen. The session arrives later through
  /// [changes] once the deep link `com.rove.customer://login-callback` fires.
  Future<void> signInWithGoogle();

  Future<AuthSession> signInWithEmail(String email, String password);

  Future<void> signOut();
}
