import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_wordmark.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(RoveSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: RoveSpacing.lg),
              const RoveWordmark(),
              const Spacer(),
              Text(l10n.welcomeTitle, style: text.headlineMedium),
              const SizedBox(height: RoveSpacing.sm),
              Text(
                l10n.welcomeBody,
                style: text.bodyLarge?.copyWith(
                  color: RoveColors.textSecondary,
                ),
              ),
              const SizedBox(height: RoveSpacing.xl),
              RoveButton(
                label: l10n.welcomeGetStarted,
                expand: true,
                onPressed: () => context.push(Routes.country),
              ),
              const SizedBox(height: RoveSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
