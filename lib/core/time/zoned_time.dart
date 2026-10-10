import 'package:intl/intl.dart';
import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Converts between UTC instants (what the API speaks) and wall-clock times
/// in a vehicle's or city's IANA time zone (what customers read).
class ZonedTime {
  const ZonedTime._();

  static bool _initialized = false;

  static void ensureInitialized() {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    _initialized = true;
  }

  static tz.Location location(String? timezone) {
    ensureInitialized();
    if (timezone == null || timezone.isEmpty) return tz.UTC;
    try {
      return tz.getLocation(timezone);
    } on tz.LocationNotFoundException {
      return tz.UTC;
    }
  }

  /// The wall-clock time of [utc] in [timezone].
  static tz.TZDateTime inZone(DateTime utc, String? timezone) =>
      tz.TZDateTime.from(utc.toUtc(), location(timezone));

  /// The UTC instant for a wall-clock time in [timezone].
  static DateTime toUtc({
    required int year,
    required int month,
    required int day,
    int hour = 0,
    int minute = 0,
    required String? timezone,
  }) =>
      tz.TZDateTime(location(timezone), year, month, day, hour, minute).toUtc();

  /// Now, as a wall-clock time in [timezone].
  static tz.TZDateTime now(String? timezone, {DateTime? clock}) =>
      inZone(clock ?? DateTime.now().toUtc(), timezone);

  /// `Mon, 2 Nov · 10:00`
  static String formatDateTime(
    DateTime utc,
    String? timezone, {
    String? locale,
  }) {
    final local = inZone(utc, timezone);
    return '${DateFormat('EEE, d MMM', locale).format(local)} · '
        '${DateFormat('HH:mm', locale).format(local)}';
  }

  /// `2 Nov 2026`
  static String formatDate(DateTime utc, String? timezone, {String? locale}) =>
      DateFormat('d MMM y', locale).format(inZone(utc, timezone));

  /// `Mon, 2 Nov`
  static String formatShortDate(
    DateTime utc,
    String? timezone, {
    String? locale,
  }) => DateFormat('EEE, d MMM', locale).format(inZone(utc, timezone));

  /// `10:00`
  static String formatTime(DateTime utc, String? timezone, {String? locale}) =>
      DateFormat('HH:mm', locale).format(inZone(utc, timezone));

  /// Short zone abbreviation for disambiguation, e.g. `GST` / `IST`.
  static String zoneAbbreviation(DateTime utc, String? timezone) =>
      inZone(utc, timezone).timeZoneName;

  /// ISO-8601 UTC with milliseconds, as the API expects.
  static String toIso(DateTime value) => value.toUtc().toIso8601String();
}
