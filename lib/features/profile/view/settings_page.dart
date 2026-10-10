import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/models/reference.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../onboarding/bloc/countries_cubit.dart';
import '../../search/bloc/trip_cubit.dart';
import '../bloc/profile_form_cubit.dart';

/// Languages the app is structured for. Only English ships today; Arabic
/// (RTL) and Hindi are listed so the switch exists when translations land.
const supportedLanguageCodes = ['en'];
const plannedLanguageCodes = ['ar', 'hi'];

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileFormCubit(context.read<ProfileRepository>()),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  Future<void> _save(BuildContext context, ProfileUpdate update) async {
    final l10n = context.l10n;
    final auth = context.read<AuthBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final me = await context.read<ProfileFormCubit>().submit(update);
    if (me != null) {
      auth.add(AuthProfileUpdated(me));
      messenger.showSnackBar(SnackBar(content: Text(l10n.settingsSaved)));
    }
  }

  Future<void> _setCountry(BuildContext context, Country country) async {
    final prefs = context.read<PreferencesCubit>();
    final trip = context.read<TripCubit>();
    await _save(
      context,
      ProfileUpdate(countryCode: country.code, cityId: null),
    );
    await prefs.setCountry(country.code);
    trip.setCountry(country.code);
  }

  Future<void> _setCity(BuildContext context, City city) async {
    final prefs = context.read<PreferencesCubit>();
    final trip = context.read<TripCubit>();
    await _save(context, ProfileUpdate(cityId: city.id));
    await prefs.setCity(city.id);
    trip.setCity(city);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final me = context.select<AuthBloc, Me?>((b) => b.state.me);
    final profile = me?.profile ?? const CustomerProfile();
    final countries = context.watch<CountriesCubit>().state.countries;
    final country = countries
        .where((c) => c.code == profile.countryCode)
        .firstOrNull;
    final form = context.watch<ProfileFormCubit>().state;
    final prefs = profile.notificationPrefs;
    final busy = form.status == SubmitStatus.submitting;
    String languageLabel(String code) => switch (code) {
      'ar' => l10n.languageArabic,
      'hi' => l10n.languageHindi,
      _ => l10n.languageEnglish,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        bottom: busy
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: RoveSpacing.md),
        children: [
          if (form.status == SubmitStatus.failure)
            Padding(
              padding: const EdgeInsets.only(top: RoveSpacing.md),
              child: InlineNotice(
                message: l10n.failure(form.failure!),
                tone: NoticeTone.danger,
              ),
            ),
          SectionHeader(title: l10n.settingsRegion),
          RadioGroup<String>(
            groupValue: profile.countryCode,
            onChanged: (code) {
              final next = countries.where((c) => c.code == code).firstOrNull;
              if (next != null && !busy) _setCountry(context, next);
            },
            child: Column(
              children: [
                for (final c in countries)
                  RadioListTile<String>(
                    key: ValueKey('settings-country-${c.code}'),
                    contentPadding: EdgeInsets.zero,
                    value: c.code,
                    title: Text(c.name),
                    secondary: Text(c.currency),
                  ),
              ],
            ),
          ),
          if (country != null)
            DropdownButtonFormField<String>(
              key: ValueKey('settings-city-${country.code}'),
              initialValue: country.cityById(profile.cityId)?.id,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.cityLabel),
              items: [
                for (final city in country.cities)
                  DropdownMenuItem(value: city.id, child: Text(city.name)),
              ],
              onChanged: busy
                  ? null
                  : (id) {
                      final city = country.cityById(id);
                      if (city != null) _setCity(context, city);
                    },
            ),
          SectionHeader(title: l10n.settingsLanguage),
          RadioGroup<String>(
            groupValue: context.watch<PreferencesCubit>().state.languageCode,
            onChanged: (code) async {
              if (code == null || !supportedLanguageCodes.contains(code)) {
                return;
              }
              await context.read<PreferencesCubit>().setLanguage(code);
              if (context.mounted) {
                await _save(context, ProfileUpdate(preferredLanguage: code));
              }
            },
            child: Column(
              children: [
                for (final code in [
                  ...supportedLanguageCodes,
                  ...plannedLanguageCodes,
                ])
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    value: code,
                    enabled: supportedLanguageCodes.contains(code),
                    title: Text(languageLabel(code)),
                    secondary: supportedLanguageCodes.contains(code)
                        ? null
                        : StatusPill(label: l10n.languageComingSoon),
                  ),
              ],
            ),
          ),
          SectionHeader(title: l10n.settingsNotifications),
          SwitchListTile(
            key: const Key('notif-email'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.notifEmail),
            subtitle: Text(l10n.notifEmailBody),
            value: prefs.email,
            onChanged: busy
                ? null
                : (v) => _save(
                    context,
                    ProfileUpdate(notificationPrefs: prefs.copyWith(email: v)),
                  ),
          ),
          SwitchListTile(
            key: const Key('notif-push'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.notifPush),
            subtitle: Text(l10n.notifPushBody),
            value: prefs.push,
            onChanged: busy
                ? null
                : (v) => _save(
                    context,
                    ProfileUpdate(notificationPrefs: prefs.copyWith(push: v)),
                  ),
          ),
          SwitchListTile(
            key: const Key('notif-marketing'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.notifMarketing),
            subtitle: Text(l10n.notifMarketingBody),
            value: prefs.marketing,
            onChanged: busy
                ? null
                : (v) => _save(
                    context,
                    ProfileUpdate(
                      notificationPrefs: prefs.copyWith(marketing: v),
                    ),
                  ),
          ),
          const SizedBox(height: RoveSpacing.xl),
        ],
      ),
    );
  }
}
