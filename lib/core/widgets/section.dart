import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

/// A section title with an optional trailing action, spaced (no dividers).
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.padding = const EdgeInsetsDirectional.only(
      top: RoveSpacing.lg,
      bottom: RoveSpacing.sm,
    ),
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(title, style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}

/// Label on the left, value on the right.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
    this.emphasize = false,
  });

  final String label;
  final String? value;
  final Widget? trailing;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: RoveSpacing.xs - 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: text.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: RoveSpacing.md),
          if (trailing != null)
            trailing!
          else
            Flexible(
              child: Text(
                value ?? '',
                textAlign: TextAlign.end,
                style: emphasize ? text.titleSmall : text.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}

/// A white surface with a hairline border (no shadow).
class RoveCard extends StatelessWidget {
  const RoveCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(RoveSpacing.md),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// A short paragraph in secondary text.
class MutedText extends StatelessWidget {
  const MutedText(this.text, {super.key, this.small = false});

  final String text;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Text(
      text,
      style: (small ? theme.bodySmall : theme.bodyMedium)?.copyWith(
        color: context.colors.textSecondary,
      ),
    );
  }
}

/// Sticky bottom area holding the screen's single primary action.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child, this.leading});

  final Widget child;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: context.colors.background),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: leading == null
              ? child
              : Row(
                  children: [
                    Expanded(child: leading!),
                    const SizedBox(width: RoveSpacing.md),
                    child,
                  ],
                ),
        ),
      ),
    );
  }
}
