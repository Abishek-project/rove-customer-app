import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/l10n.dart';
import '../core/preferences/preferences_cubit.dart';
import '../features/authentication/bloc/auth_bloc.dart';
import '../features/authentication/view/auth_callback_page.dart';
import '../features/authentication/view/complete_profile_page.dart';
import '../features/authentication/view/sign_in_page.dart';
import '../features/booking/bloc/checkout_result.dart';
import '../features/booking/view/booking_result_page.dart';
import '../features/booking/view/checkout_page.dart';
import '../features/favorites/view/saved_page.dart';
import '../features/home/view/dates_page.dart';
import '../features/home/view/home_page.dart';
import '../features/home/view/plan_trip_page.dart';
import '../features/onboarding/view/country_page.dart';
import '../features/onboarding/view/onboarding_page.dart';
import '../features/onboarding/view/splash_page.dart';
import '../features/onboarding/view/welcome_page.dart';
import '../features/profile/view/edit_profile_page.dart';
import '../features/profile/view/payment_methods_page.dart';
import '../features/profile/view/profile_page.dart';
import '../features/profile/view/settings_page.dart';
import '../features/profile/view/verification_page.dart';
import '../features/search/view/filters_page.dart';
import '../features/search/view/search_results_page.dart';
import '../features/support/view/support_pages.dart';
import '../features/trips/view/booking_detail_page.dart';
import '../features/trips/view/bookings_page.dart';
import '../features/trips/view/trip_stage_pages.dart';
import '../features/vehicles/view/vehicle_details_page.dart';
import 'router_redirect.dart';
import 'theme/rove_tokens.dart';
import 'routes.dart';

/// Re-runs redirects whenever auth or preferences change.
class _RefreshListenable extends ChangeNotifier {
  _RefreshListenable(List<Stream<Object?>> streams) {
    for (final s in streams) {
      _subscriptions.add(s.listen((_) => notifyListeners()));
    }
  }

  final List<StreamSubscription<Object?>> _subscriptions = [];

  @override
  void dispose() {
    for (final s in _subscriptions) {
      unawaited(s.cancel());
    }
    super.dispose();
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter buildRouter({
  required AuthBloc auth,
  required PreferencesCubit preferences,
  String initialLocation = Routes.splash,
}) {
  Page<void> modal(GoRouterState state, Widget child) =>
      MaterialPage(key: state.pageKey, fullscreenDialog: true, child: child);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    refreshListenable: _RefreshListenable([auth.stream, preferences.stream]),
    redirect: (context, state) => resolveRedirect(
      status: auth.state.status,
      hasCountry: preferences.state.hasCountry,
      location: state.uri.toString(),
    ),
    routes: [
      GoRoute(path: '/', redirect: (_, _) => Routes.explore),
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashPage()),
      GoRoute(path: Routes.welcome, builder: (_, _) => const WelcomePage()),
      GoRoute(path: Routes.country, builder: (_, _) => const CountryPage()),
      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingPage(),
      ),
      GoRoute(path: Routes.signIn, builder: (_, _) => const SignInPage()),
      GoRoute(
        path: Routes.authCallback,
        builder: (_, _) => const AuthCallbackPage(),
      ),
      GoRoute(
        path: Routes.completeProfile,
        builder: (_, _) => const CompleteProfilePage(),
      ),
      GoRoute(
        path: Routes.privacy,
        builder: (_, _) => const LegalPage(privacy: true),
      ),
      GoRoute(
        path: Routes.terms,
        builder: (_, _) => const LegalPage(privacy: false),
      ),
      GoRoute(
        path: '/vehicles/:id',
        builder: (_, state) =>
            VehicleDetailsPage(vehicleId: state.pathParameters['id']!),
        routes: [
          GoRoute(
            path: 'checkout',
            builder: (_, state) =>
                CheckoutPage(vehicleId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: '/checkout/result/:bookingId',
        builder: (_, state) => BookingResultPage(
          bookingId: state.pathParameters['bookingId']!,
          initial: state.extra is CheckoutResult
              ? state.extra! as CheckoutResult
              : null,
        ),
      ),
      GoRoute(
        path: Routes.dates,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) => modal(state, const DatesPage()),
      ),
      GoRoute(
        path: Routes.plan,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) => modal(state, const PlanTripPage()),
      ),
      GoRoute(
        path: Routes.filters,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) => modal(state, const FiltersPage()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _Shell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.explore,
                builder: (_, _) => const HomePage(),
                routes: [
                  GoRoute(
                    path: 'search',
                    builder: (_, _) => const SearchResultsPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.bookings,
                builder: (_, _) => const BookingsPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) => BookingDetailPage(
                      bookingId: state.pathParameters['id']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'pickup',
                        builder: (_, state) => TripStagePage(
                          bookingId: state.pathParameters['id']!,
                          stage: TripStage.pickup,
                        ),
                      ),
                      GoRoute(
                        path: 'return',
                        builder: (_, state) => TripStagePage(
                          bookingId: state.pathParameters['id']!,
                          stage: TripStage.returning,
                        ),
                      ),
                      GoRoute(
                        path: 'receipt',
                        builder: (_, state) => TripStagePage(
                          bookingId: state.pathParameters['id']!,
                          stage: TripStage.receipt,
                        ),
                      ),
                      GoRoute(
                        path: 'support',
                        builder: (_, state) => NewSupportRequestPage(
                          bookingId: state.pathParameters['id'],
                          bookingReference: state.extra is String
                              ? state.extra! as String
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.saved, builder: (_, _) => const SavedPage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (_, _) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (_, _) => const EditProfilePage(),
                  ),
                  GoRoute(
                    path: 'payment-methods',
                    builder: (_, _) => const PaymentMethodsPage(),
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (_, _) => const SettingsPage(),
                  ),
                  GoRoute(
                    path: 'verification',
                    builder: (_, _) => const VerificationPage(),
                  ),
                  GoRoute(
                    path: 'support',
                    builder: (_, _) => const SupportPage(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        builder: (_, _) => const NewSupportRequestPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// The four-tab shell with a floating pill nav (DESIGN v2): icon-only
/// circles, the active one filled with the accent; labels via semantics.
class _Shell extends StatelessWidget {
  const _Shell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final items = [
      (Icons.explore_outlined, Icons.explore, l10n.navExplore, 'nav-explore'),
      (
        Icons.event_note_outlined,
        Icons.event_note,
        l10n.navBookings,
        'nav-bookings',
      ),
      (
        Icons.favorite_border_rounded,
        Icons.favorite_rounded,
        l10n.navSaved,
        'nav-saved',
      ),
      (
        Icons.person_outline_rounded,
        Icons.person_rounded,
        l10n.navProfile,
        'nav-profile',
      ),
    ];
    return Scaffold(
      body: shell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
          child: Center(
            heightFactor: 1,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: c.inputFill,
                borderRadius: RoveRadius.pillAll,
                boxShadow: [
                  BoxShadow(
                    color: c.overlayShadow,
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final (i, (icon, activeIcon, label, key))
                      in items.indexed)
                    _NavButton(
                      key: Key(key),
                      icon: i == shell.currentIndex ? activeIcon : icon,
                      label: label,
                      selected: i == shell.currentIndex,
                      onTap: () => shell.goBranch(
                        i,
                        initialLocation: i == shell.currentIndex,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: Tooltip(
        message: label,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Material(
            color: selected ? c.primary : Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  icon,
                  size: 22,
                  color: selected ? c.onPrimary : c.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
