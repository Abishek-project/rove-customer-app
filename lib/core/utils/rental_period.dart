import 'package:equatable/equatable.dart';

/// Reasons a rental period is invalid. The rules mirror the backend
/// (CONTRACTS §7) so customers get feedback before a request is sent; the
/// backend remains the authority.
enum RentalPeriodError {
  missing,
  pickupTooSoon,
  returnBeforePickup,
  tooShort,
  tooLong,
  tooFarAhead,
}

class RentalPeriod extends Equatable {
  const RentalPeriod({required this.pickupAt, required this.returnAt});

  /// UTC instants.
  final DateTime pickupAt;
  final DateTime returnAt;

  static const minLeadTime = Duration(hours: 2);
  static const minDuration = Duration(hours: 24);
  static const maxDuration = Duration(days: 30);
  static const maxAdvance = Duration(days: 180);

  Duration get duration => returnAt.difference(pickupAt);

  /// Billable days: whole 24 h blocks, rounded up (backend formula).
  int get billableDays {
    final minutes = duration.inMinutes;
    const day = 24 * 60;
    return minutes <= 0 ? 0 : (minutes + day - 1) ~/ day;
  }

  /// Validates against the shared rules, using [now] (UTC) as the clock.
  RentalPeriodError? validate(DateTime now) =>
      validatePeriod(pickupAt: pickupAt, returnAt: returnAt, now: now);

  static RentalPeriodError? validatePeriod({
    required DateTime? pickupAt,
    required DateTime? returnAt,
    required DateTime now,
  }) {
    if (pickupAt == null || returnAt == null) return RentalPeriodError.missing;
    if (pickupAt.isBefore(now.add(minLeadTime))) {
      return RentalPeriodError.pickupTooSoon;
    }
    if (pickupAt.isAfter(now.add(maxAdvance))) {
      return RentalPeriodError.tooFarAhead;
    }
    if (!returnAt.isAfter(pickupAt)) {
      return RentalPeriodError.returnBeforePickup;
    }
    final length = returnAt.difference(pickupAt);
    if (length < minDuration) return RentalPeriodError.tooShort;
    if (length > maxDuration) return RentalPeriodError.tooLong;
    return null;
  }

  /// A sensible default: pickup tomorrow at 10:00 local, three days.
  /// [localNow] is the wall-clock time in the city's zone.
  static ({DateTime pickupLocal, DateTime returnLocal}) defaultLocalRange(
    DateTime localNow,
  ) {
    final tomorrow = DateTime(
      localNow.year,
      localNow.month,
      localNow.day + 1,
      10,
    );
    return (
      pickupLocal: tomorrow,
      returnLocal: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day + 3,
        10,
      ),
    );
  }

  @override
  List<Object?> get props => [pickupAt, returnAt];
}
