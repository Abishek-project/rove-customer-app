import '../features/authentication/bloc/auth_bloc.dart';
import 'routes.dart';

/// Route protection, as a pure function so it can be unit-tested.
///
/// * While the session is being restored (or `/me` failed) → splash.
/// * Signed out → onboarding (welcome when no country chosen yet, otherwise
///   sign-in); public pages stay reachable.
/// * Waiting for the Google callback → the callback screen.
/// * Signed in with an incomplete profile → profile completion.
/// * Signed in → never back to onboarding.
String? resolveRedirect({
  required AuthStatus status,
  required bool hasCountry,
  required String location,
}) {
  final path = Uri.parse(location).path;
  final isPublic = Routes.publicPaths.contains(path);

  switch (status) {
    case AuthStatus.unknown:
    case AuthStatus.profileLoadFailed:
      return path == Routes.splash ? null : Routes.splash;

    case AuthStatus.unauthenticated:
      if (path == Routes.splash || path == Routes.authCallback) {
        return hasCountry ? Routes.signIn : Routes.welcome;
      }
      if (isPublic) {
        if (path == Routes.signIn && !hasCountry) return Routes.country;
        return null;
      }
      return hasCountry ? Routes.signIn : Routes.welcome;

    case AuthStatus.awaitingOAuth:
      return path == Routes.authCallback ? null : Routes.authCallback;

    case AuthStatus.profileIncomplete:
      if (path == Routes.completeProfile ||
          path == Routes.privacy ||
          path == Routes.terms) {
        return null;
      }
      return Routes.completeProfile;

    case AuthStatus.authenticated:
      if (Routes.onboardingPaths.contains(path) ||
          path == Routes.completeProfile ||
          path == '/') {
        return Routes.explore;
      }
      return null;
  }
}
