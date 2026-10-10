import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/grouped_list.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vehicle_card.dart';
import '../bloc/favorites_bloc.dart';
import 'favorite_button.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LargeTitle(l10n.savedTitle),
            Expanded(child: _list(context)),
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final bloc = context.read<FavoritesBloc>();
        switch (state.status) {
          case LoadStatus.initial:
          case LoadStatus.loading when state.vehicles.isEmpty:
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: const [VehicleCardSkeleton()],
            );
          case LoadStatus.failure when state.vehicles.isEmpty:
            return ErrorState(
              failure: state.failure!,
              onRetry: () => bloc.add(const FavoritesLoaded()),
            );
          case LoadStatus.empty:
            return EmptyState(
              icon: Icons.favorite_border_rounded,
              message: l10n.savedEmpty,
              actionLabel: l10n.browseCars,
              onAction: () => context.go(Routes.explore),
            );
          default:
            return RefreshIndicator(
              onRefresh: () async => bloc.add(const FavoritesLoaded()),
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount: state.vehicles.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: RoveSpacing.lg),
                itemBuilder: (context, i) {
                  final vehicle = state.vehicles[i];
                  return Dismissible(
                    key: ValueKey('saved-${vehicle.id}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      padding: const EdgeInsetsDirectional.only(end: 24),
                      decoration: BoxDecoration(
                        color: context.colors.dangerTint,
                        borderRadius: RoveRadius.cardAll,
                      ),
                      child: Text(
                        l10n.unsaveVehicle,
                        style: TextStyle(color: context.colors.danger),
                      ),
                    ),
                    onDismissed: (_) {
                      bloc.add(FavoriteToggled(vehicle));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.savedRemoved),
                          action: SnackBarAction(
                            label: l10n.undo,
                            onPressed: () => bloc.add(FavoriteToggled(vehicle)),
                          ),
                        ),
                      );
                    },
                    child: VehicleCard(
                      vehicle: vehicle,
                      favorite: FavoriteButton(vehicle: vehicle),
                      hero: true,
                      onTap: () => context.push(Routes.vehicle(vehicle.id)),
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }
}
