import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/state_views.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../profile/bloc/profile_form_cubit.dart';
import '../../profile/view/profile_fields.dart';
import '../bloc/auth_bloc.dart';

/// Collects only what bookings need: name, phone, country and city.
class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileFormCubit(context.read<ProfileRepository>()),
      child: const _CompleteProfileView(),
    );
  }
}

class _CompleteProfileView extends StatelessWidget {
  const _CompleteProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final me = context.select<AuthBloc, Me?>((b) => b.state.me);
    final preferredCountry = context.read<PreferencesCubit>().state.countryCode;
    final profile = me?.profile ?? const CustomerProfile();
    return BlocListener<ProfileFormCubit, ProfileFormState>(
      listenWhen: (a, b) => b.status == SubmitStatus.success,
      listener: (context, state) async {
        final updated = state.me!;
        final prefs = context.read<PreferencesCubit>();
        final auth = context.read<AuthBloc>();
        final code = updated.profile.countryCode;
        if (code != null) {
          await prefs.setCountry(code, cityId: updated.profile.cityId);
        }
        auth.add(AuthProfileUpdated(updated));
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            RoveButton.text(
              label: l10n.profileSignOut,
              onPressed: () =>
                  context.read<AuthBloc>().add(const AuthSignOutRequested()),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileFormCubit, ProfileFormState>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: RoveSpacing.lg,
                  vertical: RoveSpacing.md,
                ),
                children: [
                  Text(
                    l10n.completeProfileTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: RoveSpacing.xs),
                  MutedText(l10n.completeProfileBody),
                  const SizedBox(height: RoveSpacing.lg),
                  if (state.status == SubmitStatus.failure &&
                      state.fieldErrors.isEmpty) ...[
                    InlineNotice(
                      message: l10n.failure(state.failure!),
                      tone: NoticeTone.danger,
                    ),
                    const SizedBox(height: RoveSpacing.md),
                  ],
                  ProfileFields(
                    initial: profile.copyWith(
                      countryCode: profile.countryCode ?? preferredCountry,
                    ),
                    submitting: state.status == SubmitStatus.submitting,
                    serverErrors: state.fieldErrors,
                    submitLabel: l10n.continueLabel,
                    onSubmit: (update) =>
                        context.read<ProfileFormCubit>().submit(update),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
