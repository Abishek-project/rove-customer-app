import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/preferences/preferences_cubit.dart';
import 'package:rove_customer_app/core/time/zoned_time.dart';
import 'package:rove_customer_app/core/utils/load_status.dart';
import 'package:rove_customer_app/features/onboarding/bloc/countries_cubit.dart';
import 'package:rove_customer_app/features/search/bloc/trip_cubit.dart';
import 'package:rove_customer_app/shared/models/reference.dart';
import 'package:rove_customer_app/shared/repositories/vehicle_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(setUpTimeZones);

  late MockStack stack;
  late List<Country> countries;
  setUp(() async {
    stack = MockStack();
    countries = await stack.reference.getCountries();
  });

  test('country config comes from GET /countries', () async {
    final cubit = CountriesCubit(stack.reference);
    await cubit.load();
    expect(cubit.state.status, LoadStatus.success);
    final ae = cubit.state.byCode('AE')!;
    final india = cubit.state.byCode('IN')!;
    expect(ae.currency, 'AED');
    expect(ae.taxLabel, 'VAT');
    expect(ae.paymentMethods, contains('apple_pay'));
    expect(india.currency, 'INR');
    expect(india.taxRateBps, 1800);
    expect(india.paymentMethods, contains('upi'));
    expect(cubit.state.cityById(india.cities.first.id)?.countryCode, 'IN');
  });

  test('switching country switches the currency of search results', () async {
    await stack.signInAe();
    final ae = await stack.vehicles.search(
      const VehicleQuery(countryCode: 'AE'),
    );
    final india = await stack.vehicles.search(
      const VehicleQuery(countryCode: 'IN'),
    );
    expect(ae.items.map((v) => v.dailyRate.currency).toSet(), {'AED'});
    expect(india.items.map((v) => v.dailyRate.currency).toSet(), {'INR'});
    expect(india.items.first.dailyRate.format(), startsWith('₹'));
    expect(ae.items.first.dailyRate.format(), startsWith('AED '));
  });

  group('TripCubit', () {
    City city(String code) =>
        countries.firstWhere((c) => c.code == code).cities.first;

    blocTest<TripCubit, TripState>(
      'defaults to tomorrow 10:00 local for three days',
      build: () => TripCubit(clock: testClock),
      act: (c) => c.setCountry('AE', city: city('AE')),
      verify: (c) {
        final local = ZonedTime.inZone(c.state.pickupAt!, 'Asia/Dubai');
        expect(local.day, 11);
        expect(local.hour, 10);
        expect(c.state.returnAt!.difference(c.state.pickupAt!).inDays, 3);
        expect(c.state.validate(testNow), isNull);
      },
    );

    blocTest<TripCubit, TripState>(
      'moving from Dubai to Mumbai keeps 10:00 local, not the same instant',
      build: () => TripCubit(clock: testClock),
      act: (c) {
        c.setCountry('AE', city: city('AE'));
        c.setCountry('IN', city: city('IN'));
      },
      verify: (c) {
        final local = ZonedTime.inZone(c.state.pickupAt!, 'Asia/Kolkata');
        expect(local.hour, 10);
        expect(local.minute, 0);
        expect(c.state.countryCode, 'IN');
        expect(c.state.timezone, 'Asia/Kolkata');
      },
    );
  });

  group('PreferencesCubit', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('changing country clears the city and recently viewed', () async {
      final prefs = PreferencesCubit(await SharedPreferences.getInstance());
      await prefs.setCountry('AE', cityId: MockStack.dubai);
      await stack.signInAe();
      final v = (await stack.vehicles.search(
        const VehicleQuery(countryCode: 'AE'),
      )).items.first;
      await prefs.addRecentlyViewed(v);
      expect(prefs.state.recentlyViewed, hasLength(1));
      await prefs.setCountry('IN');
      expect(prefs.state.countryCode, 'IN');
      expect(prefs.state.cityId, isNull);
      expect(prefs.state.recentlyViewed, isEmpty);
    });

    test('persists across restarts', () async {
      final store = await SharedPreferences.getInstance();
      await PreferencesCubit(store).setCountry('IN', cityId: 'mumbai');
      final restored = PreferencesCubit(store);
      expect(restored.state.countryCode, 'IN');
      expect(restored.state.cityId, 'mumbai');
    });
  });
}
