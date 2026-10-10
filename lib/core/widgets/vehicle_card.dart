import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';
import '../../shared/models/enums.dart';
import '../../shared/models/vehicle.dart';
import '../localization/l10n.dart';
import 'vehicle_photo.dart';

String vehiclePhotoHeroTag(String vehicleId) => 'vehicle-photo-$vehicleId';

IconData fuelIcon(FuelType fuel) => fuel == FuelType.electric
    ? Icons.bolt_outlined
    : Icons.local_gas_station_outlined;

/// Small icon + text pairs: `⚙ Automatic · 👤 5 seats · ⛽ Petrol`, drawn
/// with outline icons (no emoji).
class SpecRow extends StatelessWidget {
  const SpecRow({super.key, required this.vehicle});

  final VehicleSummary vehicle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final style = Theme.of(context).textTheme.bodySmall;
    InlineSpan icon(IconData data) => WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 4),
        child: Icon(data, size: 15, color: c.textSecondary),
      ),
    );
    const gap = TextSpan(text: '   ');
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          icon(Icons.settings_outlined),
          TextSpan(text: l10n.transmission(vehicle.transmission)),
          gap,
          icon(Icons.person_outline_rounded),
          TextSpan(text: l10n.seatsCount(vehicle.seats)),
          gap,
          icon(fuelIcon(vehicle.fuelType)),
          TextSpan(text: l10n.fuel(vehicle.fuelType)),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// The v2 vehicle card: a `surface` card (radius 20) with the car photo on
/// top, an optional heart in the top-right, title, an icon spec row and the
/// daily price in bold on the right.
class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
    this.width,
    this.favorite,
    this.hero = false,
  });

  final VehicleSummary vehicle;
  final VoidCallback onTap;
  final double? width;

  /// Usually a FavoriteButton; kept injectable so the card stays pure.
  final Widget? favorite;

  /// Animate the photo into vehicle details. Only for lists where each car
  /// appears once (Hero tags must be unique per route).
  final bool hero;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    final daily = '${vehicle.dailyRate.formatCompact()}${l10n.perDay}';
    final total = vehicle.estimatedTotal;
    final photo = VehiclePhoto(
      url: vehicle.coverImageUrl,
      semanticLabel: l10n.vehicleImageLabel(vehicle.title),
      radius: 0,
    );
    final semantics = [
      '${vehicle.title} ${vehicle.year}',
      l10n.transmission(vehicle.transmission),
      l10n.seatsCount(vehicle.seats),
      l10n.fuel(vehicle.fuelType),
      daily,
      if (total != null && vehicle.days != null)
        l10n.priceTotalForDays(total.format(), vehicle.days!),
    ].join(', ');

    return SizedBox(
      width: width,
      child: Material(
        color: c.surface,
        borderRadius: RoveRadius.cardAll,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Semantics(
                    button: true,
                    label: semantics,
                    excludeSemantics: true,
                    child: hero
                        ? Hero(
                            tag: vehiclePhotoHeroTag(vehicle.id),
                            child: photo,
                          )
                        : photo,
                  ),
                  if (favorite != null)
                    PositionedDirectional(top: 12, end: 12, child: favorite!),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${vehicle.title} ${vehicle.year}',
                            style: text.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: RoveSpacing.sm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              daily,
                              style: text.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (total != null && vehicle.days != null)
                              Text(
                                l10n.priceTotalForDays(
                                  total.formatCompact(),
                                  vehicle.days!,
                                ),
                                style: text.bodySmall,
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SpecRow(vehicle: vehicle),
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
