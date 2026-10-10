import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/core/utils/load_status.dart';
import 'package:rove_customer_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rove_customer_app/shared/models/vehicle.dart';
import 'package:rove_customer_app/shared/repositories/favorites_repository.dart';
import 'package:rove_customer_app/shared/repositories/vehicle_repository.dart';

import '../helpers/helpers.dart';

class _MockFavorites extends Mock implements FavoritesRepository {}

void main() {
  late MockStack stack;
  late VehicleSummary car;
  setUp(() async {
    stack = MockStack();
    await stack.signInAe();
    car = (await stack.vehicles.search(
      const VehicleQuery(countryCode: 'AE'),
    )).items.firstWhere((v) => v.id == MockStack.aeEconomyId);
  });

  blocTest<FavoritesBloc, FavoritesState>(
    'loads saved cars and toggles them on and off',
    build: () => FavoritesBloc(stack.favorites),
    act: (b) async {
      b.add(const FavoritesLoaded());
      await Future<void>.delayed(Duration.zero);
      b.add(FavoriteToggled(car));
      await Future<void>.delayed(Duration.zero);
    },
    verify: (b) async {
      expect(b.state.contains(car.id), isTrue);
      expect((await stack.favorites.list()).map((v) => v.id), contains(car.id));
    },
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'a failed toggle is rolled back and reported',
    build: () {
      final repo = _MockFavorites();
      when(() => repo.add(any())).thenThrow(const ApiFailure.network());
      return FavoritesBloc(repo);
    },
    seed: () => const FavoritesState(status: LoadStatus.empty),
    act: (b) => b.add(FavoriteToggled(car)),
    expect: () => [
      isA<FavoritesState>().having((s) => s.contains(car.id), 'saved', isTrue),
      isA<FavoritesState>()
          .having((s) => s.contains(car.id), 'saved', isFalse)
          .having((s) => s.toggleFailure, 'failure', isNotNull),
    ],
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'empty list → empty state',
    build: () {
      final repo = _MockFavorites();
      when(repo.list).thenAnswer((_) async => []);
      return FavoritesBloc(repo);
    },
    act: (b) => b.add(const FavoritesLoaded()),
    expect: () => [
      isA<FavoritesState>().having((s) => s.status, 's', LoadStatus.loading),
      isA<FavoritesState>().having((s) => s.status, 's', LoadStatus.empty),
    ],
  );
}
