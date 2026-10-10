import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/core/utils/load_status.dart';
import 'package:rove_customer_app/features/search/bloc/search_bloc.dart';
import 'package:rove_customer_app/shared/models/enums.dart';
import 'package:rove_customer_app/shared/models/reference.dart';
import 'package:rove_customer_app/shared/models/vehicle.dart';
import 'package:rove_customer_app/shared/repositories/vehicle_repository.dart';

import '../helpers/helpers.dart';

class _MockVehicles extends Mock implements VehicleRepository {}

void main() {
  setUpAll(() {
    setUpTimeZones();
    registerFallbackValue(const VehicleQuery(countryCode: 'AE'));
  });

  group('VehicleQuery filters', () {
    final period = testPeriod();
    final query = VehicleQuery(
      countryCode: 'AE',
      cityId: 'dubai',
      pickupAt: period.pickupAt,
      returnAt: period.returnAt,
      category: VehicleCategory.suv,
      transmission: Transmission.automatic,
      minSeats: 5,
      maxDailyRateMinor: 30000,
      deliveryAvailable: true,
      fuelType: FuelType.hybrid,
      sort: VehicleSort.priceAsc,
      page: 2,
    );

    test('serialises every filter with contract names and UTC dates', () {
      expect(query.toQueryParameters(), {
        'countryCode': 'AE',
        'cityId': 'dubai',
        'pickupAt': '2026-10-13T06:00:00.000Z',
        'returnAt': '2026-10-16T06:00:00.000Z',
        'category': 'suv',
        'transmission': 'automatic',
        'minSeats': 5,
        'maxDailyRateMinor': 30000,
        'deliveryAvailable': true,
        'fuelType': 'hybrid',
        'sort': 'price_asc',
        'page': 2,
        'pageSize': 20,
      });
      expect(query.activeFilterCount, 6);
    });

    test('dates are sent together or not at all', () {
      final noDates = query.copyWith(pickupAt: () => null);
      final params = noDates.toQueryParameters();
      expect(params.containsKey('pickupAt'), isFalse);
      expect(params.containsKey('returnAt'), isFalse);
    });

    test('clearing filters keeps location, dates and sort', () {
      final cleared = query.clearFilters();
      expect(cleared.activeFilterCount, 0);
      expect(cleared.cityId, 'dubai');
      expect(cleared.pickupAt, period.pickupAt);
      expect(cleared.sort, VehicleSort.priceAsc);
      expect(cleared.page, 1);
    });
  });

  group('SearchBloc with the mock backend', () {
    late MockStack stack;
    setUp(() async {
      stack = MockStack();
      await stack.signInAe();
    });
    final period = testPeriod();
    VehicleQuery dubai() => VehicleQuery(
      countryCode: 'AE',
      cityId: MockStack.dubai,
      pickupAt: period.pickupAt,
      returnAt: period.returnAt,
    );

    blocTest<SearchBloc, SearchState>(
      'loading → success with backend estimated totals',
      build: () => SearchBloc(stack.vehicles),
      act: (b) => b.add(SearchRequested(dubai())),
      expect: () => [
        isA<SearchState>().having(
          (s) => s.status,
          'status',
          LoadStatus.loading,
        ),
        isA<SearchState>()
            .having((s) => s.status, 'status', LoadStatus.success)
            .having(
              (s) =>
                  s.vehicles.every((v) => v.estimatedTotal?.currency == 'AED'),
              'AED totals',
              isTrue,
            ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'filters with no match → empty',
      build: () => SearchBloc(stack.vehicles),
      act: (b) => b.add(
        SearchRequested(dubai().copyWith(maxDailyRateMinor: () => 100)),
      ),
      expect: () => [
        isA<SearchState>().having(
          (s) => s.status,
          'status',
          LoadStatus.loading,
        ),
        isA<SearchState>().having((s) => s.status, 'status', LoadStatus.empty),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'sorting by price asks the backend again',
      build: () => SearchBloc(stack.vehicles),
      act: (b) async {
        b.add(SearchRequested(dubai()));
        await Future<void>.delayed(Duration.zero);
        b.add(const SearchSortChanged(VehicleSort.priceAsc));
      },
      wait: const Duration(milliseconds: 20),
      verify: (b) {
        final rates = b.state.vehicles
            .map((v) => v.dailyRate.amountMinor)
            .toList();
        expect(rates, [...rates]..sort());
        expect(b.state.query!.sort, VehicleSort.priceAsc);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'pagination appends the next page',
      build: () => SearchBloc(stack.vehicles),
      act: (b) async {
        b.add(
          const SearchRequested(VehicleQuery(countryCode: 'AE', pageSize: 2)),
        );
        await Future<void>.delayed(Duration.zero);
        b.add(const SearchNextPageRequested());
      },
      wait: const Duration(milliseconds: 20),
      verify: (b) {
        expect(b.state.vehicles, hasLength(4));
        expect(b.state.meta.page, 2);
        expect(b.state.vehicles.map((v) => v.id).toSet(), hasLength(4));
      },
    );
  });

  group('SearchBloc errors', () {
    late _MockVehicles vehicles;
    setUp(() => vehicles = _MockVehicles());

    blocTest<SearchBloc, SearchState>(
      'network failure → failure state, retry recovers',
      build: () {
        var calls = 0;
        when(() => vehicles.search(any())).thenAnswer((_) async {
          if (calls++ == 0) throw const ApiFailure.network();
          return const Paged<VehicleSummary>([], PageMeta());
        });
        return SearchBloc(vehicles);
      },
      act: (b) async {
        b.add(const SearchRequested(VehicleQuery(countryCode: 'AE')));
        await Future<void>.delayed(Duration.zero);
        b.add(const SearchRetried());
      },
      wait: const Duration(milliseconds: 20),
      expect: () => [
        isA<SearchState>().having(
          (s) => s.status,
          'status',
          LoadStatus.loading,
        ),
        isA<SearchState>()
            .having((s) => s.status, 'status', LoadStatus.failure)
            .having((s) => s.failure?.isNetwork, 'network', isTrue),
        isA<SearchState>().having(
          (s) => s.status,
          'status',
          LoadStatus.loading,
        ),
        isA<SearchState>().having((s) => s.status, 'status', LoadStatus.empty),
      ],
    );
  });
}
