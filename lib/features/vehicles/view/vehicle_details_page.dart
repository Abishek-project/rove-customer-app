import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/price_breakdown.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/vehicle_photo.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../home/view/trip_summary.dart';
import '../../search/bloc/trip_cubit.dart';
import '../bloc/vehicle_details_cubit.dart';

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    final prefs = context.read<PreferencesCubit>();
    return BlocProvider(
      create: (context) {
        final trip = context.read<TripCubit>();
        final valid = trip.state.validate(trip.now) == null;
        return VehicleDetailsCubit(
          context.read<VehicleRepository>(),
          vehicleId,
          onLoaded: (v) => prefs.addRecentlyViewed(v.toSummary()),
        )..load(
          pickupAt: valid ? trip.state.pickupAt : null,
          returnAt: valid ? trip.state.returnAt : null,
        );
      },
      child: const _DetailsView(),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView();

  void _reloadForTrip(BuildContext context, TripState trip) {
    final valid = trip.validate(context.read<TripCubit>().now) == null;
    context.read<VehicleDetailsCubit>().load(
      pickupAt: valid ? trip.pickupAt : null,
      returnAt: valid ? trip.returnAt : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripCubit, TripState>(
      listenWhen: (a, b) =>
          a.pickupAt != b.pickupAt || a.returnAt != b.returnAt,
      listener: _reloadForTrip,
      child: BlocBuilder<VehicleDetailsCubit, VehicleDetailsState>(
        builder: (context, state) {
          final vehicle = state.vehicle;
          if (vehicle == null) {
            return Scaffold(
              appBar: AppBar(),
              body: state.status == LoadStatus.failure
                  ? ErrorState(
                      failure: state.failure!,
                      onRetry: () => _reloadForTrip(
                        context,
                        context.read<TripCubit>().state,
                      ),
                    )
                  : const _DetailsSkeleton(),
            );
          }
          return Scaffold(
            appBar: AppBar(actions: [_SaveButton(vehicle: vehicle)]),
            body: _DetailsBody(vehicle: vehicle, state: state),
            bottomNavigationBar: _BookBar(vehicle: vehicle, state: state),
          );
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.vehicle});

  final VehicleDetail vehicle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listenWhen: (a, b) =>
          b.toggleFailure != null && a.toggleFailure != b.toggleFailure,
      listener: (context, _) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.favoriteFailed))),
      builder: (context, favorites) {
        final saved = favorites.status == LoadStatus.initial
            ? vehicle.isFavorite
            : favorites.contains(vehicle.id);
        return IconButton(
          key: const Key('vehicle-save'),
          tooltip: saved ? l10n.unsaveVehicle : l10n.saveVehicle,
          icon: Icon(
            saved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: saved ? RoveColors.primary : null,
          ),
          onPressed: () => context.read<FavoritesBloc>().add(
            FavoriteToggled(vehicle.toSummary()),
          ),
        );
      },
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({required this.vehicle, required this.state});

  final VehicleDetail vehicle;
  final VehicleDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final mileage = vehicle.mileagePolicy;
    final deliveryText = !vehicle.deliveryAvailable
        ? l10n.detailsNoDelivery
        : vehicle.deliveryFee.isZero
        ? l10n.detailsDeliveryFree
        : l10n.detailsDeliveryFee(vehicle.deliveryFee.format());
    return ListView(
      padding: const EdgeInsets.only(bottom: RoveSpacing.xl),
      children: [
        _Gallery(vehicle: vehicle),
        Padding(
          padding: RoveSpacing.page,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: RoveSpacing.md),
              Text(vehicle.title, style: text.headlineSmall),
              const SizedBox(height: 2),
              MutedText(
                '${vehicle.year} · ${l10n.category(vehicle.category)} · ${vehicle.city.name}',
              ),
              const SizedBox(height: RoveSpacing.md),
              _PartnerRow(partner: vehicle.partner),
              const SizedBox(height: RoveSpacing.xs),
              MutedText(
                vehicle.bookingMode == BookingMode.instant
                    ? l10n.bookingModeInstant
                    : l10n.bookingModeRequest,
                small: true,
              ),
              SectionHeader(title: l10n.detailsSpecs),
              InfoRow(
                label: l10n.filterTransmission,
                value: l10n.transmission(vehicle.transmission),
              ),
              InfoRow(
                label: l10n.filterSeats,
                value: l10n.seatsCount(vehicle.seats),
              ),
              if (vehicle.doors != null)
                InfoRow(label: l10n.specDoors, value: '${vehicle.doors}'),
              InfoRow(
                label: l10n.filterFuel,
                value: l10n.fuel(vehicle.fuelType),
              ),
              InfoRow(
                label: l10n.specLuggage,
                value: l10n.bagsCount(vehicle.luggage),
              ),
              if (vehicle.color != null)
                InfoRow(label: l10n.specColor, value: vehicle.color),
              if (vehicle.minRentalDays > 1)
                InfoRow(
                  label: l10n.specMinRental,
                  value: l10n.daysCount(vehicle.minRentalDays),
                ),
              if (vehicle.description != null &&
                  vehicle.description!.isNotEmpty) ...[
                const SizedBox(height: RoveSpacing.sm),
                MutedText(vehicle.description!),
              ],
              if (vehicle.features.isNotEmpty) ...[
                SectionHeader(title: l10n.detailsFeatures),
                MutedText(vehicle.features.join(' · ')),
              ],
              SectionHeader(title: l10n.detailsPickupDelivery),
              Text(
                vehicle.pickupLocation == null
                    ? l10n.detailsPickupArranged
                    : l10n.detailsPickupAt(vehicle.pickupLocation!.name),
              ),
              if (vehicle.pickupLocation?.address != null)
                MutedText(vehicle.pickupLocation!.address!, small: true),
              const SizedBox(height: RoveSpacing.xs),
              Text(deliveryText),
              SectionHeader(title: l10n.detailsMileage),
              Text(
                mileage.limitKmPerDay == null
                    ? l10n.mileageUnlimited
                    : l10n.mileageLimit(mileage.limitKmPerDay!),
              ),
              if (mileage.limitKmPerDay != null &&
                  !mileage.excessFeePerKm.isZero)
                MutedText(l10n.mileageExcess(mileage.excessFeePerKm.format())),
              SectionHeader(title: l10n.detailsFuelPolicy),
              Text(l10n.fuelPolicy(vehicle.fuelPolicy)),
              SectionHeader(title: l10n.detailsCancellation),
              Text(vehicle.cancellationPolicy.summary),
              SectionHeader(title: l10n.detailsInsurance),
              Text(
                (vehicle.insuranceInfo == null ||
                        vehicle.insuranceInfo!.isEmpty)
                    ? l10n.insuranceMissing
                    : vehicle.insuranceInfo!,
              ),
              _PriceSection(vehicle: vehicle, state: state),
            ],
          ),
        ),
      ],
    );
  }
}

