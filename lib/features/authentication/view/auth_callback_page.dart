import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../bloc/auth_bloc.dart';

/// Shown while Google sign-in is open in the browser. The session itself is
/// exchanged by Supabase when `com.rove.customer://login-callback` opens the
/// app. Returning without a session counts as a cancelled sign-in.
class AuthCallbackPage extends StatefulWidget {
  const AuthCallbackPage({super.key});

  @override
  State<AuthCallbackPage> createState() => _AuthCallbackPageState();
}

class _AuthCallbackPageState extends State<AuthCallbackPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AuthBloc>().add(const AuthOAuthResumed());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(RoveSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(height: RoveSpacing.lg),
                Text(
                  l10n.signInCompleting,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: RoveSpacing.xs),
                MutedText(l10n.signInWaiting),
                const SizedBox(height: RoveSpacing.lg),
                RoveButton.text(
                  label: l10n.cancel,
                  onPressed: () =>
                      context.read<AuthBloc>().add(const AuthOAuthAbandoned()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
