import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/preferences/preferences_cubit.dart';
import '../../../core/widgets/state_views.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../bloc/profile_form_cubit.dart';
import 'profile_fields.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile =
        context.read<AuthBloc>().state.me?.profile ?? const CustomerProfile();
    return BlocProvider(
      create: (context) => ProfileFormCubit(context.read<ProfileRepository>()),
      child: BlocConsumer<ProfileFormCubit, ProfileFormState>(
        listenWhen: (a, b) => b.status == SubmitStatus.success,
        listener: (context, state) async {
          final me = state.me!;
          final auth = context.read<AuthBloc>();
          final prefs = context.read<PreferencesCubit>();
          final messenger = ScaffoldMessenger.of(context);
          final router = GoRouter.of(context);
          if (me.profile.countryCode != null) {
            await prefs.setCountry(
              me.profile.countryCode!,
              cityId: me.profile.cityId,
            );
          }
          auth.add(AuthProfileUpdated(me));
          messenger.showSnackBar(SnackBar(content: Text(l10n.profileSaved)));
          router.pop();
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text(l10n.profileEdit)),
          body: ListView(
            padding: const EdgeInsets.all(RoveSpacing.md),
            children: [
              if (state.status == SubmitStatus.failure &&
                  state.fieldErrors.isEmpty) ...[
                InlineNotice(
                  message: l10n.failure(state.failure!),
                  tone: NoticeTone.danger,
                ),
                const SizedBox(height: RoveSpacing.md),
              ],
              ProfileFields(
                initial: profile,
                submitting: state.status == SubmitStatus.submitting,
                serverErrors: state.fieldErrors,
                submitLabel: l10n.save,
                onSubmit: context.read<ProfileFormCubit>().submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
