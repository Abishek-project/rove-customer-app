import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/section.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../bloc/verification_cubit.dart';
import 'verification_panel.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) =>
          VerificationCubit(context.read<ProfileRepository>())..load(),
      child: BlocListener<VerificationCubit, VerificationCubitState>(
        listenWhen: (a, b) =>
            a.verification?.status != b.verification?.status &&
            a.verification != null,
        // Keep the profile's verification badge in sync.
        listener: (context, _) =>
            context.read<AuthBloc>().add(const AuthProfileRefreshRequested()),
        child: Scaffold(
          appBar: AppBar(title: Text(l10n.verificationTitle)),
          body: ListView(
            padding: const EdgeInsets.all(RoveSpacing.md),
            children: [
              MutedText(l10n.verificationBody),
              const SizedBox(height: RoveSpacing.md),
              const VerificationPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
