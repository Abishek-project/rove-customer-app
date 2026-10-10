import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../bloc/countries_cubit.dart';

/// Country selection. Options come from `GET /countries`.
class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = context.read<PreferencesCubit>().state.countryCode;
    context.read<CountriesCubit>().load();
  }

  Future<void> _continue() async {
    final code = _selected;
    if (code == null) return;
    await context.read<PreferencesCubit>().setCountry(code);
    if (mounted) context.go(Routes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: RoveSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.countryTitle, style: text.headlineSmall),
              const SizedBox(height: RoveSpacing.xs),
              MutedText(l10n.countryBody),
              const SizedBox(height: RoveSpacing.lg),
              Expanded(
                child: BlocBuilder<CountriesCubit, CountriesState>(
                  builder: (context, state) {
                    if (state.status == LoadStatus.failure &&
                        state.countries.isEmpty) {
                      return ErrorState(
                        failure: state.failure!,
                        onRetry: () =>
                            context.read<CountriesCubit>().load(force: true),
                      );
                    }
                    if (state.countries.isEmpty) {
                      return const Column(
                        children: [
                          Skeleton(height: 64),
                          SizedBox(height: RoveSpacing.sm),
                          Skeleton(height: 64),
                        ],
                      );
                    }
                    return RadioGroup<String>(
                      groupValue: _selected,
                      onChanged: (v) => setState(() => _selected = v),
                      child: ListView.separated(
                        itemCount: state.countries.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: RoveSpacing.sm),
                        itemBuilder: (context, i) {
                          final country = state.countries[i];
                          final selected = country.code == _selected;
                          return Material(
                            color: selected
                                ? RoveColors.primaryTint
                                : RoveColors.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: RoveRadius.cardAll,
                              side: BorderSide(
                                color: selected
                                    ? RoveColors.primary
                                    : RoveColors.border,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: RadioListTile<String>(
                              key: ValueKey('country-${country.code}'),
                              value: country.code,
                              title: Text(country.name, style: text.titleSmall),
                              subtitle: Text(
                                country.cities.map((c) => c.name).join(' · '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              secondary: Text(
                                country.currency,
                                style: text.labelMedium?.copyWith(
                                  color: RoveColors.textSecondary,
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              RoveButton(
                label: l10n.continueLabel,
                expand: true,
                onPressed: _selected == null ? null : _continue,
              ),
              const SizedBox(height: RoveSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
