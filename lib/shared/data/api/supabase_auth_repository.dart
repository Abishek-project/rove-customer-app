import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../repositories/auth_repository.dart';

/// Supabase Auth with Google OAuth (PKCE) and, for local development only,
/// email + password. The app only ever holds the public anon key.
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client, {required this.redirectUrl}) {
    _subscription = _client.auth.onAuthStateChange.listen(
      _onAuthState,
      onError: (Object error) {
        // A failed OAuth callback (e.g. access_denied, bad code exchange).
        _changes.add(
          AuthCallbackFailed(error is sb.AuthException ? error.message : null),
        );
      },
    );
  }

  final sb.SupabaseClient _client;
  final String redirectUrl;
  final _changes = StreamController<AuthChange>.broadcast();
  late final StreamSubscription<sb.AuthState> _subscription;
  bool _expiring = false;

  @override
  Stream<AuthChange> get changes => _changes.stream;

  @override
  AuthSession? get currentSession => _map(_client.auth.currentSession);

  @override
  String? get accessToken => _client.auth.currentSession?.accessToken;

  void _onAuthState(sb.AuthState state) {
    switch (state.event) {
      case sb.AuthChangeEvent.signedIn:
        final session = _map(state.session);
        if (session != null) _changes.add(AuthSignedIn(session));
      case sb.AuthChangeEvent.signedOut:
        if (!_expiring) _changes.add(const AuthSignedOut());
      default:
        break;
    }
  }

  AuthSession? _map(sb.Session? session) {
    if (session == null) return null;
    return AuthSession(
      userId: session.user.id,
      email: session.user.email,
      accessToken: session.accessToken,
      expiresAt: session.expiresAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              session.expiresAt! * 1000,
              isUtc: true,
            ),
    );
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final session = _client.auth.currentSession;
    if (session == null) return null;
    if (!session.isExpired) return _map(session);
    try {
      final refreshed = await _client.auth.refreshSession();
      return _map(refreshed.session);
    } on sb.AuthException {
      await _signOutLocally();
      return null;
    } on SocketException {
      // Offline: keep the stored session; requests will retry the refresh.
      return _map(session);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final launched = await _client.auth.signInWithOAuth(
        sb.OAuthProvider.google,
        redirectTo: redirectUrl,
        authScreenLaunchMode: sb.LaunchMode.externalApplication,
      );
      if (!launched) throw const AuthException(AuthErrorKind.launchFailed);
    } on SocketException {
      throw const AuthException(AuthErrorKind.network);
    } on sb.AuthException catch (e) {
      throw AuthException(AuthErrorKind.unknown, e.message);
    }
  }

  @override
  Future<AuthSession> signInWithEmail(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      final session = _map(response.session);
      if (session == null) {
        throw const AuthException(AuthErrorKind.invalidCredentials);
      }
      return session;
    } on SocketException {
      throw const AuthException(AuthErrorKind.network);
    } on sb.AuthRetryableFetchException {
      throw const AuthException(AuthErrorKind.network);
    } on sb.AuthApiException catch (e) {
      final status = int.tryParse(e.statusCode ?? '');
      throw AuthException(
        status == 400 || status == 401
            ? AuthErrorKind.invalidCredentials
            : AuthErrorKind.unknown,
        e.message,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on Exception {
      await _signOutLocally();
      _changes.add(const AuthSignedOut());
    }
  }

  @override
  Future<String?> refreshAccessToken() async {
    try {
      final response = await _client.auth.refreshSession();
      return response.session?.accessToken;
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> handleSessionExpired() async {
    if (_expiring) return;
    _expiring = true;
    try {
      await _signOutLocally();
      _changes.add(const AuthSignedOut(expired: true));
    } finally {
      _expiring = false;
    }
  }

  Future<void> _signOutLocally() async {
    try {
      await _client.auth.signOut(scope: sb.SignOutScope.local);
    } on Exception {
      // Already signed out locally.
    }
  }

  Future<void> dispose() async {
    await _subscription.cancel();
    await _changes.close();
  }
}

/// Persists the Supabase session in the platform keychain/keystore instead
/// of plain shared preferences.
class SecureSessionStorage extends sb.LocalStorage {
  SecureSessionStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'rove.supabase.session';
  final FlutterSecureStorage _storage;
  String? _memory;

  @override
  Future<void> initialize() async {
    try {
      _memory = await _storage.read(key: _key);
    } on Exception {
      _memory = null;
    }
  }

  @override
  Future<bool> hasAccessToken() async => _memory != null;

  @override
  Future<String?> accessToken() async => _memory;

  @override
  Future<void> persistSession(String persistSessionString) async {
    _memory = persistSessionString;
    try {
      await _storage.write(key: _key, value: persistSessionString);
    } on Exception {
      // Keychain unavailable: the session lives for this app run only.
    }
  }

  @override
  Future<void> removePersistedSession() async {
    _memory = null;
    try {
      await _storage.delete(key: _key);
    } on Exception {
      // Nothing persisted.
    }
  }
}
