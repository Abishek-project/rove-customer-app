import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

/// The Rove wordmark, set in type (no image asset needed).
class RoveWordmark extends StatelessWidget {
  const RoveWordmark({super.key, this.size = 28, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Rove',
      header: true,
      excludeSemantics: true,
      child: Text(
        'rove',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: size,
          fontWeight: FontWeight.w600,
          color: color ?? context.colors.primary,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}
