import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/icon_circle.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vehicle_card.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/vehicle_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../favorites/view/favorite_button.dart';
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

/// Starts a search from the current trip and opens the results. With
/// [replace], the results replace the current route stack (from the plan
/// screen).
void startSearch(
  BuildContext context, {
  VehicleCategory? category,
  bool replace = false,
}) {
  final tripCubit = context.read<TripCubit>();
  final trip = tripCubit.state;
  final code = trip.countryCode;
  if (code == null) return;
  final hasValidDates = trip.validate(tripCubit.now) == null;
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
  if (replace) {
    context.go(Routes.search);
  } else {
    context.push(Routes.search);
  }
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
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () async => _loadFeatured(force: true),
            child: ListView(
              padding: const EdgeInsets.only(bottom: RoveSpacing.lg),
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: _Header(),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _SearchPill(),
                ),
                Padding(
                  padding: RoveSpacing.page,
                  child: SectionHeader(
                    title: l10n.categoriesTitle,
                    actionLabel: l10n.categoryAll,
                    onAction: () => startSearch(
                      context,
                      category: context.read<HomeCubit>().state.category,
                    ),
                  ),
                ),
                const _Categories(),
                Padding(
                  padding: RoveSpacing.page,
                  child: BlocSelector<HomeCubit, HomeState, VehicleCategory?>(
                    selector: (s) => s.category,
                    builder: (context, category) => SectionHeader(
                      title: category == null
                          ? l10n.featuredTitle
                          : l10n.category(category),
                    ),
                  ),
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

/// Avatar + "Hi {name}" + location row (opens the city picker) + bell.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    final name = context.select<AuthBloc, String?>(
      (b) => b.state.me?.profile.fullName,
    );
    final city = context.select<TripCubit, String?>((t) => t.state.city?.name);
    final first = name?.trim().split(' ').first;
    final initials = (name ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    return Row(
      children: [
        Semantics(
          button: true,
          label: l10n.navProfile,
          excludeSemantics: true,
          child: GestureDetector(
            onTap: () => context.go(Routes.profile),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: c.inputFill,
              child: Text(initials, style: text.labelMedium),
            ),
          ),
        ),
        const SizedBox(width: RoveSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first == null || first.isEmpty
                    ? l10n.homeTitle
                    : l10n.homeGreeting(first),
                style: text.bodyMedium?.copyWith(color: c.textSecondary),
              ),
              InkWell(
                key: const Key('home-city'),
                onTap: () => showCitySheet(context),
                borderRadius: RoveRadius.smallAll,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 16,
                        color: c.textPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(city ?? l10n.selectCity, style: text.titleSmall),
                      Icon(
                        Icons.expand_more_rounded,
                        size: 18,
                        color: c.textPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        IconCircle(
          icon: Icons.notifications_none_rounded,
          tooltip: l10n.notificationsTooltip,
          onPressed: () => context.push(Routes.settings),
        ),
      ],
    );
  }
}

/// Full-width pill; opens the plan-your-trip screen. The trip dates sit
/// underneath as a quiet line.
class _SearchPill extends StatelessWidget {
  const _SearchPill();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final trip = context.watch<TripCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: l10n.searchPlaceholder,
          excludeSemantics: true,
          child: Material(
            key: const Key('home-search-pill'),
            color: c.surface,
            shape: const StadiumBorder(),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: () => context.push(Routes.plan),
              child: SizedBox(
                height: 52,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.searchPlaceholder,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: c.textTertiary),
                        ),
                      ),
                      Icon(Icons.search_rounded, color: c.textSecondary),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (trip.hasDates)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: InkWell(
              key: const Key('home-dates'),
              onTap: () => context.push(Routes.dates),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: c.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${compactDateTime(context, trip.pickupAt!, trip.timezone)} → '
                      '${compactDateTime(context, trip.returnAt!, trip.timezone)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Square 88×88 tiles: icon in a circle, label below.
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
    final c = context.colors;
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: RoveSpacing.page,
        itemCount: VehicleCategoryWire.browsable.length,
        separatorBuilder: (_, _) => const SizedBox(width: RoveSpacing.sm),
        itemBuilder: (context, i) {
          final category = VehicleCategoryWire.browsable[i];
          return BlocSelector<HomeCubit, HomeState, bool>(
            selector: (s) => s.category == category,
            builder: (context, selected) => Semantics(
              button: true,
              selected: selected,
              label: l10n.category(category),
              excludeSemantics: true,
              child: AnimatedContainer(
                duration: RoveMotion.fast,
                decoration: BoxDecoration(
                  color: selected ? c.accentFill : c.surface,
                  borderRadius: RoveRadius.cardAll,
                ),
                child: Material(
                  key: ValueKey('category-${category.wire}'),
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: RoveRadius.cardAll,
                    onTap: () =>
                        context.read<HomeCubit>().toggleCategory(category),
                    child: SizedBox(
                      width: 88,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: selected
                                ? Colors.white
                                : c.inputFill,
                            child: Icon(
                              _icons[category],
                              size: 20,
                              color: selected ? c.accentFill : c.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.category(category),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: selected ? c.onPrimary : null,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
      height: 276,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: RoveSpacing.page,
        itemCount: vehicles.length,
        separatorBuilder: (_, _) => const SizedBox(width: RoveSpacing.md),
        itemBuilder: (context, i) => VehicleCard(
          width: 300,
          vehicle: vehicles[i],
          favorite: FavoriteButton(vehicle: vehicles[i]),
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
              height: 276,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: RoveSpacing.page,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  VehicleCardSkeleton(width: 300),
                  SizedBox(width: RoveSpacing.md),
                  VehicleCardSkeleton(width: 300),
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
              child: MutedText(
                state.category == null
                    ? context.l10n.featuredEmpty
                    : context.l10n.categoryEmpty,
              ),
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
    final inCity = saved
        .where((v) => cityId == null || v.city.id == cityId)
        .toList();
    if (inCity.isEmpty) return const SizedBox.shrink();
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
        _HorizontalCars(vehicles: inCity),
      ],
    );
  }
}

class _Trust extends StatelessWidget {
  const _Trust();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    Widget item(IconData icon, String title, String body) => Padding(
      padding: const EdgeInsets.symmetric(vertical: RoveSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: c.inputFill,
            child: Icon(icon, size: 20, color: c.primary),
          ),
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
        RoveCard(
          child: Column(
            children: [
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
          ),
        ),
      ],
    );
  }
}
