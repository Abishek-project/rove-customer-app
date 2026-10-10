import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_wordmark.dart';
import '../../../core/widgets/state_views.dart';
import '../../authentication/bloc/auth_bloc.dart';

/// Shown while the session is restored. If the profile can't be loaded
/// (e.g. offline at launch) it offers a retry instead of guessing.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final failed = state.status == AuthStatus.profileLoadFailed;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(RoveSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const RoveWordmark(size: 40),
                    const SizedBox(height: RoveSpacing.xl),
                    if (!failed)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else ...[
                      if (state.failure != null)
                        ErrorState(failure: state.failure!, compact: true),
                      const SizedBox(height: RoveSpacing.md),
                      RoveButton(
                        label: context.l10n.retry,
                        loading: state.submitting,
                        onPressed: () => context.read<AuthBloc>().add(
                          const AuthProfileRefreshRequested(),
                        ),
                      ),
                      RoveButton.text(
                        label: context.l10n.profileSignOut,
                        onPressed: () => context.read<AuthBloc>().add(
                          const AuthSignOutRequested(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
