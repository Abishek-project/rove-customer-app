import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/app/app.dart';
import 'package:rove_customer_app/app/di.dart';
import 'package:rove_customer_app/core/config/app_env.dart';
import 'package:rove_customer_app/core/location/location_service.dart';
import 'package:rove_customer_app/shared/data/mock/mock_repositories.dart';
import 'package:rove_customer_app/shared/data/mock/mock_rove_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';

class _NoLocation implements LocationService {
  @override
  Future<LocationResult> currentLocation() async => const LocationDenied();
}

/// End-to-end on the mock backend through the real app shell and router:
/// onboarding → sign-in → search → details → checkout → pay → result →
/// My Bookings.
void main() {
  setUpAll(setUpTimeZones);

  testWidgets('a customer books and pays for a car on mocks', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final server = MockRoveServer();
    final deps = AppDependencies.mock(
      env: const AppEnv(
        apiMode: ApiMode.mock,
        apiBaseUrl: '',
        supabaseUrl: '',
        supabaseAnonKey: '',
        enableDevEmailLogin: true,
        oauthRedirectUrl: '',
      ),
      prefs: prefs,
      server: server,
      latency: const MockLatency.none(),
      location: _NoLocation(),
    );
    usePhoneSurface(tester);
    await tester.pumpWidget(RoveApp(deps: deps));
    await tester.pumpAndSettle();

    // Welcome → onboarding → country.
    expect(find.text('Premium car rental, simply.'), findsOneWidget);
    await tester.tap(find.byKey(const Key('welcome-get-started')));
    await tester.pumpAndSettle();
    expect(find.text('Premium car rental in Dubai & Mumbai'), findsOneWidget);
    await tester.tap(find.byKey(const Key('onboarding-next')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('onboarding-skip')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('country-AE')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Sign in (dev email).
    expect(find.text('Continue with Google'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('dev-email')),
      'customer@rove.test',
    );
    await tester.enterText(find.byKey(const Key('dev-password')), 'local-dev');
    await tester.ensureVisible(find.byKey(const Key('dev-sign-in')));
    await tester.tap(find.byKey(const Key('dev-sign-in')));
    await tester.pumpAndSettle();

    // Home.
    expect(find.text('Hi Aisha'), findsOneWidget);
    expect(find.text('Dubai'), findsOneWidget);
    await tester.tap(find.byKey(const Key('home-search-pill')));
    await tester.pumpAndSettle();
    expect(find.text('Plan your trip'), findsOneWidget);
    await tester.tap(find.byKey(const Key('home-search')));
    await tester.pumpAndSettle();

    // Results → first car.
    expect(
      find.text('Only cars available for your full trip are shown.'),
      findsOneWidget,
    );
    await tester.tap(
      find.byKey(
        const ValueKey('vehicle-c1d6b6a3-5c0a-4fa6-af53-6c7b8a9fad02'),
      ),
    );
    await tester.pumpAndSettle();

    // Details → checkout.
    expect(find.text('Mercedes-AMG G 63'), findsWidgets);
    expect(find.text('Refundable deposit'), findsOneWidget);
    await tester.tap(find.byKey(const Key('details-book')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('checkout-continue')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('driver-dob')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('driver-continue')));
    await tester.pumpAndSettle();

    // Review: backend quote, terms, book.
    expect(find.text('Price details'), findsOneWidget);
    expect(find.textContaining('VAT (5%)'), findsOneWidget);
    final book = find.byKey(const Key('checkout-book'));
    await tester.dragUntilVisible(
      find.byKey(const Key('checkout-terms')),
      find.byType(ListView).last,
      const Offset(0, -300),
    );
    // Lift the checkbox clear of the sticky bottom bar.
    await tester.drag(find.byType(ListView).last, const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('checkout-terms')));
    await tester.pumpAndSettle();
    await tester.tap(book);
    await tester.pumpAndSettle();

    // Payment sheet → pay.
    expect(find.text('Test mode: no real payment is taken.'), findsOneWidget);
    expect(find.text('Apple Pay'), findsOneWidget);
    await tester.tap(find.byKey(const Key('payment-pay')));
    await tester.pumpAndSettle();

    // Authoritative result (instant booking).
    expect(find.byKey(const Key('result-confirmed')), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
    await tester.tap(find.byKey(const Key('result-view-booking')));
    await tester.pumpAndSettle();

    // Booking detail shows only allowed actions.
    expect(find.byKey(const Key('booking-status')), findsOneWidget);
    expect(find.byKey(const Key('booking-cancel')), findsOneWidget);
    expect(find.byKey(const Key('booking-pay')), findsNothing);
  });
}
