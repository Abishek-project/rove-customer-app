import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/routes.dart';
import '../../../core/config/app_env.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/grouped_list.dart';
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
    final c = context.colors;
    final text = Theme.of(context).textTheme;
    final me = context.select<AuthBloc, Me?>((b) => b.state.me);
    final countries = context.watch<CountriesCubit>().state;
    final profile = me?.profile ?? const CustomerProfile();
    final country = countries.byCode(profile.countryCode);
    final city = country?.cityById(profile.cityId);
    final deletion = profile.deletionRequestedAt;
    final initials = (profile.fullName ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: RoveSpacing.lg),
          children: [
            LargeTitle(l10n.profileTitle),
            Padding(
              padding: RoveSpacing.page,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: RoveSpacing.xs),
                  Material(
                    color: c.surface,
                    borderRadius: RoveRadius.cardAll,
                    child: InkWell(
                      key: const Key('profile-edit'),
                      borderRadius: RoveRadius.cardAll,
                      onTap: () => context.push(Routes.profileEdit),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: c.inputFill,
                              child: Text(initials, style: text.titleMedium),
                            ),
                            const SizedBox(width: RoveSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.fullName ?? '',
                                    style: text.titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    [
                                          me?.user.email,
                                          [
                                            city?.name,
                                            country?.name,
                                          ].whereType<String>().join(', '),
                                        ]
                                        .whereType<String>()
                                        .where((s) => s.isNotEmpty)
                                        .join(' · '),
                                    style: text.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    l10n.showProfile,
                                    style: text.bodyMedium?.copyWith(
                                      color: c.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: c.textSecondary,
                            ),
                          ],
                        ),
                      ),
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
                  RowGroup(
                    title: l10n.settingsGroup,
                    children: [
                      GroupRow(
                        icon: Icons.person_outline_rounded,
                        label: l10n.personalInformation,
                        onTap: () => context.push(Routes.profileEdit),
                      ),
                      GroupRow(
                        key: const Key('profile-verification'),
                        icon: Icons.badge_outlined,
                        label: l10n.profileVerification,
                        onTap: () => context.push(Routes.verification),
                        trailing: StatusPill(
                          label: l10n.verificationStatus(
                            profile.verificationStatus,
                          ),
                          tone: switch (profile.verificationStatus) {
                            VerificationStatus.verified => PillTone.success,
                            VerificationStatus.submitted => PillTone.info,
                            VerificationStatus.rejected => PillTone.danger,
                            _ => PillTone.neutral,
                          },
                        ),
                      ),
                      GroupRow(
                        icon: Icons.credit_card_rounded,
                        label: l10n.paymentMethods,
                        onTap: () => context.push(Routes.paymentMethods),
                      ),
                      GroupRow(
                        key: const Key('profile-settings'),
                        icon: Icons.notifications_none_rounded,
                        label: l10n.settingsNotifications,
                        onTap: () => context.push(Routes.settings),
                      ),
                      GroupRow(
                        icon: Icons.translate_rounded,
                        label: l10n.settingsLanguage,
                        onTap: () => context.push(Routes.settings),
                      ),
                      GroupRow(
                        icon: Icons.public_rounded,
                        label: l10n.countryAndCity,
                        onTap: () => context.push(Routes.settings),
                      ),
                      GroupRow(
                        icon: Icons.dark_mode_outlined,
                        label: l10n.appearance,
                        onTap: () => context.push(Routes.settings),
                      ),
                      GroupRow(
                        icon: Icons.receipt_long_outlined,
                        label: l10n.profileBookingHistory,
                        onTap: () => context.go(Routes.bookings),
                      ),
                    ],
                  ),
                  RowGroup(
                    title: l10n.partnersGroup,
                    children: [
                      GroupRow(
                        icon: Icons.directions_car_outlined,
                        label: l10n.listYourFleet,
                        onTap: () => launchUrl(
                          Uri.parse(context.read<AppEnv>().partnerPortalUrl),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                    ],
                  ),
                  RowGroup(
                    title: l10n.supportGroup,
                    children: [
                      GroupRow(
                        key: const Key('profile-support'),
                        icon: Icons.support_agent_outlined,
                        label: l10n.profileSupport,
                        onTap: () => context.push(Routes.support),
                      ),
                      GroupRow(
                        icon: Icons.privacy_tip_outlined,
                        label: l10n.profilePrivacy,
                        onTap: () => context.push(Routes.privacy),
                      ),
                      GroupRow(
                        icon: Icons.description_outlined,
                        label: l10n.profileTerms,
                        onTap: () => context.push(Routes.terms),
                      ),
                      GroupRow(
                        key: const Key('profile-sign-out'),
                        icon: Icons.logout_rounded,
                        label: l10n.profileSignOut,
                        destructive: true,
                        showChevron: false,
                        onTap: () => _signOut(context),
                      ),
                      if (deletion == null)
                        GroupRow(
                          key: const Key('profile-delete'),
                          icon: Icons.delete_outline_rounded,
                          label: l10n.deleteAccount,
                          destructive: true,
                          showChevron: false,
                          onTap: () => _requestDeletion(context),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
