import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/section.dart';
import '../../search/bloc/trip_cubit.dart';
import 'city_sheet.dart';
import 'home_page.dart';
import 'trip_summary.dart';

/// Opened from the home search pill: city, pickup and return, then search.
class PlanTripPage extends StatelessWidget {
  const PlanTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, trip) {
        final error = trip.validate(context.read<TripCubit>().now);
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.planTripTitle),
            leading: IconButton(
              tooltip: l10n.close,
              icon: const Icon(Icons.close_rounded),
              onPressed: () => context.pop(),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(RoveSpacing.ml),
            children: [
              RoveSelectField(
                key: const Key('plan-city'),
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
                  ).textTheme.bodySmall?.copyWith(color: c.danger),
                ),
              ],
              const SizedBox(height: RoveSpacing.md),
              if (trip.city != null)
                MutedText(
                  l10n.datesTimezoneNote(trip.city!.name, trip.timezone ?? ''),
                  small: true,
                ),
            ],
          ),
          bottomNavigationBar: BottomActionBar(
            child: RoveButton(
              key: const Key('home-search'),
              label: l10n.searchCars,
              icon: Icons.search_rounded,
              expand: true,
              onPressed: trip.countryCode == null || error != null
                  ? null
                  : () => startSearch(context, replace: true),
            ),
          ),
        );
      },
    );
  }
}
