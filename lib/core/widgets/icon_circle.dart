import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

/// An icon button in a 44 px `surface-2` circle (DESIGN v2).
class IconCircle extends StatelessWidget {
  const IconCircle({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
    this.background,
    this.size = 44,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? background;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: tooltip,
      excludeSemantics: true,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: background ?? c.inputFill,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(icon, size: 20, color: color ?? c.textPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
