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
import '../features/onboarding/view/country_page.dart';
import '../features/onboarding/view/splash_page.dart';
import '../features/onboarding/view/welcome_page.dart';
import '../features/profile/view/edit_profile_page.dart';
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

/// The four-tab shell: Explore, Bookings, Saved, Profile.
class _Shell extends StatelessWidget {
  const _Shell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: RoveColors.border)),
        ),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: (i) =>
              shell.goBranch(i, initialLocation: i == shell.currentIndex),
          destinations: [
            NavigationDestination(
              key: const Key('nav-explore'),
              icon: const Icon(Icons.search_rounded),
              label: l10n.navExplore,
            ),
            NavigationDestination(
              key: const Key('nav-bookings'),
              icon: const Icon(Icons.event_note_outlined),
              selectedIcon: const Icon(Icons.event_note_rounded),
              label: l10n.navBookings,
            ),
            NavigationDestination(
              key: const Key('nav-saved'),
              icon: const Icon(Icons.favorite_border_rounded),
              selectedIcon: const Icon(Icons.favorite_rounded),
              label: l10n.navSaved,
            ),
            NavigationDestination(
              key: const Key('nav-profile'),
              icon: const Icon(Icons.person_outline_rounded),
              selectedIcon: const Icon(Icons.person_rounded),
              label: l10n.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
