import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/icon_circle.dart';
import '../../../shared/models/vehicle.dart';
import '../bloc/favorites_bloc.dart';

/// Heart in a circle; filled accent when saved. Optimistic via FavoritesBloc.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.vehicle, this.size = 40});

  final VehicleSummary vehicle;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (a, b) =>
          a.contains(vehicle.id) != b.contains(vehicle.id) ||
          a.status != b.status,
      builder: (context, favorites) {
        final saved = favorites.status == LoadStatus.initial
            ? vehicle.isFavorite
            : favorites.contains(vehicle.id);
        return IconCircle(
          key: ValueKey('favorite-${vehicle.id}'),
          size: size,
          tooltip: saved ? l10n.unsaveVehicle : l10n.saveVehicle,
          icon: saved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: saved ? c.primary : c.textPrimary,
          background: c.background.withValues(alpha: 0.72),
          onPressed: () =>
              context.read<FavoritesBloc>().add(FavoriteToggled(vehicle)),
        );
      },
    );
  }
}
