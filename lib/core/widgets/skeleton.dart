import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

/// A placeholder block with a slow, subtle pulse.
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height = 14,
    this.radius = RoveRadius.small,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final box = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: RoveColors.inputFill,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
    );
    if (reduceMotion) return box;
    return FadeTransition(
      opacity: Tween(begin: 0.55, end: 1.0).animate(_controller),
      child: box,
    );
  }
}

/// Placeholder shaped like a vehicle card.
class VehicleCardSkeleton extends StatelessWidget {
  const VehicleCardSkeleton({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Skeleton(radius: RoveRadius.card),
          ),
          SizedBox(height: RoveSpacing.sm),
          Skeleton(width: 160, height: 16),
          SizedBox(height: RoveSpacing.xs),
          Skeleton(width: 220, height: 12),
        ],
      ),
    );
  }
}

/// A list of generic row placeholders.
class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key, this.rows = 4});

  final int rows;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: MaterialLocalizations.of(context).refreshIndicatorSemanticLabel,
      child: Column(
        children: [
          for (var i = 0; i < rows; i++)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: RoveSpacing.sm),
              child: Row(
                children: [
                  Skeleton(width: 64, height: 48),
                  SizedBox(width: RoveSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(width: 160),
                        SizedBox(height: RoveSpacing.xs),
                        Skeleton(width: 100, height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
