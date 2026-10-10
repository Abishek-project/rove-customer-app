import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';

/// A bundled photo (assets/images/) with a quiet fallback when it's not
/// shipped yet, so layouts never depend on an image being present.
class HeroImage extends StatelessWidget {
  const HeroImage(
    this.asset, {
    super.key,
    this.fallbackIcon = Icons.directions_car_outlined,
  });

  final String asset;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      excludeFromSemantics: true,
      errorBuilder: (_, _, _) => ColoredBox(
        color: c.background,
        child: Center(child: Icon(fallbackIcon, size: 120, color: c.inputFill)),
      ),
    );
  }
}

abstract final class RoveAssets {
  static const welcomeHero = 'assets/images/welcome_hero.jpg';
  static const onboarding = [
    'assets/images/onboarding_1.jpg',
    'assets/images/onboarding_2.jpg',
    'assets/images/onboarding_3.jpg',
  ];
}
