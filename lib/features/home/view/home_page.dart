import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/rove_wordmark.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vehicle_card.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../search/bloc/search_bloc.dart';
import '../../search/bloc/trip_cubit.dart';
import '../bloc/home_cubit.dart';
import 'city_sheet.dart';
import 'trip_summary.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<VehicleRepository>()),
      child: const _HomeView(),
    );
  }
}

/// Starts a search from the current trip and opens the results.
void startSearch(BuildContext context, {VehicleCategory? category}) {
  final trip = context.read<TripCubit>().state;
  final code = trip.countryCode;
  if (code == null) return;
  final error = trip.validate(context.read<TripCubit>().now);
  final hasValidDates = error == null;
  context.read<SearchBloc>().add(
    SearchRequested(
      VehicleQuery(
        countryCode: code,
        cityId: trip.city?.id,
        pickupAt: hasValidDates ? trip.pickupAt : null,
        returnAt: hasValidDates ? trip.returnAt : null,
        category: category,
      ),
    ),
  );
  context.push(Routes.search);
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  void _loadFeatured({bool force = false}) {
    final trip = context.read<TripCubit>().state;
    final code = trip.countryCode;
    if (code == null) return;
    context.read<HomeCubit>().load(
      countryCode: code,
      cityId: trip.city?.id,
      force: force,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadFeatured();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<TripCubit, TripState>(
      listenWhen: (a, b) =>
          a.countryCode != b.countryCode || a.city?.id != b.city?.id,
      listener: (context, _) => _loadFeatured(),
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => _loadFeatured(force: true),
            child: ListView(
              padding: const EdgeInsets.only(bottom: RoveSpacing.xl),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    RoveSpacing.md,
                    RoveSpacing.sm,
                    RoveSpacing.xs,
                    0,
                  ),
                  child: Row(
                    children: [
                      const RoveWordmark(size: 24),
                      const Spacer(),
                      IconButton(
                        tooltip: l10n.navProfile,
                        icon: const Icon(Icons.person_outline_rounded),
                        onPressed: () => context.go(Routes.profile),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: RoveSpacing.page, child: _Greeting()),
                const SizedBox(height: RoveSpacing.md),
                const Padding(padding: RoveSpacing.page, child: _SearchPanel()),
                Padding(
                  padding: RoveSpacing.page,
                  child: SectionHeader(title: l10n.categoriesTitle),
                ),
                const _Categories(),
                Padding(
                  padding: RoveSpacing.page,
                  child: SectionHeader(title: l10n.featuredTitle),
                ),
                const _Featured(),
                const _RecentlyViewed(),
                const _SavedStrip(),
                const Padding(padding: RoveSpacing.page, child: _Trust()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = context.select<AuthBloc, String?>(
      (b) => b.state.me?.profile.fullName,
    );
    final first = name?.trim().split(' ').first;
    return Text(
      first == null || first.isEmpty
          ? l10n.homeTitle
          : l10n.homeGreeting(first),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, trip) {
        final error = trip.validate(context.read<TripCubit>().now);
        return RoveCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoveSelectField(
                key: const Key('home-city'),
                label: l10n.pickupCityLabel,
                value: trip.city?.name,
                placeholder: l10n.selectCity,
                icon: Icons.place_outlined,
                onTap: () => showCitySheet(context),
              ),
              const SizedBox(height: RoveSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: RoveSelectField(
                      key: const Key('home-pickup'),
                      label: l10n.pickupLabel,
                      value: trip.pickupAt == null
                          ? null
                          : compactDateTime(
                              context,
                              trip.pickupAt!,
                              trip.timezone,
                            ),
                      placeholder: l10n.pickDate,
                      icon: Icons.calendar_today_outlined,
                      onTap: () => context.push(Routes.dates),
                    ),
                  ),
                  const SizedBox(width: RoveSpacing.sm),
                  Expanded(
                    child: RoveSelectField(
                      key: const Key('home-return'),
                      label: l10n.returnLabel,
                      value: trip.returnAt == null
                          ? null
                          : compactDateTime(
                              context,
                              trip.returnAt!,
                              trip.timezone,
                            ),
                      placeholder: l10n.pickDate,
                      icon: Icons.calendar_today_outlined,
                      onTap: () => context.push(Routes.dates),
                    ),
                  ),
                ],
              ),
              if (trip.hasDates && error != null) ...[
                const SizedBox(height: RoveSpacing.xs),
                Text(
                  l10n.periodError(error),
                  key: const Key('home-period-error'),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: RoveColors.danger),
                ),
              ],
              const SizedBox(height: RoveSpacing.md),
              RoveButton(
                key: const Key('home-search'),
                label: l10n.searchCars,
                expand: true,
                onPressed: trip.countryCode == null || error != null
                    ? null
                    : () => startSearch(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();

  static const _icons = {
    VehicleCategory.economy: Icons.directions_car_outlined,
    VehicleCategory.suv: Icons.airport_shuttle_outlined,
    VehicleCategory.sedan: Icons.local_taxi_outlined,
    VehicleCategory.luxury: Icons.diamond_outlined,
    VehicleCategory.electric: Icons.electric_car_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: RoveSpacing.page,
        itemCount: VehicleCategoryWire.browsable.length,
        separatorBuilder: (_, _) => const SizedBox(width: RoveSpacing.xs),
        itemBuilder: (context, i) {
          final category = VehicleCategoryWire.browsable[i];
          return ActionChip(
            key: ValueKey('category-${category.wire}'),
            avatar: Icon(_icons[category], size: 18),
            label: Text(l10n.category(category)),
            onPressed: () => startSearch(context, category: category),
          );
        },
      ),
    );
  }
}

class _HorizontalCars extends StatelessWidget {
  const _HorizontalCars({required this.vehicles});

  final List<VehicleSummary> vehicles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: RoveSpacing.page,
        itemCount: vehicles.length,
        separatorBuilder: (_, _) => const SizedBox(width: RoveSpacing.md),
        itemBuilder: (context, i) => VehicleCard(
          width: 260,
          vehicle: vehicles[i],
          onTap: () => context.push(Routes.vehicle(vehicles[i].id)),
        ),
      ),
    );
  }
}

class _Featured extends StatelessWidget {
  const _Featured();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case LoadStatus.initial:
          case LoadStatus.loading:
            return SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: RoveSpacing.page,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  VehicleCardSkeleton(width: 260),
                  SizedBox(width: RoveSpacing.md),
                  VehicleCardSkeleton(width: 260),
                ],
              ),
            );
          case LoadStatus.failure:
            return Padding(
              padding: RoveSpacing.page,
              child: ErrorState(
                failure: state.failure!,
                compact: true,
                onRetry: () {
                  final trip = context.read<TripCubit>().state;
                  context.read<HomeCubit>().load(
                    countryCode: trip.countryCode!,
                    cityId: trip.city?.id,
                    force: true,
                  );
                },
              ),
            );
          case LoadStatus.empty:
            return Padding(
              padding: RoveSpacing.page,
              child: MutedText(context.l10n.featuredEmpty),
            );
          case LoadStatus.success:
            return _HorizontalCars(vehicles: state.featured);
        }
      },
    );
  }
}

