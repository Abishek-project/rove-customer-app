import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/utils/load_status.dart';
import 'package:rove_customer_app/features/home/bloc/home_cubit.dart';
import 'package:rove_customer_app/shared/models/enums.dart';

import '../helpers/helpers.dart';

void main() {
  late MockStack stack;
  setUp(() async {
    stack = MockStack();
    await stack.signInAe();
  });

  blocTest<HomeCubit, HomeState>(
    'loads featured cars for the city',
    build: () => HomeCubit(stack.vehicles),
    act: (c) => c.load(countryCode: 'AE', cityId: MockStack.dubai),
    verify: (c) {
      expect(c.state.status, LoadStatus.success);
      expect(c.state.category, isNull);
      expect(c.state.featured, isNotEmpty);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'a category tile filters the list; tapping it again clears it',
    build: () => HomeCubit(stack.vehicles),
    act: (c) async {
      await c.load(countryCode: 'AE', cityId: MockStack.dubai);
      await c.toggleCategory(VehicleCategory.luxury);
      expect(c.state.category, VehicleCategory.luxury);
      expect(
        c.state.featured.every((v) => v.category == VehicleCategory.luxury),
        isTrue,
      );
      await c.toggleCategory(VehicleCategory.luxury);
    },
    verify: (c) {
      expect(c.state.category, isNull);
      expect(c.state.status, LoadStatus.success);
    },
  );
}
