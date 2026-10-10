import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/rove_tokens.dart';

/// Text input with the label above and helper/error text below (no
/// floating-label animation, per the design direction).
class RoveTextField extends StatelessWidget {
  const RoveTextField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.hint,
    this.helper,
    this.errorText,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.autofillHints,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.fieldKey,
  });

  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final String? helper;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium),
        const SizedBox(height: RoveSpacing.xs),
        TextFormField(
          key: fieldKey,
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          textCapitalization: textCapitalization,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helper,
            helperMaxLines: 2,
            errorText: errorText,
            errorMaxLines: 2,
            suffixIcon: suffixIcon,
            counterText: '',
          ),
        ),
      ],
    );
  }
}

/// A tappable read-only field (date, city, time pickers).
class RoveSelectField extends StatelessWidget {
  const RoveSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.placeholder,
    this.icon,
    this.errorText,
  });

  final String label;
  final String? value;
  final String? placeholder;
  final VoidCallback? onTap;
  final IconData? icon;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasValue = value != null && value!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium),
        const SizedBox(height: RoveSpacing.xs),
        Semantics(
          button: true,
          label: label,
          value: hasValue ? value : placeholder,
          excludeSemantics: true,
          child: Material(
            color: context.colors.inputFill,
            shape: RoundedRectangleBorder(
              borderRadius: RoveRadius.smallAll,
              side: errorText != null
                  ? BorderSide(color: context.colors.danger)
                  : BorderSide.none,
            ),
            child: InkWell(
              borderRadius: RoveRadius.smallAll,
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        hasValue ? value! : (placeholder ?? ''),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: hasValue
                              ? context.colors.textPrimary
                              : context.colors.textTertiary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(icon ?? Icons.expand_more_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: RoveSpacing.xxs),
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.colors.danger,
            ),
          ),
        ],
      ],
    );
  }
}
