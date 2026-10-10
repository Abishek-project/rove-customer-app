import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/features/authentication/bloc/auth_bloc.dart';
import 'package:rove_customer_app/shared/repositories/auth_repository.dart';
import 'package:rove_customer_app/shared/repositories/profile_repository.dart';

import '../helpers/helpers.dart';

class _MockAuth extends Mock implements AuthRepository {}

class _MockProfile extends Mock implements ProfileRepository {}

void main() {
  group('with the mock backend', () {
    late MockStack stack;
    setUp(() => stack = MockStack());

    AuthBloc build() =>
        AuthBloc(authRepository: stack.auth, profileRepository: stack.profile);

    blocTest<AuthBloc, AuthState>(
      'no stored session → unauthenticated',
      build: build,
      act: (b) => b.add(const AuthStarted()),
      expect: () => [const AuthState(status: AuthStatus.unauthenticated)],
    );

    blocTest<AuthBloc, AuthState>(
      'email sign-in with a complete profile → authenticated',
      build: build,
      act: (b) async {
        b.add(const AuthStarted());
        await Future<void>.delayed(Duration.zero);
        b.add(const AuthEmailRequested('customer@rove.test', 'pw'));
      },
      wait: const Duration(milliseconds: 50),
      verify: (b) {
        expect(b.state.status, AuthStatus.authenticated);
        expect(b.state.me?.profile.countryCode, 'AE');
      },
    );

    blocTest<AuthBloc, AuthState>(
      'Google sign-in for a new account → profile completion',
      build: build,
      act: (b) => b.add(const AuthGoogleRequested()),
      wait: const Duration(milliseconds: 50),
      verify: (b) => expect(b.state.status, AuthStatus.profileIncomplete),
    );

    blocTest<AuthBloc, AuthState>(
      'cancelled Google sign-in shows a notice',
      build: () {
        stack.auth.nextGoogleError = AuthErrorKind.cancelled;
        return build();
      },
      act: (b) => b.add(const AuthGoogleRequested()),
      wait: const Duration(milliseconds: 20),
      verify: (b) {
        expect(b.state.status, AuthStatus.unauthenticated);
        expect(b.state.notice, AuthNotice.cancelled);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'session expiry signs out with a notice',
      build: build,
      act: (b) async {
        await stack.signInAe();
        await Future<void>.delayed(const Duration(milliseconds: 10));
        await stack.auth.handleSessionExpired();
      },
      wait: const Duration(milliseconds: 30),
      verify: (b) {
        expect(b.state.status, AuthStatus.unauthenticated);
        expect(b.state.notice, AuthNotice.sessionExpired);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'sign-out returns to unauthenticated',
      build: build,
      act: (b) async {
        await stack.signInAe();
        await Future<void>.delayed(const Duration(milliseconds: 10));
        b.add(const AuthSignOutRequested());
      },
      wait: const Duration(milliseconds: 30),
      verify: (b) => expect(b.state.status, AuthStatus.unauthenticated),
    );
  });

  group('with mocked repositories', () {
    late _MockAuth auth;
    late _MockProfile profile;

    setUp(() {
      auth = _MockAuth();
      profile = _MockProfile();
      when(() => auth.changes).thenAnswer((_) => const Stream.empty());
    });

    blocTest<AuthBloc, AuthState>(
      'restored session but /me offline → profileLoadFailed (no guessing)',
      build: () {
        when(auth.restoreSession).thenAnswer(
          (_) async => const AuthSession(userId: 'u', accessToken: 't'),
        );
        when(profile.getMe).thenThrow(const ApiFailure.network());
        return AuthBloc(authRepository: auth, profileRepository: profile);
      },
      act: (b) => b.add(const AuthStarted()),
      expect: () => [
        const AuthState(
          status: AuthStatus.profileLoadFailed,
          failure: ApiFailure.network(),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'restored session rejected by the API → signed out, session expired',
      build: () {
        when(auth.restoreSession).thenAnswer(
          (_) async => const AuthSession(userId: 'u', accessToken: 't'),
        );
        when(profile.getMe).thenThrow(
          const ApiFailure(code: ErrorCodes.unauthenticated, statusCode: 401),
        );
        return AuthBloc(authRepository: auth, profileRepository: profile);
      },
      act: (b) => b.add(const AuthStarted()),
      expect: () => [
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.sessionExpired,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'invalid email credentials → notice',
      build: () {
        when(
          () => auth.signInWithEmail(any(), any()),
        ).thenThrow(const AuthException(AuthErrorKind.invalidCredentials));
        return AuthBloc(authRepository: auth, profileRepository: profile);
      },
      act: (b) => b.add(const AuthEmailRequested('a@b.co', 'bad')),
      expect: () => [
        const AuthState(submitting: true),
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.invalidCredentials,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'returning from Google without a session counts as cancelled',
      build: () {
        when(auth.signInWithGoogle).thenAnswer((_) async {});
        when(() => auth.currentSession).thenReturn(null);
        return AuthBloc(authRepository: auth, profileRepository: profile);
      },
      seed: () => const AuthState(status: AuthStatus.unauthenticated),
      act: (b) async {
        b.add(const AuthGoogleRequested());
        await Future<void>.delayed(Duration.zero);
        b.add(const AuthOAuthResumed(grace: Duration(milliseconds: 5)));
      },
      wait: const Duration(milliseconds: 30),
      expect: () => [
        const AuthState(status: AuthStatus.unauthenticated, submitting: true),
        const AuthState(status: AuthStatus.awaitingOAuth),
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.cancelled,
        ),
      ],
    );
  });
}
