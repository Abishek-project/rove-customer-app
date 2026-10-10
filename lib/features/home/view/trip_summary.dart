import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../search/bloc/trip_cubit.dart';

/// "Mon, 2 Nov 10:00 → Thu, 5 Nov 10:00", in the city's time zone.
String tripDatesLabel(BuildContext context, TripState trip) {
  if (!trip.hasDates) return context.l10n.periodMissing;
  final locale = context.localeTag;
  final from = ZonedTime.formatDateTime(
    trip.pickupAt!,
    trip.timezone,
    locale: locale,
  );
  final to = ZonedTime.formatDateTime(
    trip.returnAt!,
    trip.timezone,
    locale: locale,
  );
  return '$from → $to';
}

/// `11 Oct · 10:00` for compact date fields.
String compactDateTime(BuildContext context, DateTime utc, String? timezone) {
  final local = ZonedTime.inZone(utc, timezone);
  return DateFormat('d MMM · HH:mm', context.localeTag).format(local);
}
