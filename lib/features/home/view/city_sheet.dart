import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/location/location_service.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../shared/models/reference.dart';
import '../../../shared/repositories/reference_repository.dart';
import '../../onboarding/bloc/countries_cubit.dart';
import '../../search/bloc/trip_cubit.dart';

/// Country switch plus city list. Device location is requested only when
/// the customer taps "Use my location".
Future<void> showCitySheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<CountriesCubit>()),
        BlocProvider.value(value: context.read<PreferencesCubit>()),
        BlocProvider.value(value: context.read<TripCubit>()),
      ],
      child: RepositoryProvider.value(
        value: context.read<ReferenceRepository>(),
        child: RepositoryProvider.value(
          value: context.read<LocationService>(),
          child: const _CitySheet(),
        ),
      ),
    ),
  );
}

class _CitySheet extends StatefulWidget {
  const _CitySheet();

  @override
  State<_CitySheet> createState() => _CitySheetState();
}

class _CitySheetState extends State<_CitySheet> {
  bool _locating = false;
  String? _message;

  Future<void> _selectCountry(Country country) async {
    await context.read<PreferencesCubit>().setCountry(country.code);
    if (!mounted) return;
    context.read<TripCubit>().setCountry(country.code);
  }

  Future<void> _selectCity(City city) async {
    await context.read<PreferencesCubit>().setCity(city.id);
    if (!mounted) return;
    context.read<TripCubit>().setCity(city);
    Navigator.of(context).pop();
  }

  Future<void> _useLocation(Country country) async {
    final l10n = context.l10n;
    setState(() {
      _locating = true;
      _message = null;
    });
    final result = await context.read<LocationService>().currentLocation();
    if (!mounted) return;
    String? cityId;
    if (result is LocationFound) {
      try {
        final locations = await context
            .read<ReferenceRepository>()
            .getLocations(countryCode: country.code);
        cityId = nearestCityId(result.latitude, result.longitude, locations);
      } on Exception {
        cityId = null;
      }
    }
    if (!mounted) return;
    final city = country.cityById(cityId);
    if (city != null) {
      await _selectCity(city);
      return;
    }
    setState(() {
      _locating = false;
      _message = result is LocationDenied
          ? l10n.locationDenied
          : l10n.locationUnavailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final countries = context.watch<CountriesCubit>().state.countries;
    final code = context.watch<PreferencesCubit>().state.countryCode;
    final selectedCity = context.watch<TripCubit>().state.city;
    final country = countries.where((c) => c.code == code).firstOrNull;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(
          RoveSpacing.md,
          0,
          RoveSpacing.md,
          RoveSpacing.lg,
        ),
        children: [
          Text(l10n.pickupCityLabel, style: text.titleMedium),
          const SizedBox(height: RoveSpacing.md),
          if (countries.length > 1)
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: [
                for (final c in countries)
                  ButtonSegment(
                    value: c.code,
                    label: Text(c.name, overflow: TextOverflow.ellipsis),
                  ),
              ],
              selected: {?code},
              emptySelectionAllowed: true,
              onSelectionChanged: (s) {
                final next = countries.firstWhere((c) => c.code == s.first);
                _selectCountry(next);
              },
            ),
          const SizedBox(height: RoveSpacing.sm),
          if (country != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: _locating
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.near_me_outlined),
              title: Text(
                l10n.useMyLocation,
                style: text.bodyLarge?.copyWith(color: RoveColors.primary),
              ),
              subtitle: _message == null ? null : Text(_message!),
              onTap: _locating ? null : () => _useLocation(country),
            ),
          for (final city in country?.cities ?? const <City>[])
            ListTile(
              key: ValueKey('city-${city.slug}'),
              contentPadding: EdgeInsets.zero,
              title: Text(city.name),
              trailing: city.id == selectedCity?.id
                  ? const Icon(Icons.check_rounded, color: RoveColors.primary)
                  : null,
              onTap: () => _selectCity(city),
            ),
        ],
      ),
    );
  }
}
