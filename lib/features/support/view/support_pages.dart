import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../shared/repositories/support_repository.dart';
import '../bloc/support_cubit.dart';

/// Help and support: the customer's requests and a way to open one.
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) =>
          SupportCubit(context.read<SupportRepository>())..load(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(l10n.supportTitle)),
          body: BlocBuilder<SupportCubit, SupportState>(
            builder: (context, state) {
              final cubit = context.read<SupportCubit>();
              final Widget list;
              switch (state.status) {
                case LoadStatus.initial:
                case LoadStatus.loading:
                  list = const ListSkeleton(rows: 2);
                case LoadStatus.failure:
                  list = ErrorState(
                    failure: state.failure!,
                    onRetry: cubit.load,
                    compact: true,
                  );
                case LoadStatus.empty:
                  list = MutedText(l10n.supportEmpty);
                case LoadStatus.success:
                  list = Column(
                    children: [
                      for (final r in state.requests)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(r.subject),
                          subtitle: Text(
                            r.createdAt == null
                                ? r.message
                                : ZonedTime.formatDate(
                                    r.createdAt!,
                                    null,
                                    locale: context.localeTag,
                                  ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: StatusPill(
                            label: l10n.supportStatus(r.status),
                          ),
                        ),
                    ],
                  );
              }
              return RefreshIndicator(
                onRefresh: cubit.load,
                child: ListView(
                  padding: const EdgeInsets.all(RoveSpacing.md),
                  children: [
                    RoveButton(
                      key: const Key('support-new'),
                      label: l10n.supportNewRequest,
                      icon: Icons.add_rounded,
                      onPressed: () async {
                        await context.push(Routes.supportNew);
                        await cubit.load();
                      },
                    ),
                    SectionHeader(title: l10n.supportYourRequests),
                    list,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NewSupportRequestPage extends StatelessWidget {
  const NewSupportRequestPage({
    super.key,
    this.bookingId,
    this.bookingReference,
  });

  final String? bookingId;
  final String? bookingReference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupportCubit(context.read<SupportRepository>()),
      child: _NewRequestForm(
        bookingId: bookingId,
        bookingReference: bookingReference,
      ),
    );
  }
}

class _NewRequestForm extends StatefulWidget {
  const _NewRequestForm({this.bookingId, this.bookingReference});

  final String? bookingId;
  final String? bookingReference;

  @override
  State<_NewRequestForm> createState() => _NewRequestFormState();
}

class _NewRequestFormState extends State<_NewRequestForm> {
  final _formKey = GlobalKey<FormState>();
  late final _subject = TextEditingController(
    text: widget.bookingReference == null
        ? ''
        : context.l10n.supportAboutBooking(widget.bookingReference!),
  );
  final _message = TextEditingController();

  @override
  void dispose() {
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final ok = await context.read<SupportCubit>().send(
      subject: _subject.text.trim(),
      message: _message.text.trim(),
      bookingId: widget.bookingId,
    );
    if (ok) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.supportSent)));
      router.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SupportCubit>().state;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.supportNewRequest)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(RoveSpacing.md),
          children: [
            if (state.sendFailure != null) ...[
              InlineNotice(
                message: l10n.failure(state.sendFailure!),
                tone: NoticeTone.danger,
              ),
              const SizedBox(height: RoveSpacing.md),
            ],
            RoveTextField(
              fieldKey: const Key('support-subject'),
              label: l10n.supportSubject,
              controller: _subject,
              maxLength: 120,
              validator: (v) {
                final e = Validators.supportSubject(v);
                return e == null ? null : l10n.fieldError(e);
              },
            ),
            const SizedBox(height: RoveSpacing.md),
            RoveTextField(
              fieldKey: const Key('support-message'),
              label: l10n.supportMessage,
              controller: _message,
              minLines: 5,
              maxLines: 10,
              maxLength: 2000,
              validator: (v) {
                final e = Validators.supportMessage(v);
                return e == null ? null : l10n.fieldError(e);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: RoveButton(
          key: const Key('support-send'),
          label: l10n.supportSend,
          expand: true,
          loading: state.sending,
          onPressed: _send,
        ),
      ),
    );
  }
}

class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.privacy});

  final bool privacy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(privacy ? l10n.privacyTitle : l10n.termsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(RoveSpacing.md),
        children: [
          Text(
            privacy ? l10n.privacyBody : l10n.termsBody,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: RoveColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
