import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../onboarding/bloc/countries_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.signOutConfirm),
        actions: [
          RoveButton.text(
            label: l10n.cancel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          RoveButton(
            key: const Key('sign-out-confirm'),
            label: l10n.profileSignOut,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      context.read<AuthBloc>().add(const AuthSignOutRequested());
    }
  }

  Future<void> _requestDeletion(BuildContext context) async {
    final l10n = context.l10n;
    final auth = context.read<AuthBloc>();
    final repo = context.read<ProfileRepository>();
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccountTitle),
        content: Text(l10n.deleteAccountBody),
        actions: [
          RoveButton.text(
            label: l10n.cancel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          RoveButton(
            key: const Key('delete-confirm'),
            label: l10n.deleteAccountConfirm,
            destructive: true,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await repo.requestDeletion();
      auth.add(const AuthProfileRefreshRequested());
    } on ApiFailure catch (f) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.failure(f))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final me = context.select<AuthBloc, Me?>((b) => b.state.me);
    final countries = context.watch<CountriesCubit>().state;
    final profile = me?.profile ?? const CustomerProfile();
    final country = countries.byCode(profile.countryCode);
    final city = country?.cityById(profile.cityId);
    final deletion = profile.deletionRequestedAt;
    Widget tile(
      IconData icon,
      String label,
      VoidCallback onTap, {
      Widget? trailing,
      Key? key,
    }) => ListTile(
      key: key,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(label),
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: RoveSpacing.md),
        children: [
          const SizedBox(height: RoveSpacing.sm),
          Text(profile.fullName ?? '', style: text.titleLarge),
          if (me?.user.email != null) MutedText(me!.user.email!),
          if (profile.phone != null) MutedText(profile.phone!),
          if (country != null)
            MutedText(
              [city?.name, country.name].whereType<String>().join(', '),
            ),
          const SizedBox(height: RoveSpacing.sm),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: RoveButton.secondary(
              key: const Key('profile-edit'),
              label: l10n.profileEdit,
              onPressed: () => context.push(Routes.profileEdit),
            ),
          ),
          if (deletion != null) ...[
            const SizedBox(height: RoveSpacing.md),
            InlineNotice(
              message: l10n.deletionRequestedOn(
                ZonedTime.formatDate(
                  deletion,
                  country?.timezone,
                  locale: context.localeTag,
                ),
              ),
              tone: NoticeTone.warning,
            ),
          ],
          const SizedBox(height: RoveSpacing.md),
          tile(
            Icons.badge_outlined,
            l10n.profileVerification,
            () => context.push(Routes.verification),
            trailing: StatusPill(
              label: l10n.verificationStatus(profile.verificationStatus),
              tone: switch (profile.verificationStatus) {
                VerificationStatus.verified => PillTone.success,
                VerificationStatus.submitted => PillTone.info,
                VerificationStatus.rejected => PillTone.danger,
                _ => PillTone.neutral,
              },
            ),
          ),
          tile(
            Icons.receipt_long_outlined,
            l10n.profileBookingHistory,
            () => context.go(Routes.bookings),
          ),
          tile(
            Icons.favorite_border_rounded,
            l10n.savedTitle,
            () => context.go(Routes.saved),
          ),
          tile(
            Icons.tune_rounded,
            l10n.profileSettings,
            () => context.push(Routes.settings),
            key: const Key('profile-settings'),
          ),
          tile(
            Icons.support_agent_outlined,
            l10n.profileSupport,
            () => context.push(Routes.support),
            key: const Key('profile-support'),
          ),
          tile(
            Icons.privacy_tip_outlined,
            l10n.profilePrivacy,
            () => context.push(Routes.privacy),
          ),
          tile(
            Icons.description_outlined,
            l10n.profileTerms,
            () => context.push(Routes.terms),
          ),
          const SizedBox(height: RoveSpacing.lg),
          RoveButton.secondary(
            key: const Key('profile-sign-out'),
            label: l10n.profileSignOut,
            expand: true,
            onPressed: () => _signOut(context),
          ),
          if (deletion == null)
            RoveButton.text(
              key: const Key('profile-delete'),
              label: l10n.deleteAccount,
              destructive: true,
              expand: true,
              onPressed: () => _requestDeletion(context),
            ),
          const SizedBox(height: RoveSpacing.xl),
          Center(
            child: Text(
              l10n.appName,
              style: text.bodySmall?.copyWith(color: RoveColors.textTertiary),
            ),
          ),
          const SizedBox(height: RoveSpacing.lg),
        ],
      ),
    );
  }
}
