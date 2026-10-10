import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';
import '../../shared/models/vehicle.dart';
import '../localization/l10n.dart';
import 'status_badge.dart';
import 'vehicle_photo.dart';

/// The minimal vehicle card: large image, make/model, one muted line of key
/// specs, price on the right with the trip total as secondary text, and an
/// optional "Delivery" pill. Nothing else.
class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
    this.width,
  });

  final VehicleSummary vehicle;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final specs = [
      l10n.transmission(vehicle.transmission),
      l10n.seatsCount(vehicle.seats),
      l10n.fuel(vehicle.fuelType),
    ].join(' · ');
    final daily = '${vehicle.dailyRate.formatCompact()} ${l10n.perDay}';
    final total = vehicle.estimatedTotal;
    final semantics = [
      '${vehicle.title} ${vehicle.year}',
      specs,
      daily,
      if (total != null && vehicle.days != null)
        l10n.priceTotalForDays(total.format(), vehicle.days!),
      if (vehicle.deliveryAvailable) l10n.deliveryPill,
    ].join(', ');

    return SizedBox(
      width: width,
      child: Semantics(
        button: true,
        label: semantics,
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: RoveRadius.cardAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              VehiclePhoto(
                url: vehicle.coverImageUrl,
                semanticLabel: l10n.vehicleImageLabel(vehicle.title),
              ),
              const SizedBox(height: RoveSpacing.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.title,
                          style: text.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          specs,
                          style: text.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: RoveSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(daily, style: text.titleSmall),
                      if (total != null && vehicle.days != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          l10n.priceTotalForDays(
                            total.formatCompact(),
                            vehicle.days!,
                          ),
                          style: text.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              if (vehicle.deliveryAvailable) ...[
                const SizedBox(height: RoveSpacing.xs),
                StatusPill(label: l10n.deliveryPill),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
