import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/hero_image.dart';
import '../../../core/widgets/rove_button.dart';

/// Three short pages: big car image, headline, one muted line, dots.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == 2) {
      context.push(Routes.country);
    } else {
      _controller.nextPage(duration: RoveMotion.normal, curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    final pages = [
      (l10n.onboarding1Title, l10n.onboarding1Body),
      (l10n.onboarding2Title, l10n.onboarding2Body),
      (l10n.onboarding3Title, l10n.onboarding3Body),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: RoveButton.text(
                  key: const Key('onboarding-skip'),
                  label: l10n.skip,
                  onPressed: () => context.push(Routes.country),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: RoveSpacing.page,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(RoveRadius.sheet),
                          child: SizedBox.expand(
                            child: HeroImage(RoveAssets.onboarding[i]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      child: Text(pages[i].$1, style: text.headlineMedium),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: Text(
                        pages[i].$2,
                        style: text.bodyLarge?.copyWith(color: c.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: RoveSpacing.lg),
            Semantics(
              label: l10n.onboardingPage(_page + 1, pages.length),
              excludeSemantics: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < pages.length; i++)
                    AnimatedContainer(
                      duration: RoveMotion.fast,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _page ? c.primary : c.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(RoveSpacing.lg),
              child: RoveButton(
                key: const Key('onboarding-next'),
                label: _page == 2 ? l10n.welcomeGetStarted : l10n.next,
                expand: true,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
