import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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
import '../../../core/widgets/vehicle_card.dart';
import '../../favorites/view/favorite_button.dart';
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
    final l10n = context.l10n;
    return BlocListener<TripCubit, TripState>(
      listenWhen: (a, b) =>
          a.pickupAt != b.pickupAt || a.returnAt != b.returnAt,
      listener: _reloadForTrip,
      child: BlocBuilder<VehicleDetailsCubit, VehicleDetailsState>(
        builder: (context, state) {
          final vehicle = state.vehicle;
          final appBar = AppBar(
            leadingWidth: 96,
            leading: TextButton.icon(
              key: const Key('details-back'),
              onPressed: () => context.pop(),
              icon: const Icon(Icons.chevron_left_rounded),
              label: Text(l10n.back),
              style: TextButton.styleFrom(
                foregroundColor: context.colors.textPrimary,
              ),
            ),
            title: Text(l10n.carDetailsTitle),
            actions: [
              if (vehicle != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16),
                  child: FavoriteButton(vehicle: vehicle.toSummary()),
                ),
            ],
          );
          if (vehicle == null) {
            return Scaffold(
              appBar: appBar,
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
            appBar: appBar,
            body: _DetailsBody(vehicle: vehicle, state: state),
            bottomNavigationBar: _BookBar(vehicle: vehicle, state: state),
          );
        },
      ),
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
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    final mileage = vehicle.mileagePolicy;
    final deliveryText = !vehicle.deliveryAvailable
        ? l10n.detailsNoDelivery
        : vehicle.deliveryFee.isZero
        ? l10n.detailsDeliveryFree
        : l10n.detailsDeliveryFee(vehicle.deliveryFee.format());
    final mileageText = mileage.limitKmPerDay == null
        ? l10n.mileageUnlimited
        : [
            l10n.mileageLimit(mileage.limitKmPerDay!),
            if (!mileage.excessFeePerKm.isZero)
              l10n.mileageExcess(mileage.excessFeePerKm.format()),
          ].join('. ');
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _Gallery(vehicle: vehicle),
        const SizedBox(height: RoveSpacing.md),
        Material(
          color: c.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(RoveRadius.sheet),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                if (vehicle.description != null &&
                    vehicle.description!.isNotEmpty) ...[
                  const SizedBox(height: RoveSpacing.md),
                  _ReadMore(text: vehicle.description!),
                ],
                const SizedBox(height: RoveSpacing.lg),
                _SpecGrid(vehicle: vehicle),
                if (vehicle.features.isNotEmpty) ...[
                  SectionHeader(title: l10n.detailsFeatures),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final f in vehicle.features)
                        Chip(
                          label: Text(f),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
                SectionHeader(title: l10n.policiesTitle),
                _PolicyTile(
                  icon: Icons.event_busy_outlined,
                  title: l10n.detailsCancellation,
                  body: vehicle.cancellationPolicy.summary,
                ),
                _PolicyTile(
                  icon: Icons.local_gas_station_outlined,
                  title: l10n.detailsFuelPolicy,
                  body: l10n.fuelPolicy(vehicle.fuelPolicy),
                ),
                _PolicyTile(
                  icon: Icons.speed_outlined,
                  title: l10n.detailsMileage,
                  body: mileageText,
                ),
                _PolicyTile(
                  icon: Icons.shield_outlined,
                  title: l10n.detailsInsurance,
                  body:
                      (vehicle.insuranceInfo == null ||
                          vehicle.insuranceInfo!.isEmpty)
                      ? l10n.insuranceMissing
                      : vehicle.insuranceInfo!,
                ),
                _PolicyTile(
                  icon: Icons.local_shipping_outlined,
                  title: l10n.detailsPickupDelivery,
                  body: deliveryText,
                ),
                SectionHeader(title: l10n.locationTitle),
                _LocationCard(vehicle: vehicle),
                _PriceSection(vehicle: vehicle, state: state),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadMore extends StatefulWidget {
  const _ReadMore({required this.text});

  final String text;

  @override
  State<_ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<_ReadMore> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: context.colors.textSecondary);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: RoveMotion.normal,
          alignment: Alignment.topCenter,
          child: Text(
            widget.text,
            style: style,
            maxLines: _expanded ? null : 3,
            overflow: _expanded ? null : TextOverflow.ellipsis,
          ),
        ),
        if (widget.text.length > 140)
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _expanded ? context.l10n.readLess : context.l10n.readMore,
                style: style?.copyWith(color: context.colors.textPrimary),
              ),
            ),
          ),
      ],
    );
  }
}

/// Three-per-row spec tiles (`surface-2`, radius 16).
class _SpecGrid extends StatelessWidget {
  const _SpecGrid({required this.vehicle});

