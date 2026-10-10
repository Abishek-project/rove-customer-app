import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/auth_repository.dart';
import '../../../shared/repositories/profile_repository.dart';

enum AuthStatus {
  /// Restoring the session at launch.
  unknown,
  unauthenticated,

  /// Google consent screen is open; waiting for the deep-link callback.
  awaitingOAuth,

  /// Signed in, but `GET /me` failed (e.g. offline at launch).
  profileLoadFailed,
  profileIncomplete,
  authenticated,
}

/// One-off messages shown on the sign-in screen.
enum AuthNotice {
  cancelled,
  failed,
  callbackFailed,
  invalidCredentials,
  network,
  launchFailed,
  sessionExpired,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.me,
    this.notice,
    this.submitting = false,
    this.failure,
  });

  final AuthStatus status;
  final Me? me;
  final AuthNotice? notice;

  /// A sign-in request is in flight (disables the buttons).
  final bool submitting;

  /// Why `GET /me` failed, for [AuthStatus.profileLoadFailed].
  final ApiFailure? failure;

  bool get isSignedIn =>
      status == AuthStatus.authenticated ||
      status == AuthStatus.profileIncomplete ||
      status == AuthStatus.profileLoadFailed;

  AuthState copyWith({
    AuthStatus? status,
    Me? Function()? me,
    AuthNotice? Function()? notice,
    bool? submitting,
    ApiFailure? Function()? failure,
  }) => AuthState(
    status: status ?? this.status,
    me: me != null ? me() : this.me,
    notice: notice != null ? notice() : this.notice,
    submitting: submitting ?? this.submitting,
    failure: failure != null ? failure() : this.failure,
  );

  @override
  List<Object?> get props => [status, me, notice, submitting, failure];
}

sealed class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthGoogleRequested extends AuthEvent {
  const AuthGoogleRequested();
}

class AuthEmailRequested extends AuthEvent {
  const AuthEmailRequested(this.email, this.password);
  final String email;
  final String password;
}

/// The app returned to the foreground while waiting for the OAuth callback.
/// If no session arrives within [grace], the sign-in was cancelled.
class AuthOAuthResumed extends AuthEvent {
  const AuthOAuthResumed({this.grace = const Duration(seconds: 3)});
  final Duration grace;
}

class AuthOAuthAbandoned extends AuthEvent {
  const AuthOAuthAbandoned();
}

class _AuthChanged extends AuthEvent {
  const _AuthChanged(this.change);
  final AuthChange change;
}

class AuthProfileRefreshRequested extends AuthEvent {
  const AuthProfileRefreshRequested();
}

/// The profile was updated elsewhere (completion, settings).
class AuthProfileUpdated extends AuthEvent {
  const AuthProfileUpdated(this.me);
  final Me me;
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

class AuthNoticeCleared extends AuthEvent {
  const AuthNoticeCleared();
}

/// Owns the authentication lifecycle: session restore, Google OAuth (and
/// dev email login), profile completeness from `GET /me`, sign-out and
/// session expiry. Roles and permissions stay on the backend.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  }) : _auth = authRepository,
       _profiles = profileRepository,
       super(const AuthState()) {
    on<AuthStarted>(_onStarted, transformer: droppable());
    on<AuthGoogleRequested>(_onGoogle, transformer: droppable());
    on<AuthEmailRequested>(_onEmail, transformer: droppable());
    on<AuthOAuthResumed>(_onResumed, transformer: restartable());
    on<AuthOAuthAbandoned>(_onAbandoned);
    on<_AuthChanged>(_onChanged, transformer: sequential());
    on<AuthProfileRefreshRequested>(_onRefresh, transformer: droppable());
    on<AuthProfileUpdated>(_onProfileUpdated);
    on<AuthSignOutRequested>(_onSignOut, transformer: droppable());
    on<AuthNoticeCleared>(
      (_, emit) => emit(state.copyWith(notice: () => null)),
    );
    _subscription = _auth.changes.listen((c) => add(_AuthChanged(c)));
  }