class _Gallery extends StatefulWidget {
  const _Gallery({required this.vehicle});

  final VehicleDetail vehicle;

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final images = widget.vehicle.orderedImages;
    final label = l10n.vehicleImageLabel(widget.vehicle.title);
    if (images.length <= 1) {
      return Padding(
        padding: RoveSpacing.page,
        child: VehiclePhoto(
          url: images.firstOrNull?.url ?? widget.vehicle.coverImageUrl,
          semanticLabel: label,
          memCacheWidth: 1200,
        ),
      );
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => Padding(
              padding: RoveSpacing.page,
              child: VehiclePhoto(
                url: images[i].url,
                semanticLabel: label,
                memCacheWidth: 1200,
              ),
            ),
          ),
        ),
        const SizedBox(height: RoveSpacing.xs),
        Text(
          l10n.vehiclePhotoCount(_index + 1, images.length),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _PartnerRow extends StatelessWidget {
  const _PartnerRow({required this.partner});

  final PartnerRef partner;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        const Icon(Icons.storefront_outlined, size: 20),
        const SizedBox(width: RoveSpacing.xs),
        Expanded(
          child: Text(
            partner.displayName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        StatusPill(
          label: partner.verified
              ? l10n.partnerVerified
              : l10n.partnerUnverified,
          tone: partner.verified ? PillTone.success : PillTone.neutral,
        ),
      ],
    );
  }
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({required this.vehicle, required this.state});

  final VehicleDetail vehicle;
  final VehicleDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final estimate = vehicle.estimatedTotal;
    final mileage = vehicle.mileagePolicy;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l10n.chargesRental),
        PriceRow(label: l10n.dailyRate, amount: vehicle.dailyRate),
        if (estimate != null && vehicle.days != null) ...[
          PriceRow(
            label: l10n.detailsEstimate,
            amount: estimate,
            emphasize: true,
          ),
          MutedText(l10n.estimateIncludes(vehicle.days!), small: true),
        ] else
          MutedText(l10n.estimateNoDates, small: true),
        const SizedBox(height: RoveSpacing.md),
        PriceRow(
          label: l10n.detailsDeposit,
          amount: vehicle.deposit,
          muted: true,
        ),
        MutedText(l10n.depositBody, small: true),
        if (mileage.limitKmPerDay != null &&
            !mileage.excessFeePerKm.isZero) ...[
          const SizedBox(height: RoveSpacing.md),
          Text(
            l10n.chargesConditional,
            style: text.labelMedium?.copyWith(color: RoveColors.textSecondary),
          ),
          PriceRow(
            label: l10n.detailsMileage,
            amount: mileage.excessFeePerKm,
            muted: true,
            suffix: l10n.perKmUnit,
          ),
        ],
      ],
    );
  }
}

