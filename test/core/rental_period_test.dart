import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/utils/rental_period.dart';

void main() {
  final now = DateTime.utc(2026, 10, 10, 8);
  RentalPeriodError? check(DateTime? p, DateTime? r) =>
      RentalPeriod.validatePeriod(pickupAt: p, returnAt: r, now: now);

  group('date-range validation (CONTRACTS §7)', () {
    final pickup = now.add(const Duration(days: 1));

    test('accepts a valid period', () {
      expect(check(pickup, pickup.add(const Duration(days: 3))), isNull);
    });

    test('requires both dates', () {
      expect(check(null, pickup), RentalPeriodError.missing);
      expect(check(pickup, null), RentalPeriodError.missing);
    });

    test('pickup must be at least 2 hours ahead', () {
      final soon = now.add(const Duration(hours: 1, minutes: 59));
      expect(
        check(soon, soon.add(const Duration(days: 1))),
        RentalPeriodError.pickupTooSoon,
      );
      final ok = now.add(const Duration(hours: 2));
      expect(check(ok, ok.add(const Duration(days: 1))), isNull);
    });

    test('return must be after pickup', () {
      expect(check(pickup, pickup), RentalPeriodError.returnBeforePickup);
      expect(
        check(pickup, pickup.subtract(const Duration(hours: 1))),
        RentalPeriodError.returnBeforePickup,
      );
    });

    test('at least 24 hours and at most 30 days', () {
      expect(
        check(pickup, pickup.add(const Duration(hours: 23))),
        RentalPeriodError.tooShort,
      );
      expect(check(pickup, pickup.add(const Duration(days: 30))), isNull);
      expect(
        check(pickup, pickup.add(const Duration(days: 30, minutes: 1))),
        RentalPeriodError.tooLong,
      );
    });

    test('pickup within 180 days', () {
      final far = now.add(const Duration(days: 181));
      expect(
        check(far, far.add(const Duration(days: 2))),
        RentalPeriodError.tooFarAhead,
      );
    });
  });

  test('billable days round up partial days', () {
    final p = DateTime.utc(2026, 11, 1, 6);
    expect(
      RentalPeriod(
        pickupAt: p,
        returnAt: p.add(const Duration(days: 3)),
      ).billableDays,
      3,
    );
    expect(
      RentalPeriod(
        pickupAt: p,
        returnAt: p.add(const Duration(days: 3, hours: 1)),
      ).billableDays,
      4,
    );
  });

  test('default range is tomorrow 10:00 for three days', () {
    final r = RentalPeriod.defaultLocalRange(DateTime(2026, 10, 10, 22, 15));
    expect(r.pickupLocal, DateTime(2026, 10, 11, 10));
    expect(r.returnLocal, DateTime(2026, 10, 14, 10));
  });
}
