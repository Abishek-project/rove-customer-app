import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/app/router_redirect.dart';
import 'package:rove_customer_app/app/routes.dart';
import 'package:rove_customer_app/features/authentication/bloc/auth_bloc.dart';

void main() {
  String? go(AuthStatus s, String loc, {bool hasCountry = true}) =>
      resolveRedirect(status: s, hasCountry: hasCountry, location: loc);

  group('auth redirects', () {
    test('restoring the session always shows the splash', () {
      expect(go(AuthStatus.unknown, Routes.explore), Routes.splash);
      expect(go(AuthStatus.unknown, Routes.splash), isNull);
      expect(go(AuthStatus.profileLoadFailed, '/bookings/1'), Routes.splash);
    });

    test('signed-out users go to welcome until a country is chosen', () {
      expect(
        go(AuthStatus.unauthenticated, Routes.splash, hasCountry: false),
        Routes.welcome,
      );
      expect(
        go(AuthStatus.unauthenticated, Routes.explore, hasCountry: false),
        Routes.welcome,
      );
      expect(
        go(AuthStatus.unauthenticated, Routes.signIn, hasCountry: false),
        Routes.country,
      );
      expect(
        go(AuthStatus.unauthenticated, Routes.country, hasCountry: false),
        isNull,
      );
    });

    test('protected routes send signed-out users to sign-in', () {
      for (final path in [
        Routes.explore,
        Routes.bookings,
        '/bookings/abc',
        Routes.saved,
        Routes.profile,
        '/vehicles/v1/checkout',
      ]) {
        expect(
          go(AuthStatus.unauthenticated, path),
          Routes.signIn,
          reason: path,
        );
      }
    });

    test('public pages stay reachable when signed out', () {
      expect(go(AuthStatus.unauthenticated, Routes.signIn), isNull);
      expect(go(AuthStatus.unauthenticated, Routes.terms), isNull);
      expect(go(AuthStatus.unauthenticated, Routes.privacy), isNull);
      expect(go(AuthStatus.unauthenticated, Routes.welcome), isNull);
    });

    test('a cancelled OAuth callback falls back to sign-in', () {
      expect(
        go(AuthStatus.unauthenticated, Routes.authCallback),
        Routes.signIn,
      );
      expect(go(AuthStatus.awaitingOAuth, Routes.signIn), Routes.authCallback);
      expect(go(AuthStatus.awaitingOAuth, Routes.authCallback), isNull);
    });

    test('incomplete profiles must finish profile completion', () {
      expect(
        go(AuthStatus.profileIncomplete, Routes.explore),
        Routes.completeProfile,
      );
      expect(
        go(AuthStatus.profileIncomplete, Routes.signIn),
        Routes.completeProfile,
      );
      expect(go(AuthStatus.profileIncomplete, Routes.completeProfile), isNull);
      expect(go(AuthStatus.profileIncomplete, Routes.terms), isNull);
    });

    test('signed-in users skip onboarding and reach protected routes', () {
      expect(go(AuthStatus.authenticated, Routes.signIn), Routes.explore);
      expect(go(AuthStatus.authenticated, Routes.splash), Routes.explore);
      expect(
        go(AuthStatus.authenticated, Routes.completeProfile),
        Routes.explore,
      );
      expect(go(AuthStatus.authenticated, '/bookings/abc?x=1'), isNull);
      expect(go(AuthStatus.authenticated, Routes.search), isNull);
    });
  });
}
