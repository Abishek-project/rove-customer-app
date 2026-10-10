import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';
import '../errors/api_failure.dart';
import '../localization/l10n.dart';
import 'rove_button.dart';

/// One short line and one action (DESIGN.md: empty states).
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(RoveSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 32, color: context.colors.textTertiary),
              const SizedBox(height: RoveSpacing.md),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: RoveSpacing.md),
              RoveButton.secondary(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error message (never a stack trace) and a retry action.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.failure,
    this.onRetry,
    this.compact = false,
  });

  final ApiFailure failure;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final message = l10n.failure(failure);
    if (compact) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: RoveSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            if (onRetry != null)
              RoveButton.text(label: l10n.retry, onPressed: onRetry),
          ],
        ),
      );
    }
    return EmptyState(
      message: message,
      icon: failure.isNetwork
          ? Icons.wifi_off_rounded
          : Icons.error_outline_rounded,
      actionLabel: onRetry == null ? null : l10n.retry,
      onAction: onRetry,
    );
  }
}

/// Inline banner for errors and notes inside a form or page.
class InlineNotice extends StatelessWidget {
  const InlineNotice({
    super.key,
    required this.message,
    this.tone = NoticeTone.info,
    this.action,
  });

  final String message;
  final NoticeTone tone;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      NoticeTone.info => (context.colors.infoTint, context.colors.info),
      NoticeTone.warning => (
        context.colors.warningTint,
        context.colors.warning,
      ),
      NoticeTone.danger => (context.colors.dangerTint, context.colors.danger),
      NoticeTone.success => (
        context.colors.successTint,
        context.colors.success,
      ),
      NoticeTone.neutral => (
        context.colors.inputFill,
        context.colors.textSecondary,
      ),
    };
    return Semantics(
      liveRegion: tone == NoticeTone.danger,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: RoveSpacing.md,
          vertical: RoveSpacing.sm,
        ),
        decoration: BoxDecoration(color: bg, borderRadius: RoveRadius.smallAll),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: fg),
              ),
            ),
            ?action,
          ],
        ),
      ),
    );
  }
}

enum NoticeTone { info, warning, danger, success, neutral }

class CenteredLoader extends StatelessWidget {
  const CenteredLoader({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          if (label != null) ...[
            const SizedBox(height: RoveSpacing.md),
            Text(
              label!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
