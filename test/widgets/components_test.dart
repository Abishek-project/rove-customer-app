import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/errors/api_failure.dart';
import 'package:rove_customer_app/core/money/money.dart';
import 'package:rove_customer_app/core/widgets/price_breakdown.dart';
import 'package:rove_customer_app/core/widgets/skeleton.dart';
import 'package:rove_customer_app/core/widgets/state_views.dart';
import 'package:rove_customer_app/core/widgets/status_badge.dart';
import 'package:rove_customer_app/core/widgets/vehicle_card.dart';
import 'package:rove_customer_app/shared/models/enums.dart';
import 'package:rove_customer_app/shared/models/pricing.dart';
import 'package:rove_customer_app/shared/repositories/vehicle_repository.dart';

import '../helpers/helpers.dart';

void main() {
  group('PriceBreakdown', () {
    testWidgets(
      'lists backend line items, total, and keeps the deposit apart',
      (tester) async {
        await pumpLocalized(
          tester,
          const Scaffold(
            body: PriceBreakdown(
              lineItems: [
                LineItem(
                  code: 'rental_fee',
                  label: 'Rental (3 days × AED 250.00)',
                  amount: Money(75000, 'AED'),
                ),
                LineItem(
                  code: 'discount',
                  label: 'Weekly discount',
                  amount: Money(-5000, 'AED'),
                ),
                LineItem(
                  code: 'platform_fee',
                  label: 'Service fee',
                  amount: Money(3500, 'AED'),
                ),
                LineItem(
                  code: 'tax',
                  label: 'VAT (5%)',
                  amount: Money(3675, 'AED'),
                ),
              ],
              total: Money(77175, 'AED'),
              deposit: Money(100000, 'AED'),
              depositNote: 'Held at pickup, not charged now',
              conditionalCharges: [
                ConditionalCharge(
                  code: 'excess_mileage',
                  label: 'Extra km beyond 250 km/day',
                  amount: Money(100, 'AED'),
                  unit: 'per_km',
                ),
              ],
            ),
          ),
        );
        expect(find.text('Rental (3 days × AED 250.00)'), findsOneWidget);
        expect(find.text('AED 750.00'), findsOneWidget);
        expect(find.text('-AED 50.00'), findsOneWidget);
        expect(find.text('Total'), findsOneWidget);
        expect(find.text('AED 771.75'), findsOneWidget);
        expect(find.text('Refundable deposit'), findsOneWidget);
        expect(find.text('AED 1,000.00'), findsOneWidget);
        expect(find.text('Possible extra charges'), findsOneWidget);
        expect(find.text('AED 1.00 per km'), findsOneWidget);
        // The deposit is listed after the total, not inside it.
        final totalY = tester.getTopLeft(find.text('Total')).dy;
        final depositY = tester.getTopLeft(find.text('Refundable deposit')).dy;
        expect(depositY, greaterThan(totalY));
      },
    );

    testWidgets('formats INR with lakh grouping', (tester) async {
      await pumpLocalized(
        tester,
        const Scaffold(
          body: PriceBreakdown(
            lineItems: [
              LineItem(
                code: 'rental_fee',
                label: 'Rental',
                amount: Money(12500000, 'INR'),
              ),
            ],
            total: Money(15487500, 'INR'),
          ),
        ),
      );
      expect(find.text('₹1,25,000.00'), findsOneWidget);
      expect(find.text('₹1,54,875.00'), findsOneWidget);
    });
  });

  group('booking state display', () {
    testWidgets('every status has a quiet, distinct label', (tester) async {
      await pumpLocalized(
        tester,
        Scaffold(
          body: Column(
            children: [
              for (final s in BookingStatus.values)
                BookingStatusBadge(status: s),
            ],
          ),
        ),
      );
      for (final label in [
        'Awaiting payment',
        'Awaiting confirmation',
        'Confirmed',
        'In progress',
        'Completed',
        'Declined',
        'Cancelled',
        'Expired',
        'Updating',
      ]) {
        expect(find.text(label), findsOneWidget, reason: label);
      }
      expect(bookingStatusTone(BookingStatus.confirmed), PillTone.success);
      expect(bookingStatusTone(BookingStatus.held), PillTone.warning);
      expect(bookingStatusTone(BookingStatus.pendingPartner), PillTone.info);
    });
  });

  group('empty, loading and error states', () {
    testWidgets('empty state shows one line and one action', (tester) async {
      var tapped = false;
      await pumpLocalized(
        tester,
        Scaffold(
          body: EmptyState(
            message: 'No cars available for these dates.',
            actionLabel: 'Change search',
            onAction: () => tapped = true,
          ),
        ),
      );
      expect(find.text('No cars available for these dates.'), findsOneWidget);
      await tester.tap(find.text('Change search'));
      expect(tapped, isTrue);
    });

    testWidgets('error state shows a safe message and retries', (tester) async {
      var retried = 0;
      await pumpLocalized(
        tester,
        Scaffold(
          body: ErrorState(
            failure: const ApiFailure(
              code: 'INTERNAL_ERROR',
              statusCode: 500,
              message: 'TypeError at line 42',
            ),
            onRetry: () => retried++,
          ),
        ),
      );
      expect(find.textContaining('TypeError'), findsNothing);
      expect(
        find.text(
          'Something went wrong on our side. Please try again shortly.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Try again'));
      expect(retried, 1);
    });

    testWidgets('network errors say so', (tester) async {
      await pumpLocalized(
        tester,
        const Scaffold(body: ErrorState(failure: ApiFailure.network())),
      );
      expect(find.textContaining("You're offline"), findsOneWidget);
    });

    testWidgets('skeletons render while loading', (tester) async {
      await pumpLocalized(
        tester,
        const Scaffold(
          body: Column(
            children: [VehicleCardSkeleton(), ListSkeleton(rows: 2)],
          ),
        ),
      );
      expect(find.byType(Skeleton), findsWidgets);
    });
  });

  testWidgets('vehicle card shows title, icon specs, daily price and total', (
    tester,
  ) async {
    setUpTimeZones();
    final stack = MockStack();
    await stack.signInAe();
    final p = testPeriod();
    final v = (await stack.vehicles.search(
      VehicleQuery(
        countryCode: 'AE',
        pickupAt: p.pickupAt,
        returnAt: p.returnAt,
      ),
    )).items.firstWhere((v) => v.id == MockStack.aeEconomyId);
    await pumpLocalized(
      tester,
      Scaffold(
        body: VehicleCard(vehicle: v, onTap: () {}),
      ),
    );
    expect(find.text('MINI John Cooper Works 2023'), findsOneWidget);
    for (final spec in ['Automatic', '4 seats', 'Petrol']) {
      expect(find.textContaining(spec, findRichText: true), findsOneWidget);
    }
    expect(find.text('AED 280/day'), findsOneWidget);
    expect(find.textContaining('total · 3 days'), findsOneWidget);
  });
}
