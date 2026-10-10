import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utils/phone_examples.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/models/reference.dart';
import '../../onboarding/bloc/countries_cubit.dart';

/// Name, phone, country and city — shared by profile completion and edit.
class ProfileFields extends StatefulWidget {
  const ProfileFields({
    super.key,
    required this.initial,
    required this.onSubmit,
    required this.submitLabel,
    this.submitting = false,
    this.serverErrors = const {},
  });

  final CustomerProfile initial;
  final ValueChanged<ProfileUpdate> onSubmit;
  final String submitLabel;
  final bool submitting;
  final Map<String, List<String>> serverErrors;

  @override
  State<ProfileFields> createState() => _ProfileFieldsState();
}

class _ProfileFieldsState extends State<ProfileFields> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial.fullName);
  late final _phone = TextEditingController(text: widget.initial.phone);
  late String? _country = widget.initial.countryCode;
  late String? _cityId = widget.initial.cityId;

  @override
  void initState() {
    super.initState();
    context.read<CountriesCubit>().load();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      ProfileUpdate(
        fullName: _name.text.trim(),
        phone: _phone.text.trim(),
        countryCode: _country,
        cityId: _cityId,
      ),
    );
  }

  String? _server(String field) => widget.serverErrors[field]?.join(', ');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final countries = context.select<CountriesCubit, List<Country>>(
      (c) => c.state.countries,
    );
    final country = countries.where((c) => c.code == _country).firstOrNull;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoveTextField(
            fieldKey: const Key('profile-name'),
            label: l10n.fullNameLabel,
            controller: _name,
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.name],
            textInputAction: TextInputAction.next,
            errorText: _server('fullName'),
            validator: (v) {
              final e = Validators.fullName(v);
              return e == null ? null : l10n.fieldError(e);
            },
          ),
          const SizedBox(height: RoveSpacing.md),
          RoveTextField(
            fieldKey: const Key('profile-phone'),
            label: l10n.phoneLabel,
            controller: _phone,
            keyboardType: TextInputType.phone,
            autofillHints: const [AutofillHints.telephoneNumber],
            helper: l10n.phoneHelper(phoneExample(_country)),
            errorText: _server('phone'),
            validator: (v) {
              final e = Validators.phone(v);
              return e == null ? null : l10n.fieldError(e);
            },
          ),
          const SizedBox(height: RoveSpacing.md),
          _Dropdown<String>(
            key: const Key('profile-country'),
            label: l10n.countryLabel,
            value: _country,
            items: {for (final c in countries) c.code: c.name},
            errorText: _server('countryCode'),
            onChanged: (v) => setState(() {
              if (v != _country) _cityId = null;
              _country = v;
            }),
            validator: (v) => v == null ? l10n.fieldRequired : null,
          ),
          const SizedBox(height: RoveSpacing.md),
          _Dropdown<String>(
            key: Key('profile-city-$_country'),
            label: l10n.cityLabel,
            value: country?.cityById(_cityId)?.id,
            items: {for (final c in country?.cities ?? <City>[]) c.id: c.name},
            onChanged: (v) => setState(() => _cityId = v),
          ),
          const SizedBox(height: RoveSpacing.xl),
          RoveButton(
            key: const Key('profile-submit'),
            label: widget.submitLabel,
            expand: true,
            loading: widget.submitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.errorText,
  });

  final String label;
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: RoveSpacing.xs),
        DropdownButtonFormField<T>(
          initialValue: items.containsKey(value) ? value : null,
          isExpanded: true,
          decoration: InputDecoration(errorText: errorText),
          borderRadius: RoveRadius.smallAll,
          dropdownColor: context.colors.surface,
          hint: Text(context.l10n.notSet),
          items: [
            for (final e in items.entries)
              DropdownMenuItem(value: e.key, child: Text(e.value)),
          ],
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