class _RecentlyViewed extends StatelessWidget {
  const _RecentlyViewed();

  @override
  Widget build(BuildContext context) {
    final recent = context.select<PreferencesCubit, List<VehicleSummary>>(
      (c) => c.state.recentlyViewed,
    );
    if (recent.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: RoveSpacing.page,
          child: SectionHeader(title: context.l10n.recentlyViewedTitle),
        ),
        _HorizontalCars(vehicles: recent),
      ],
    );
  }
}

class _SavedStrip extends StatelessWidget {
  const _SavedStrip();

  @override
  Widget build(BuildContext context) {
    final saved = context.select<FavoritesBloc, List<VehicleSummary>>(
      (b) => b.state.vehicles,
    );
    final cityId = context.select<TripCubit, String?>((c) => c.state.city?.id);
    // Prices are per city/currency, so only show cars from the current city.
    final inCountry = saved
        .where((v) => cityId == null || v.city.id == cityId)
        .toList();
    if (inCountry.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: RoveSpacing.page,
          child: SectionHeader(
            title: context.l10n.savedCarsTitle,
            actionLabel: context.l10n.seeAll,
            onAction: () => context.go(Routes.saved),
          ),
        ),
        _HorizontalCars(vehicles: inCountry),
      ],
    );
  }
}

class _Trust extends StatelessWidget {
  const _Trust();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    Widget item(IconData icon, String title, String body) => Padding(
      padding: const EdgeInsets.only(bottom: RoveSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: RoveColors.primary),
          const SizedBox(width: RoveSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: text.titleSmall),
                const SizedBox(height: 2),
                MutedText(body),
              ],
            ),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l10n.trustTitle),
        item(
          Icons.receipt_long_outlined,
          l10n.trustPricingTitle,
          l10n.trustPricingBody,
        ),
        item(
          Icons.verified_outlined,
          l10n.trustPartnersTitle,
          l10n.trustPartnersBody,
        ),
      ],
    );
  }
}
