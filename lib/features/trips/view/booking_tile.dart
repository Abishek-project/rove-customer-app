import 'package:flutter/material.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/vehicle_photo.dart';
import '../../../shared/models/booking.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({super.key, required this.booking, required this.onTap});

  final BookingSummary booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final locale = context.localeTag;
    final dates =
        '${ZonedTime.formatShortDate(booking.pickupAt, booking.timezone, locale: locale)} → '
        '${ZonedTime.formatShortDate(booking.returnAt, booking.timezone, locale: locale)}';
    return Semantics(
      button: true,
      label: [
        booking.vehicle.title,
        dates,
        l10n.bookingStatus(booking.status),
        booking.total.format(),
        booking.reference,
      ].join(', '),
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: RoveRadius.cardAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: RoveSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 88,
                child: VehiclePhoto(
                  url: booking.vehicle.coverImageUrl,
                  semanticLabel: booking.vehicle.title,
                  radius: RoveRadius.small,
                  memCacheWidth: 300,
                ),
              ),
              const SizedBox(width: RoveSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.vehicle.title, style: text.titleSmall),
                    const SizedBox(height: 2),
                    Text(dates, style: text.bodySmall),
                    Text(
                      '${booking.city.name} · ${booking.reference}',
                      style: text.bodySmall,
                    ),
                    const SizedBox(height: RoveSpacing.xs),
                    Row(
                      children: [
                        BookingStatusBadge(status: booking.status),
                        const Spacer(),
                        Text(booking.total.format(), style: text.labelMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
