import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/config/app_env.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/rove_wordmark.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/state_views.dart';
import '../../onboarding/bloc/countries_cubit.dart';
import '../bloc/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static String? noticeText(AppLocalizations l10n, AuthNotice? notice) =>
      switch (notice) {
        null => null,
        AuthNotice.cancelled => l10n.signInCancelled,
        AuthNotice.failed => l10n.signInFailed,
        AuthNotice.callbackFailed => l10n.signInCallbackFailed,
        AuthNotice.invalidCredentials => l10n.signInInvalidCredentials,
        AuthNotice.network => l10n.errorNetwork,
        AuthNotice.launchFailed => l10n.signInLaunchFailed,
        AuthNotice.sessionExpired => l10n.errorSessionExpired,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final env = context.read<AppEnv>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final notice = noticeText(l10n, state.notice);
            return ListView(
              padding: const EdgeInsets.all(RoveSpacing.lg),
              children: [
                const SizedBox(height: RoveSpacing.md),
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: RoveWordmark(),
                ),
                const SizedBox(height: RoveSpacing.xxl),
                Text(l10n.signInTitle, style: text.headlineSmall),
                const SizedBox(height: RoveSpacing.xs),
                MutedText(l10n.signInBody),
                const SizedBox(height: RoveSpacing.md),
                const _CountryLine(),
                const SizedBox(height: RoveSpacing.lg),
                if (notice != null) ...[
                  InlineNotice(
                    key: const Key('auth-notice'),
                    message: notice,
                    tone: state.notice == AuthNotice.cancelled
                        ? NoticeTone.neutral
                        : NoticeTone.danger,
                  ),
                  const SizedBox(height: RoveSpacing.md),
                ],
                RoveButton(
                  key: const Key('google-sign-in'),
                  label: l10n.signInGoogle,
                  icon: Icons.account_circle_outlined,
                  expand: true,
                  loading: state.submitting,
                  onPressed: () =>
                      context.read<AuthBloc>().add(const AuthGoogleRequested()),
                ),
                if (env.enableDevEmailLogin) ...[
                  const SizedBox(height: RoveSpacing.xl),
                  _DevEmailForm(submitting: state.submitting),
                ],
                const SizedBox(height: RoveSpacing.xl),
                MutedText(l10n.signInLegal, small: true),
                Wrap(
                  children: [
                    RoveButton.text(
                      label: l10n.profileTerms,
                      onPressed: () => context.push(Routes.terms),
                    ),
                    RoveButton.text(
                      label: l10n.profilePrivacy,
                      onPressed: () => context.push(Routes.privacy),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CountryLine extends StatelessWidget {
  const _CountryLine();

  @override
  Widget build(BuildContext context) {
    final code = context.select<PreferencesCubit, String?>(
      (c) => c.state.countryCode,
    );
    final country = context.select<CountriesCubit, String?>(
      (c) => c.state.byCode(code)?.name,
    );
    if (country == null) return const SizedBox.shrink();
    return Row(
      children: [
        const Icon(Icons.public_rounded, size: 18),
        const SizedBox(width: RoveSpacing.xs),
        Expanded(child: Text(country)),
        RoveButton.text(
          label: context.l10n.change,
          onPressed: () => context.push(Routes.country),
        ),
      ],
    );
  }
}

/// Local development only (`ENABLE_DEV_EMAIL_LOGIN=true`).
class _DevEmailForm extends StatefulWidget {
  const _DevEmailForm({required this.submitting});

  final bool submitting;

  @override
  State<_DevEmailForm> createState() => _DevEmailFormState();
}

class _DevEmailFormState extends State<_DevEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(
      AuthEmailRequested(_email.text, _password.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.signInDevSection,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          const SizedBox(height: RoveSpacing.sm),
          RoveTextField(
            fieldKey: const Key('dev-email'),
            label: l10n.emailLabel,
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.next,
            validator: (v) {
              final e = Validators.email(v);
              return e == null ? null : l10n.fieldError(e);
            },
          ),
          const SizedBox(height: RoveSpacing.md),
          RoveTextField(
            fieldKey: const Key('dev-password'),
            label: l10n.passwordLabel,
            controller: _password,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            textInputAction: TextInputAction.done,
            validator: (v) {
              final e = Validators.requiredText(v);
              return e == null ? null : l10n.fieldError(e);
            },
          ),
          const SizedBox(height: RoveSpacing.md),
          RoveButton.secondary(
            key: const Key('dev-sign-in'),
            label: l10n.signInWithEmail,
            loading: widget.submitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
