import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rove_customer_app/app/theme/rove_theme.dart';
import 'package:rove_customer_app/core/time/zoned_time.dart';
import 'package:rove_customer_app/l10n/gen/app_localizations.dart';
import 'package:rove_customer_app/shared/data/mock/mock_fixtures.dart';
import 'package:rove_customer_app/shared/data/mock/mock_repositories.dart';
import 'package:rove_customer_app/shared/data/mock/mock_rove_server.dart';

/// A fixed "now" for deterministic tests: 2026-10-10 08:00 UTC.
final testNow = DateTime.utc(2026, 10, 10, 8);

DateTime testClock() => testNow;

/// The mock backend plus all Mock* repositories, without latency.
class MockStack {
  MockStack({DateTime Function()? clock})
    : server = MockRoveServer(clock: clock ?? testClock) {
    auth = MockAuthRepository(
      server: server,
      latency: const MockLatency.none(),
    );
    reference = MockReferenceRepository(
      server,
      latency: const MockLatency.none(),
    );
    vehicles = MockVehicleRepository(
      server,
      auth,
      latency: const MockLatency.none(),
    );
    favorites = MockFavoritesRepository(
      server,
      auth,
      latency: const MockLatency.none(),
    );
    bookings = MockBookingRepository(
      server,
      auth,
      latency: const MockLatency.none(),
    );
    payments = MockPaymentRepository(
      server,
      auth,
      latency: const MockLatency.none(),
    );
    profile = MockProfileRepository(
      server,
      auth,
      latency: const MockLatency.none(),
    );
    support = MockSupportRepository(
      server,
      auth,
      latency: const MockLatency.none(),
    );
  }

  final MockRoveServer server;
  late final MockAuthRepository auth;
  late final MockReferenceRepository reference;
  late final MockVehicleRepository vehicles;
  late final MockFavoritesRepository favorites;
  late final MockBookingRepository bookings;
  late final MockPaymentRepository payments;
  late final MockProfileRepository profile;
  late final MockSupportRepository support;

  Future<void> signInAe() => auth.signInWithEmail('customer@rove.test', 'x');
  Future<void> signInIn() => auth.signInWithEmail('customer.in@rove.test', 'x');

  static const aeEconomyId = 'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad01';
  static const aeSuvInstantId = 'c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad02';
  static const inSwiftId = 'd2e7c7b4-6d1b-40b7-b064-7d8c9bab0e01';
  static const dubai = MockIds.cityDubai;
}

/// Pickup 3 days after [testNow] at 06:00 UTC (10:00 Dubai), 3 days long.
({DateTime pickupAt, DateTime returnAt}) testPeriod({
  int days = 3,
  int inDays = 3,
}) {
  final pickup = DateTime.utc(2026, 10, 10 + inDays, 6);
  return (pickupAt: pickup, returnAt: pickup.add(Duration(days: days)));
}

void setUpTimeZones() => ZonedTime.ensureInitialized();

/// Pumps [child] inside a localized, themed MaterialApp with optional
/// providers, with animations disabled.
Future<void> pumpLocalized(
  WidgetTester tester,
  Widget child, {
  List<BlocProvider> blocs = const [],
  List<RepositoryProvider<Object?>> repositories = const [],
}) async {
  usePhoneSurface(tester);
  Widget app = MaterialApp(
    theme: RoveTheme.dark(),
    localizationsDelegates: localizationDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
  if (blocs.isNotEmpty) app = MultiBlocProvider(providers: blocs, child: app);
  if (repositories.isNotEmpty) {
    app = MultiRepositoryProvider(providers: repositories, child: app);
  }
  await tester.pumpWidget(app);
}

const localizationDelegates = <LocalizationsDelegate<Object?>>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

/// A phone-sized surface (≈ iPhone 17 Pro) with animations disabled.
void usePhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(1206, 2622);
  tester.view.devicePixelRatio = 3;
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
}

/// Pumps [page] at `/` of a GoRouter so navigation calls work.
Future<void> pumpRouted(
  WidgetTester tester,
  Widget page, {
  List<RepositoryProvider<Object?>> repositories = const [],
}) async {
  usePhoneSurface(tester);
  Widget app = MaterialApp.router(
    theme: RoveTheme.dark(),
    localizationsDelegates: localizationDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => page),
        GoRoute(path: '/:rest(.*)', builder: (_, _) => const SizedBox()),
      ],
    ),
  );
  if (repositories.isNotEmpty) {
    app = MultiRepositoryProvider(providers: repositories, child: app);
  }
  await tester.pumpWidget(app);
}
