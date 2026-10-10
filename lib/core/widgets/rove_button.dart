import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

enum RoveButtonVariant { primary, secondary, text }

/// The app's button. Shows a spinner and ignores taps while [loading], which
/// is how double submissions are prevented at the UI level.
class RoveButton extends StatelessWidget {
  const RoveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = RoveButtonVariant.primary,
    this.loading = false,
    this.expand = false,
    this.icon,
    this.destructive = false,
  });

  const RoveButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.expand = false,
    this.icon,
    this.destructive = false,
  }) : variant = RoveButtonVariant.secondary;

  const RoveButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.expand = false,
    this.icon,
    this.destructive = false,
  }) : variant = RoveButtonVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final RoveButtonVariant variant;
  final bool loading;
  final bool expand;
  final IconData? icon;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !loading;
    final foreground = switch (variant) {
      RoveButtonVariant.primary => Colors.white,
      _ => destructive ? RoveColors.danger : null,
    };
    final child = AnimatedSwitcher(
      duration: RoveMotion.fast,
      child: loading
          ? SizedBox(
              key: const ValueKey('loading'),
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: variant == RoveButtonVariant.primary
                    ? Colors.white
                    : RoveColors.primary,
              ),
            )
          : Row(
              key: const ValueKey('label'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: foreground),
                  const SizedBox(width: RoveSpacing.xs),
                ],
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
    );
    final callback = enabled ? onPressed : null;
    final button = switch (variant) {
      RoveButtonVariant.primary => FilledButton(
        onPressed: loading ? () {} : callback,
        style: destructive
            ? FilledButton.styleFrom(backgroundColor: RoveColors.danger)
            : null,
        child: child,
      ),
      RoveButtonVariant.secondary => OutlinedButton(
        onPressed: loading ? () {} : callback,
        style: destructive
            ? OutlinedButton.styleFrom(foregroundColor: RoveColors.danger)
            : null,
        child: child,
      ),
      RoveButtonVariant.text => TextButton(
        onPressed: loading ? () {} : callback,
        style: destructive
            ? TextButton.styleFrom(foregroundColor: RoveColors.danger)
            : null,
        child: child,
      ),
    };
    return Semantics(
      button: true,
      enabled: enabled,
      label: loading ? label : null,
      excludeSemantics: loading,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