class _BookBar extends StatelessWidget {
  const _BookBar({required this.vehicle, required this.state});

  final VehicleDetail vehicle;
  final VehicleDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final trip = context.watch<TripCubit>().state;
    final loading = state.status == LoadStatus.loading;
    final estimate = vehicle.estimatedTotal;
    final leading = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          estimate != null
              ? estimate.format()
              : '${vehicle.dailyRate.formatCompact()} ${l10n.perDay}',
          style: text.titleSmall,
        ),
        Text(
          state.hasDates ? tripDatesLabel(context, trip) : l10n.estimateNoDates,
          style: text.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
    final Widget action;
    if (!state.hasDates) {
      action = RoveButton(
        key: const Key('details-choose-dates'),
        label: l10n.detailsChooseDates,
        onPressed: () => context.push(Routes.dates),
      );
    } else if (state.isUnavailable) {
      action = RoveButton.secondary(
        key: const Key('details-change-dates'),
        label: l10n.detailsChooseDates,
        onPressed: () => context.push(Routes.dates),
      );
    } else {
      action = RoveButton(
        key: const Key('details-book'),
        label: l10n.detailsBook,
        loading: loading,
        onPressed: state.isBookable
            ? () => context.push(Routes.checkout(vehicle.id))
            : null,
      );
    }
    return BottomActionBar(
      leading: state.isUnavailable
          ? Text(
              l10n.detailsUnavailable,
              key: const Key('details-unavailable'),
              style: text.bodyMedium?.copyWith(color: RoveColors.danger),
            )
          : leading,
      child: action,
    );
  }
}

class _DetailsSkeleton extends StatelessWidget {
  const _DetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(RoveSpacing.md),
      children: const [
        VehicleCardSkeleton(),
        SizedBox(height: RoveSpacing.lg),
        Skeleton(width: 200, height: 14),
        SizedBox(height: RoveSpacing.sm),
        Skeleton(height: 14),
        SizedBox(height: RoveSpacing.sm),
        Skeleton(width: 240, height: 14),
      ],
    );
  }
}
