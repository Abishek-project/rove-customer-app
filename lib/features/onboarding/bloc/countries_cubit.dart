import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/load_status.dart';
import '../../../shared/models/reference.dart';
import '../../../shared/repositories/reference_repository.dart';

/// Country configuration from `GET /countries`: currency, tax, cities and
/// payment methods. Never hardcoded in the app.
class CountriesState extends Equatable {
  const CountriesState({
    this.status = LoadStatus.initial,
    this.countries = const [],
    this.failure,
  });

  final LoadStatus status;
  final List<Country> countries;
  final ApiFailure? failure;

  Country? byCode(String? code) {
    for (final c in countries) {
      if (c.code == code) return c;
    }
    return null;
  }

  /// The city with [cityId] in any country.
  City? cityById(String? cityId) {
    for (final c in countries) {
      final city = c.cityById(cityId);
      if (city != null) return city;
    }
    return null;
  }

  @override
  List<Object?> get props => [status, countries, failure];
}

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit(this._repository) : super(const CountriesState());

  final ReferenceRepository _repository;

  Future<void> load({bool force = false}) async {
    if (state.status == LoadStatus.loading) return;
    if (!force && state.status == LoadStatus.success) return;
    emit(
      CountriesState(status: LoadStatus.loading, countries: state.countries),
    );
    try {
      final countries = await _repository.getCountries();
      emit(CountriesState(status: LoadStatus.success, countries: countries));
    } on ApiFailure catch (f) {
      emit(
        CountriesState(
          status: LoadStatus.failure,
          countries: state.countries,
          failure: f,
        ),
      );
    }
  }
}
