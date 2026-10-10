import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/money/money.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/section.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/repositories/vehicle_repository.dart';
import '../../onboarding/bloc/countries_cubit.dart';
import '../bloc/search_bloc.dart';

/// Edits a copy of the current query; "Show results" runs a new search.
class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  late VehicleQuery _query;
  late final TextEditingController _budget;
  String? _budgetError;

  static const seatOptions = [2, 4, 5, 7];

  @override
  void initState() {
    super.initState();
    _query = context.read<SearchBloc>().state.query!;
    final max = _query.maxDailyRateMinor;
    _budget = TextEditingController(
      text: max == null ? '' : (max ~/ 100).toString(),
    );
  }

  @override
  void dispose() {
    _budget.dispose();
    super.dispose();
  }

  void _apply() {
    final raw = _budget.text.trim();
    int? maxMinor;
    if (raw.isNotEmpty) {
      maxMinor = MoneyFormatter.parseMajorToMinor(raw);
      if (maxMinor == null || maxMinor <= 0) {
        setState(() => _budgetError = context.l10n.filterBudgetInvalid);
        return;
      }
    }
    final query = _query.copyWith(maxDailyRateMinor: () => maxMinor, page: 1);
    context.read<SearchBloc>().add(SearchRequested(query));
    context.pop();
  }

  void _reset() {
    setState(() {
      _query = _query.clearFilters();
      _budget.clear();
      _budgetError = null;
    });
  }

  Widget _chips<T>({
    required String title,
    required List<T> values,
    required T? selected,
    required String Function(T) label,
    required ValueChanged<T?> onSelected,
    required String keyPrefix,
  }) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: title),
        Wrap(
          spacing: RoveSpacing.xs,
          runSpacing: RoveSpacing.xs,
          children: [
            ChoiceChip(
              key: Key('$keyPrefix-any'),
              label: Text(l10n.anyOption),
              selected: selected == null,
              onSelected: (_) => onSelected(null),
            ),
            for (final v in values)
              ChoiceChip(
                key: Key('$keyPrefix-$v'),
                label: Text(label(v)),
                selected: selected == v,
                onSelected: (_) => onSelected(v),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currency =
        context
            .read<CountriesCubit>()
            .state
            .byCode(_query.countryCode)
            ?.currency ??
        '';
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.filtersTitle),
        leading: IconButton(
          tooltip: l10n.close,
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [RoveButton.text(label: l10n.reset, onPressed: _reset)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          RoveSpacing.md,
          0,
          RoveSpacing.md,
          RoveSpacing.xl,
        ),
        children: [
          _chips<VehicleCategory>(
            title: l10n.filterCategory,
            values: VehicleCategoryWire.browsable,
            selected: _query.category,
            label: l10n.category,
            keyPrefix: 'filter-category',
            onSelected: (v) =>
                setState(() => _query = _query.copyWith(category: () => v)),
          ),
          _chips<Transmission>(
            title: l10n.filterTransmission,
            values: const [Transmission.automatic, Transmission.manual],
            selected: _query.transmission,
            label: l10n.transmission,
            keyPrefix: 'filter-transmission',
            onSelected: (v) =>
                setState(() => _query = _query.copyWith(transmission: () => v)),
          ),
          _chips<int>(
            title: l10n.filterSeats,
            values: seatOptions,
            selected: _query.minSeats,
            label: l10n.filterSeatsAtLeast,
            keyPrefix: 'filter-seats',
            onSelected: (v) =>
                setState(() => _query = _query.copyWith(minSeats: () => v)),
          ),
          _chips<FuelType>(
            title: l10n.filterFuel,
            values: const [
              FuelType.petrol,
              FuelType.diesel,
              FuelType.hybrid,
              FuelType.electric,
            ],
            selected: _query.fuelType,
            label: l10n.fuel,
            keyPrefix: 'filter-fuel',
            onSelected: (v) =>
                setState(() => _query = _query.copyWith(fuelType: () => v)),
          ),
          const SizedBox(height: RoveSpacing.lg),
          RoveTextField(
            fieldKey: const Key('filter-budget'),
            label: l10n.filterBudget(currency),
            controller: _budget,
            hint: l10n.filterBudgetHint,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            errorText: _budgetError,
            onChanged: (_) {
              if (_budgetError != null) setState(() => _budgetError = null);
            },
          ),
          const SizedBox(height: RoveSpacing.md),
          SwitchListTile(
            key: const Key('filter-delivery'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.filterDelivery),
            value: _query.deliveryAvailable == true,
            onChanged: (v) => setState(
              () => _query = _query.copyWith(
                deliveryAvailable: () => v ? true : null,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        child: RoveButton(
          key: const Key('filters-apply'),
          label: l10n.showResults,
          expand: true,
          onPressed: _apply,
        ),
      ),
    );
  }
}
