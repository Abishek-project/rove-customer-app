import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/config/app_env.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/core/preferences/preferences_cubit.dart';
import 'package:rove_customer_app/features/authentication/bloc/auth_bloc.dart';
import 'package:rove_customer_app/features/authentication/view/sign_in_page.dart';
import 'package:rove_customer_app/features/booking/bloc/checkout_result.dart';
import 'package:rove_customer_app/features/booking/view/booking_result_page.dart';
import 'package:rove_customer_app/features/onboarding/bloc/countries_cubit.dart';
import 'package:rove_customer_app/features/profile/view/profile_fields.dart';
import 'package:rove_customer_app/features/search/bloc/search_bloc.dart';
import 'package:rove_customer_app/features/search/view/search_results_page.dart';
import 'package:rove_customer_app/shared/models/enums.dart';
import 'package:rove_customer_app/shared/models/profile.dart';
import 'package:rove_customer_app/shared/repositories/booking_repository.dart';
import 'package:rove_customer_app/shared/repositories/vehicle_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(setUpTimeZones);

  late MockStack stack;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    stack = MockStack();
  });

  group('search results', () {
    Future<SearchBloc> pumpSearch(
      WidgetTester tester,
      VehicleQuery query,
    ) async {
      await stack.signInAe();
      final countries = CountriesCubit(stack.reference);
      await countries.load();
      final search = SearchBloc(stack.vehicles)..add(SearchRequested(query));
      await pumpLocalized(
        tester,
        const SearchResultsPage(),
        blocs: [
          BlocProvider<SearchBloc>.value(value: search),
          BlocProvider<CountriesCubit>.value(value: countries),
        ],
      );
      return search;
    }

    testWidgets('shows a skeleton, then backend results', (tester) async {
      final p = testPeriod();
      await pumpSearch(
        tester,
        VehicleQuery(
          countryCode: 'AE',
          cityId: MockStack.dubai,
          pickupAt: p.pickupAt,
          returnAt: p.returnAt,
        ),
      );
      expect(find.byType(SearchResultsPage), findsOneWidget);
      await tester.pumpAndSettle();
      expect(
        find.text('Only cars available for your full trip are shown.'),
        findsOneWidget,
      );
      expect(find.textContaining('cars'), findsWidgets);
      expect(find.text('Dubai'), findsOneWidget);
    });

    testWidgets('empty results offer to clear filters', (tester) async {
      final search = await pumpSearch(
        tester,
        const VehicleQuery(countryCode: 'AE', maxDailyRateMinor: 100),
      );
      await tester.pumpAndSettle();
      expect(find.text('No cars match these filters.'), findsOneWidget);
      await tester.tap(find.text('Clear filters'));
      await tester.pumpAndSettle();
      expect(search.state.query!.maxDailyRateMinor, isNull);
      expect(find.text('No cars match these filters.'), findsNothing);
    });
  });

  group('sign-in', () {
    Future<AuthBloc> pumpSignIn(
      WidgetTester tester, {
      bool devLogin = true,
    }) async {
      final prefs = PreferencesCubit(await SharedPreferences.getInstance());
      await prefs.setCountry('AE');
      final countries = CountriesCubit(stack.reference);
      await countries.load();
      final auth = AuthBloc(
        authRepository: stack.auth,
        profileRepository: stack.profile,
      );
      await pumpLocalized(
        tester,
        const SignInPage(),
        blocs: [
          BlocProvider<AuthBloc>.value(value: auth),
          BlocProvider<PreferencesCubit>.value(value: prefs),
          BlocProvider<CountriesCubit>.value(value: countries),
        ],
        repositories: [
          RepositoryProvider<AppEnv>.value(
            value: AppEnv(
              apiMode: ApiMode.mock,
              apiBaseUrl: '',
              supabaseUrl: '',
              supabaseAnonKey: '',
              enableDevEmailLogin: devLogin,
              oauthRedirectUrl: '',
            ),
          ),
        ],
      );
      return auth;
    }

    testWidgets('dev email login is hidden unless enabled', (tester) async {
      await pumpSignIn(tester, devLogin: false);
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.byKey(const Key('dev-email')), findsNothing);
    });

    testWidgets('validates the dev email form', (tester) async {
      await pumpSignIn(tester);
      await tester.ensureVisible(find.byKey(const Key('dev-sign-in')));
      await tester.tap(find.byKey(const Key('dev-sign-in')));
      await tester.pump();
      expect(find.text('Required'), findsNWidgets(2));
      await tester.enterText(
        find.byKey(const Key('dev-email')),
        'not-an-email',
      );
      await tester.tap(find.byKey(const Key('dev-sign-in')));
      await tester.pump();
      expect(find.text('Enter a valid email address'), findsOneWidget);
    });

    testWidgets('shows the cancelled-sign-in notice', (tester) async {
      stack.auth.nextGoogleError = null;
      final auth = await pumpSignIn(tester);
      auth.emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.cancelled,
        ),
      );
      await tester.pump();
      expect(find.text('Sign-in was cancelled.'), findsOneWidget);
      auth.emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
          notice: AuthNotice.sessionExpired,
        ),
      );
      await tester.pump();
      expect(
        find.text('Your session expired. Please sign in again.'),
        findsOneWidget,
      );
    });
  });

  testWidgets('profile form validates name and phone', (tester) async {
    final countries = CountriesCubit(stack.reference);
    await countries.load();
    ProfileUpdate? submitted;
    await pumpLocalized(
      tester,
      Scaffold(
        body: SingleChildScrollView(
          child: ProfileFields(
            initial: const CustomerProfile(countryCode: 'AE'),
            submitLabel: 'Continue',
            onSubmit: (u) => submitted = u,
          ),
        ),
      ),
      blocs: [BlocProvider<CountriesCubit>.value(value: countries)],
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('profile-submit')));
    await tester.pump();
    expect(find.text('Required'), findsNWidgets(2));
    expect(submitted, isNull);

    await tester.enterText(
      find.byKey(const Key('profile-name')),
      'Aisha Rahman',
    );
    await tester.enterText(find.byKey(const Key('profile-phone')), '123');
    await tester.tap(find.byKey(const Key('profile-submit')));
    await tester.pump();
    expect(find.text('Enter a phone number with country code'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('profile-phone')),
      '+971 50 123 4567',
    );
    await tester.tap(find.byKey(const Key('profile-submit')));
    await tester.pump();
    expect(submitted?.fullName, 'Aisha Rahman');
    expect(submitted?.countryCode, 'AE');
  });

  group('booking result', () {
    Future<void> pumpResult(WidgetTester tester, CheckoutResult result) async {
      await pumpRouted(
        tester,
        BookingResultPage(
          bookingId: result.booking?.id ?? 'none',
          initial: result,
        ),
        repositories: [
          RepositoryProvider<BookingRepository>.value(value: stack.bookings),
        ],
      );
      await tester.pumpAndSettle();
    }

    testWidgets('a seeded confirmed booking reads "Booking confirmed"', (
      tester,
    ) async {
      await stack.signInAe();
      final upcoming = await stack.bookings.list(BookingGroup.upcoming);
      final booking = await stack.bookings.get(upcoming.items.first.id);
      await pumpResult(tester, CheckoutResult(booking: booking));
      expect(find.byKey(const Key('result-confirmed')), findsOneWidget);
      expect(find.text(booking.reference), findsOneWidget);
      expect(find.text('Paid'), findsOneWidget);
    });

    testWidgets('an unknown outcome never claims success', (tester) async {
      await pumpResult(
        tester,
        const CheckoutResult(failure: ApiFailure.network()),
      );
      expect(find.byKey(const Key('result-unknown')), findsOneWidget);
      expect(find.text('Booking confirmed'), findsNothing);
      expect(find.byKey(const Key('result-check-status')), findsOneWidget);
    });

    testWidgets('unavailable car explains and offers to go back', (
      tester,
    ) async {
      await pumpResult(
        tester,
        const CheckoutResult(
          failure: ApiFailure(code: ErrorCodes.vehicleUnavailable),
        ),
      );
      expect(find.byKey(const Key('result-unavailable')), findsOneWidget);
      expect(find.text('Back to explore'), findsOneWidget);
    });
  });
}
