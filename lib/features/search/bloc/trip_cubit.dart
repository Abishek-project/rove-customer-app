import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/time/zoned_time.dart';
import '../../../core/utils/rental_period.dart';
import '../../../shared/models/reference.dart';

/// The trip being planned: where and when. Shared by home, search, vehicle
/// details and checkout so the dates follow the customer through the flow.
class TripState extends Equatable {
  const TripState({this.countryCode, this.city, this.pickupAt, this.returnAt});

  final String? countryCode;
  final City? city;

  /// UTC instants.
  final DateTime? pickupAt;
  final DateTime? returnAt;

  String? get timezone => city?.timezone;
  bool get hasDates => pickupAt != null && returnAt != null;

  RentalPeriod? get period =>
      hasDates ? RentalPeriod(pickupAt: pickupAt!, returnAt: returnAt!) : null;

  RentalPeriodError? validate(DateTime nowUtc) => RentalPeriod.validatePeriod(
    pickupAt: pickupAt,
    returnAt: returnAt,
    now: nowUtc,
  );

  TripState copyWith({
    String? Function()? countryCode,
    City? Function()? city,
    DateTime? Function()? pickupAt,
    DateTime? Function()? returnAt,
  }) => TripState(
    countryCode: countryCode != null ? countryCode() : this.countryCode,
    city: city != null ? city() : this.city,
    pickupAt: pickupAt != null ? pickupAt() : this.pickupAt,
    returnAt: returnAt != null ? returnAt() : this.returnAt,
  );

  @override
  List<Object?> get props => [countryCode, city, pickupAt, returnAt];
}

class TripCubit extends Cubit<TripState> {
  TripCubit({DateTime Function()? clock})
    : _clock = clock ?? (() => DateTime.now().toUtc()),
      super(const TripState());

  final DateTime Function() _clock;

  DateTime get now => _clock();

  /// Switching country resets the city; dates are kept but re-anchored to
  /// the new city's time zone by the default when missing.
  void setCountry(String countryCode, {City? city}) {
    if (countryCode == state.countryCode && city == state.city) return;
    final previousZone = state.timezone;
    emit(state.copyWith(countryCode: () => countryCode, city: () => city));
    _keepWallClock(previousZone);
    _ensureDates();
  }

  void setCity(City? city) {
    final previousZone = state.timezone;
    emit(
      state.copyWith(
        city: () => city,
        countryCode: () => city?.countryCode ?? state.countryCode,
      ),
    );
    _keepWallClock(previousZone);
    _ensureDates();
  }

  /// Moving to a city in another time zone keeps the chosen wall-clock
  /// times (10:00 stays 10:00 local) rather than the same instants.
  void _keepWallClock(String? previousZone) {
    final zone = state.timezone;
    if (previousZone == null || zone == null || previousZone == zone) return;
    DateTime? move(DateTime? utc) {
      if (utc == null) return null;
      final local = ZonedTime.inZone(utc, previousZone);
      return ZonedTime.toUtc(
        year: local.year,
        month: local.month,
        day: local.day,
        hour: local.hour,
        minute: local.minute,
        timezone: zone,
      );
    }

    emit(
      state.copyWith(
        pickupAt: () => move(state.pickupAt),
        returnAt: () => move(state.returnAt),
      ),
    );
  }

  void setDates({required DateTime pickupAt, required DateTime returnAt}) {
    emit(
      state.copyWith(
        pickupAt: () => pickupAt.toUtc(),
        returnAt: () => returnAt.toUtc(),
      ),
    );
  }

  /// Default to tomorrow 10:00 → +3 days, in the city's time zone, and
  /// replace dates that have drifted into the past.
  void _ensureDates() {
    final pickup = state.pickupAt;
    if (pickup != null && !pickup.isBefore(now.add(RentalPeriod.minLeadTime))) {
      return;
    }
    final localNow = ZonedTime.now(state.timezone, clock: now);
    final range = RentalPeriod.defaultLocalRange(localNow);
    DateTime toUtc(DateTime local) => ZonedTime.toUtc(
      year: local.year,
      month: local.month,
      day: local.day,
      hour: local.hour,
      minute: local.minute,
      timezone: state.timezone,
    );
    emit(
      state.copyWith(
        pickupAt: () => toUtc(range.pickupLocal),
        returnAt: () => toUtc(range.returnLocal),
      ),
    );
  }

  void ensureDates() => _ensureDates();
}