  final AuthRepository _auth;
  final ProfileRepository _profiles;
  late final StreamSubscription<AuthChange> _subscription;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final session = await _auth.restoreSession();
    if (session == null) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
      return;
    }
    await _loadProfile(emit);
  }

  Future<void> _loadProfile(Emitter<AuthState> emit) async {
    try {
      final me = await _profiles.getMe();
      emit(_signedIn(me));
    } on ApiFailure catch (f) {
      if (f.code == ErrorCodes.unauthenticated) {
        // The interceptor already tried a refresh; the session is gone.
        emit(
          const AuthState(
            status: AuthStatus.unauthenticated,
            notice: AuthNotice.sessionExpired,
          ),
        );
        return;
      }
      emit(
        AuthState(
          status: AuthStatus.profileLoadFailed,
          me: state.me,
          failure: f,
        ),
      );
    }
  }

  AuthState _signedIn(Me me) => AuthState(
    status: me.profileComplete
        ? AuthStatus.authenticated
        : AuthStatus.profileIncomplete,
    me: me,
  );

  Future<void> _onGoogle(
    AuthGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(submitting: true, notice: () => null));
    try {
      await _auth.signInWithGoogle();
      // The session comes back via the deep link → [_AuthChanged].
      if (state.status == AuthStatus.unauthenticated) {
        emit(
          state.copyWith(status: AuthStatus.awaitingOAuth, submitting: false),
        );
      } else {
        emit(state.copyWith(submitting: false));
      }
    } on AuthException catch (e) {
      emit(
        AuthState(
          status: AuthStatus.unauthenticated,
          notice: _noticeFor(e.kind),
        ),
      );
    }
  }

  Future<void> _onEmail(
    AuthEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(submitting: true, notice: () => null));
    try {
      await _auth.signInWithEmail(event.email, event.password);
      // Profile loading follows from the AuthSignedIn change.
      emit(state.copyWith(submitting: false));
    } on AuthException catch (e) {
      emit(
        AuthState(
          status: AuthStatus.unauthenticated,
          notice: _noticeFor(e.kind),
        ),
      );
    }
  }

  Future<void> _onResumed(
    AuthOAuthResumed event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status != AuthStatus.awaitingOAuth) return;
    await Future<void>.delayed(event.grace);
    if (state.status == AuthStatus.awaitingOAuth &&
        _auth.currentSession == null) {
      emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.cancelled,
        ),
      );
    }
  }

  void _onAbandoned(AuthOAuthAbandoned event, Emitter<AuthState> emit) {
    if (state.status == AuthStatus.awaitingOAuth) {
      emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.cancelled,
        ),
      );
    }
  }

  Future<void> _onChanged(_AuthChanged event, Emitter<AuthState> emit) async {
    switch (event.change) {
      case AuthSignedIn():
        if (state.status == AuthStatus.authenticated ||
            state.status == AuthStatus.profileIncomplete) {
          return;
        }
        emit(state.copyWith(submitting: true));
        await _loadProfile(emit);
      case AuthSignedOut(:final expired):
        emit(
          AuthState(
            status: AuthStatus.unauthenticated,
            notice: expired ? AuthNotice.sessionExpired : null,
          ),
        );
      case AuthCallbackFailed():
        emit(
          const AuthState(
            status: AuthStatus.unauthenticated,
            notice: AuthNotice.callbackFailed,
          ),
        );
    }
  }

  Future<void> _onRefresh(
    AuthProfileRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (_auth.currentSession == null) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
      return;
    }
    emit(state.copyWith(submitting: true));
    await _loadProfile(emit);
  }

  void _onProfileUpdated(AuthProfileUpdated event, Emitter<AuthState> emit) {
    emit(_signedIn(event.me));
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _auth.signOut();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  static AuthNotice _noticeFor(AuthErrorKind kind) => switch (kind) {
    AuthErrorKind.cancelled => AuthNotice.cancelled,
    AuthErrorKind.invalidCredentials => AuthNotice.invalidCredentials,
    AuthErrorKind.network => AuthNotice.network,
    AuthErrorKind.launchFailed => AuthNotice.launchFailed,
    AuthErrorKind.unknown => AuthNotice.failed,
  };

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
