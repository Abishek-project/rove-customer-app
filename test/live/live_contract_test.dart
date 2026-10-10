// Opt-in check of the live backend against the app's parsers. Skipped
// unless LIVE_API_TOKEN is set. Creates (then cancels) a booking.
//
//   LIVE_API_TOKEN=<supabase access token> flutter test test/live
@Tags(['live'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rove_customer_app/core/auth/session_token_source.dart';
import 'package:rove_customer_app/core/network/api_client.dart';
import 'package:rove_customer_app/shared/data/api/api_repositories.dart';
import 'package:rove_customer_app/shared/models/enums.dart';
import 'package:rove_customer_app/shared/repositories/booking_repository.dart';
import 'package:rove_customer_app/shared/repositories/payment_repository.dart';
import 'package:rove_customer_app/shared/repositories/vehicle_repository.dart';
import 'package:uuid/uuid.dart';

class _StaticToken implements SessionTokenSource {
  _StaticToken(this.accessToken);
  @override
  final String? accessToken;
  @override
  Future<String?> refreshAccessToken() async => null;
  @override
  Future<void> handleSessionExpired() async {}
}

void main() {
  final token = Platform.environment['LIVE_API_TOKEN'];
  final base = Platform.environment['LIVE_API_URL'] ?? 'http://127.0.0.1:4000';
  final skip = token == null ? 'LIVE_API_TOKEN not set' : null;

  test(
    'customer endpoints parse and the booking journey works',
    () async {
      final api = ApiClient(
        baseUrl: '$base/api/v1',
        tokens: _StaticToken(token),
      );
      final reference = ApiReferenceRepository(api);
      final vehicles = ApiVehicleRepository(api);
      final bookings = ApiBookingRepository(api);
      final payments = ApiPaymentRepository(api);
      final profile = ApiProfileRepository(api);
      final favorites = ApiFavoritesRepository(api);
      final support = ApiSupportRepository(api);

      final me = await profile.getMe();
      final countryCode = me.profile.countryCode!;
      final countries = await reference.getCountries();
      final country = countries.firstWhere((c) => c.code == countryCode);
      await reference.getLocations(countryCode: countryCode);
      await profile.getVerification();
      await support.list();
      await favorites.list();
      for (final g in BookingGroup.values) {
        final page = await bookings.list(g);
        for (final b in page.items.take(1)) {
          await bookings.get(b.id);
        }
      }

      final now = DateTime.now().toUtc();
      final pickup = DateTime.utc(now.year, now.month, now.day + 40, 6);
      final ret = pickup.add(const Duration(days: 3));
      final results = await vehicles.search(
        VehicleQuery(
          countryCode: countryCode,
          cityId: me.profile.cityId,
          pickupAt: pickup,
          returnAt: ret,
          sort: VehicleSort.priceAsc,
        ),
      );
      expect(results.items, isNotEmpty);
      final v = results.items.first;
      expect(v.dailyRate.currency, country.currency);
      final detail = await vehicles.getVehicle(
        v.id,
        pickupAt: pickup,
        returnAt: ret,
      );
      expect(detail.availability.available, isTrue);

      await favorites.add(v.id);
      await favorites.remove(v.id);

      final quote = await bookings.quote(
        QuoteRequest(vehicleId: v.id, pickupAt: pickup, returnAt: ret),
      );
      final created = await bookings.create(
        quoteId: quote.id,
        driver: DriverDetails(
          fullName: me.profile.fullName!,
          phone: me.profile.phone!,
          dateOfBirth: DateTime(1990, 1, 1),
        ),
        idempotencyKey: const Uuid().v4(),
      );
      expect(created.booking.status, BookingStatus.held);
      final paid = await payments.confirm(
        bookingId: created.booking.id,
        intentId: created.payment.intentId,
        idempotencyKey: const Uuid().v4(),
      );
      expect(
        paid.status,
        anyOf(BookingStatus.confirmed, BookingStatus.pendingPartner),
      );
      final preview = await bookings.cancellationPreview(paid.id);
      expect(preview.eligible, isTrue);
      final cancelled = await bookings.cancel(
        paid.id,
        idempotencyKey: const Uuid().v4(),
      );
      expect(cancelled.status, BookingStatus.cancelled);
      // ignore: avoid_print
      print('OK ${country.code}: ${paid.reference} ${paid.status} → cancelled');
    },
    skip: skip,
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    'declined payment returns the held booking',
    () async {
      final api = ApiClient(
        baseUrl: '$base/api/v1',
        tokens: _StaticToken(token),
      );
      final me = await ApiProfileRepository(api).getMe();
      final bookings = ApiBookingRepository(api);
      final now = DateTime.now().toUtc();
      final pickup = DateTime.utc(now.year, now.month, now.day + 50, 6);
      final ret = pickup.add(const Duration(days: 2));
      final results = await ApiVehicleRepository(api).search(
        VehicleQuery(
          countryCode: me.profile.countryCode!,
          pickupAt: pickup,
          returnAt: ret,
        ),
      );
      final quote = await bookings.quote(
        QuoteRequest(
          vehicleId: results.items.last.id,
          pickupAt: pickup,
          returnAt: ret,
        ),
      );
      final created = await bookings.create(
        quoteId: quote.id,
        driver: DriverDetails(
          fullName: me.profile.fullName!,
          phone: me.profile.phone!,
          dateOfBirth: DateTime(1990, 1, 1),
        ),
        idempotencyKey: const Uuid().v4(),
      );
      try {
        await ApiPaymentRepository(api).confirm(
          bookingId: created.booking.id,
          intentId: created.payment.intentId,
          idempotencyKey: const Uuid().v4(),
          simulateOutcome: SimulatedOutcome.fail,
        );
        fail('expected PaymentDeclined');
      } on PaymentDeclined catch (d) {
        expect(d.booking?.status, BookingStatus.held);
        expect(d.booking?.paymentStatus, PaymentStatus.failed);
      }
      final held = await bookings.get(created.booking.id);
      // ignore: avoid_print
      print(
        'held allowedActions=${held.allowedActions} payment=${held.payment}',
      );
      await bookings.cancel(held.id, idempotencyKey: const Uuid().v4());
    },
    skip: skip,
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
