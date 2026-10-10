import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vehicle_card.dart';
import '../../../shared/models/enums.dart';
import '../../onboarding/bloc/countries_cubit.dart';
import '../bloc/search_bloc.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.extentAfter < 600) {
        context.read<SearchBloc>().add(const SearchNextPageRequested());
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _chooseSort(VehicleSort current) async {
    final l10n = context.l10n;
    final selected = await showModalBottomSheet<VehicleSort>(
      context: context,
      useRootNavigator: true,
      builder: (context) => SafeArea(
        child: RadioGroup<VehicleSort>(
          groupValue: current,
          onChanged: (v) => Navigator.of(context).pop(v),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final sort in VehicleSort.values)
                RadioListTile<VehicleSort>(
                  key: ValueKey('sort-${sort.wire}'),
                  value: sort,
                  title: Text(l10n.sort(sort)),
                ),
              const SizedBox(height: RoveSpacing.md),
            ],
          ),
        ),
      ),
    );
    if (selected != null && selected != current && mounted) {
      context.read<SearchBloc>().add(SearchSortChanged(selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final query = state.query;
        final countries = context.read<CountriesCubit>().state;
        final city = countries.cityById(query?.cityId);
        final country = countries.byCode(query?.countryCode);
        final tz = city?.timezone ?? country?.timezone;
        final locale = context.localeTag;
        final subtitle = query != null && query.hasDates
            ? '${ZonedTime.formatShortDate(query.pickupAt!, tz, locale: locale)} → '
                  '${ZonedTime.formatShortDate(query.returnAt!, tz, locale: locale)}'
            : l10n.estimateNoDates;
        final filterCount = query?.activeFilterCount ?? 0;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: InkWell(
              onTap: () => context.pop(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city?.name ?? country?.name ?? '',
                    style: text.titleSmall,
                  ),
                  Text(subtitle, style: text.bodySmall),
                ],
              ),
            ),
            actions: [
              RoveButton.text(label: l10n.edit, onPressed: () => context.pop()),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  RoveSpacing.md,
                  0,
                  RoveSpacing.md,
                  RoveSpacing.xs,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.status == LoadStatus.success
                            ? l10n.searchResultsCount(state.meta.total)
                            : '',
                        style: text.bodyMedium?.copyWith(
                          color: RoveColors.textSecondary,
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextButton.icon(
                        key: const Key('search-sort'),
                        onPressed: query == null
                            ? null
                            : () => _chooseSort(query.sort),
                        icon: const Icon(Icons.swap_vert_rounded, size: 18),
                        label: Text(
                          l10n.sort(query?.sort ?? VehicleSort.relevance),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      key: const Key('search-filters'),
                      onPressed: query == null
                          ? null
                          : () => context.push(Routes.filters),
                      icon: const Icon(Icons.tune_rounded, size: 18),
                      label: Text(
                        filterCount == 0
                            ? l10n.filtersTitle
                            : l10n.filtersWithCount(filterCount),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: _results(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _results(BuildContext context, SearchState state) {
    final l10n = context.l10n;
    switch (state.status) {
      case LoadStatus.initial:
      case LoadStatus.loading:
        return ListView.separated(
          padding: const EdgeInsets.all(RoveSpacing.md),
          itemCount: 3,
          separatorBuilder: (_, _) => const SizedBox(height: RoveSpacing.lg),
          itemBuilder: (_, _) => const VehicleCardSkeleton(),
        );
      case LoadStatus.failure:
        return ErrorState(
          failure: state.failure!,
          onRetry: () => context.read<SearchBloc>().add(const SearchRetried()),
        );
      case LoadStatus.empty:
        final filtered = (state.query?.activeFilterCount ?? 0) > 0;
        return EmptyState(
          key: const Key('search-empty'),
          icon: Icons.search_off_rounded,
          message: filtered ? l10n.searchEmptyFiltered : l10n.searchEmpty,
          actionLabel: filtered ? l10n.clearFilters : l10n.changeSearch,
          onAction: filtered
              ? () =>
                    context.read<SearchBloc>().add(const SearchFiltersCleared())
              : () => context.pop(),
        );
      case LoadStatus.success:
        final showNote = state.query?.hasDates ?? false;
        final extra = (showNote ? 1 : 0);
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<SearchBloc>().add(const SearchRetried()),
          child: ListView.separated(
            controller: _scroll,
            padding: const EdgeInsets.fromLTRB(
              RoveSpacing.md,
              RoveSpacing.xs,
              RoveSpacing.md,
              RoveSpacing.xl,
            ),
            itemCount: state.vehicles.length + extra + 1,
            separatorBuilder: (_, _) => const SizedBox(height: RoveSpacing.lg),
            itemBuilder: (context, i) {
              if (showNote && i == 0) {
                return MutedText(l10n.searchAvailabilityNote, small: true);
              }
              final index = i - extra;
              if (index == state.vehicles.length) {
                if (state.loadingMore) {
                  return const VehicleCardSkeleton();
                }
                if (state.loadMoreFailure != null) {
                  return ErrorState(
                    failure: state.loadMoreFailure!,
                    compact: true,
                    onRetry: () => context.read<SearchBloc>().add(
                      const SearchNextPageRequested(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }
              final vehicle = state.vehicles[index];
              return VehicleCard(
                key: ValueKey('vehicle-${vehicle.id}'),
                vehicle: vehicle,
                onTap: () => context.push(Routes.vehicle(vehicle.id)),
              );
            },
          ),
        );
    }
  }
}