  final VehicleDetail vehicle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    final mileage = vehicle.mileagePolicy.limitKmPerDay;
    final tiles = [
      (Icons.person_outline_rounded, l10n.filterSeats, '${vehicle.seats}'),
      (
        Icons.settings_outlined,
        l10n.specTransmissionShort,
        l10n.transmission(vehicle.transmission),
      ),
      (
        fuelIcon(vehicle.fuelType),
        l10n.filterFuel,
        l10n.fuel(vehicle.fuelType),
      ),
      (
        Icons.speed_outlined,
        l10n.specMileage,
        mileage == null
            ? l10n.mileageUnlimitedShort
            : l10n.mileagePerDayShort(mileage),
      ),
      (
        Icons.account_balance_wallet_outlined,
        l10n.specDeposit,
        vehicle.deposit.formatCompact(),
      ),
      (Icons.luggage_outlined, l10n.specLuggage, '${vehicle.luggage}'),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 10.0;
        final width = (constraints.maxWidth - gap * 2) / 3;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final (icon, label, value) in tiles)
              Container(
                width: width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: c.inputFill,
                  borderRadius: BorderRadius.circular(RoveRadius.tile),
                ),
                child: Semantics(
                  label: '$label: $value',
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, size: 20, color: c.textSecondary),
                      const SizedBox(height: 10),
                      Text(
                        label,
                        style: text.bodySmall?.copyWith(color: c.textTertiary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: text.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// A policy row with a chevron; opens the full text in a sheet.
class _PolicyTile extends StatelessWidget {
  const _PolicyTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: c.inputFill,
        child: Icon(icon, size: 20, color: c.textPrimary),
      ),
      title: Text(title),
      subtitle: Text(body, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Icon(Icons.chevron_right_rounded, color: c.textSecondary),
      onTap: () => showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: RoveSpacing.sm),
                Text(body, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.vehicle});

  final VehicleDetail vehicle;

  Future<void> _openMaps() async {
    final location = vehicle.pickupLocation;
    if (location == null) return;
    final query = location.latitude != null && location.longitude != null
        ? '${location.latitude},${location.longitude}'
        : '${location.name}, ${location.address ?? vehicle.city.name}';
    await launchUrl(
      Uri.https('maps.apple.com', '/', {'q': query}),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final location = vehicle.pickupLocation;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.inputFill,
        borderRadius: BorderRadius.circular(RoveRadius.tile),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: c.surface3,
            child: Icon(Icons.place_outlined, color: c.primary),
          ),
          const SizedBox(width: RoveSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location?.name ?? l10n.detailsPickupArranged,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (location?.address != null)
                  MutedText(location!.address!, small: true),
              ],
            ),
          ),
          if (location != null)
            RoveButton.text(label: l10n.openInMaps, onPressed: _openMaps),
        ],
      ),
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
    final c = context.colors;
    final images = widget.vehicle.orderedImages;
    final label = l10n.vehicleImageLabel(widget.vehicle.title);
    final urls = images.isEmpty
        ? [widget.vehicle.coverImageUrl]
        : images.map((i) => i.url).toList();
    return Column(
      children: [
        Padding(
          padding: RoveSpacing.page,
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: PageView.builder(
              itemCount: urls.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) {
                final photo = VehiclePhoto(
                  url: urls[i],
                  semanticLabel: label,
                  aspectRatio: 4 / 3,
                  radius: RoveRadius.card,
                  memCacheWidth: 1400,
                );
                return i == 0
                    ? Hero(
                        tag: 'vehicle-photo-${widget.vehicle.id}',
                        child: photo,
                      )
                    : photo;
              },
            ),
          ),
        ),
        if (urls.length > 1) ...[
          const SizedBox(height: RoveSpacing.sm),
          Semantics(
            label: l10n.vehiclePhotoCount(_index + 1, urls.length),
            excludeSemantics: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < urls.length; i++)
                  AnimatedContainer(
                    duration: RoveMotion.fast,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _index ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _index ? c.primary : c.textTertiary,
                      borderRadius: RoveRadius.pillAll,
                    ),
                  ),
              ],
            ),
          ),
        ],
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
    final c = context.colors;
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: c.inputFill,
          backgroundImage: partner.logoUrl == null
              ? null
              : CachedNetworkImageProvider(partner.logoUrl!),
          child: partner.logoUrl == null
              ? Text(
                  partner.displayName.characters.first,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              : null,
        ),
        const SizedBox(width: RoveSpacing.sm),
        Expanded(
          child: Text(
            partner.displayName,
            style: Theme.of(context).textTheme.labelLarge,
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
            style: text.labelMedium?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          PriceRow(
            label: l10n.extraKm,
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
    final c = context.colors;
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
              : l10n.fromPerDay(
                  '${vehicle.dailyRate.formatCompact()}${l10n.perDay}',
                ),
          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
        label: l10n.bookNow,
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
              style: text.bodyMedium?.copyWith(color: c.danger),
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
