import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/hero_image.dart';
import '../../../core/widgets/rove_button.dart';

/// Full-bleed dark hero, wordmark and tagline low, "Get started" and
/// "Log in" pills (DESIGN v2).
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const HeroImage(
            RoveAssets.welcomeHero,
            fallbackIcon: Icons.route_outlined,
          ),
          // A dark scrim only behind the text and buttons, for contrast.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.45, 1],
                colors: [Colors.transparent, c.background],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(RoveSpacing.lg),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car_filled_rounded,
                        color: c.textPrimary,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Semantics(
                        header: true,
                        child: Text(l10n.appName, style: text.displaySmall),
                      ),
                    ],
                  ),
                  const SizedBox(height: RoveSpacing.xs),
                  Text(
                    l10n.welcomeTagline,
                    textAlign: TextAlign.center,
                    style: text.bodyLarge?.copyWith(color: c.textSecondary),
                  ),
                  const SizedBox(height: RoveSpacing.xl),
                  RoveButton(
                    key: const Key('welcome-get-started'),
                    label: l10n.welcomeGetStarted,
                    expand: true,
                    onPressed: () => context.push(Routes.onboarding),
                  ),
                  const SizedBox(height: RoveSpacing.sm),
                  RoveButton.outlined(
                    key: const Key('welcome-log-in'),
                    label: l10n.logIn,
                    expand: true,
                    onPressed: () => context.push(Routes.signIn),
                  ),
                  const SizedBox(height: RoveSpacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
