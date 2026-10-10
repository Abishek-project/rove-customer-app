/// Route paths. Widgets navigate with these helpers, never with literals.
abstract final class Routes {
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const country = '/country';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const authCallback = '/auth/callback';
  static const completeProfile = '/complete-profile';

  static const explore = '/explore';
  static const search = '/explore/search';
  static const filters = '/explore/search/filters';
  static const dates = '/explore/dates';
  static const plan = '/explore/plan';

  static String vehicle(String id) => '/vehicles/$id';
  static String checkout(String vehicleId) => '/vehicles/$vehicleId/checkout';
  static String bookingResult(String bookingId) =>
      '/checkout/result/$bookingId';

  static const bookings = '/bookings';
  static String booking(String id) => '/bookings/$id';
  static String bookingPickup(String id) => '/bookings/$id/pickup';
  static String bookingReturn(String id) => '/bookings/$id/return';
  static String bookingReceipt(String id) => '/bookings/$id/receipt';
  static String bookingSupport(String id) => '/bookings/$id/support';

  static const saved = '/saved';

  static const profile = '/profile';
  static const profileEdit = '/profile/edit';
  static const settings = '/profile/settings';
  static const paymentMethods = '/profile/payment-methods';
  static const verification = '/profile/verification';
  static const support = '/profile/support';
  static const supportNew = '/profile/support/new';
  static const privacy = '/legal/privacy';
  static const terms = '/legal/terms';

  /// Reachable without a session.
  static const publicPaths = {
    splash,
    welcome,
    onboarding,
    country,
    signIn,
    authCallback,
    privacy,
    terms,
  };

  /// Onboarding screens a signed-in user should not land on.
  static const onboardingPaths = {
    splash,
    welcome,
    onboarding,
    country,
    signIn,
    authCallback,
  };
}
