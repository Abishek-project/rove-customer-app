import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

/// Large left-aligned page title for tab roots (Saved, Bookings, Profile).
class LargeTitle extends StatelessWidget {
  const LargeTitle(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// A `surface` card holding rows, with an optional group title.
class RowGroup extends StatelessWidget {
  const RowGroup({super.key, required this.children, this.title});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: RoveSpacing.md),
      child: Material(
        color: context.colors.surface,
        borderRadius: RoveRadius.cardAll,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

/// Icon in a circle, label, optional trailing, chevron.
class GroupRow extends StatelessWidget {
  const GroupRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.destructive = false,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool destructive;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = destructive ? c.danger : c.textPrimary;
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: c.inputFill,
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?trailing,
          if (showChevron)
            Icon(Icons.chevron_right_rounded, color: c.textSecondary),
        ],
      ),
      onTap: onTap,
    );
  }
}
