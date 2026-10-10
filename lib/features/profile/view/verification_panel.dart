import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/utils/document_picker.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/profile.dart';
import '../bloc/verification_cubit.dart';

/// Required documents for the customer's country with their status and an
/// upload action. Used in checkout and in the profile.
class VerificationPanel extends StatelessWidget {
  const VerificationPanel({super.key});

  static PillTone toneFor(DocumentStatus status) => switch (status) {
    DocumentStatus.approved => PillTone.success,
    DocumentStatus.submitted => PillTone.info,
    DocumentStatus.rejected || DocumentStatus.expired => PillTone.danger,
    _ => PillTone.neutral,
  };

  Future<void> _upload(BuildContext context, RequiredDocument doc) async {
    final cubit = context.read<VerificationCubit>();
    final picked = await pickDocument(context);
    if (picked == null) return;
    await cubit.upload(
      doc.documentType,
      picked.file,
      deleteAfter: picked.deleteAfterUpload,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<VerificationCubit, VerificationCubitState>(
      builder: (context, state) {
        final verification = state.verification;
        if (verification == null) {
          if (state.status == LoadStatus.failure) {
            return ErrorState(
              failure: state.failure!,
              onRetry: context.read<VerificationCubit>().load,
            );
          }
          return const ListSkeleton(rows: 2);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final doc in verification.requiredDocuments) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: RoveSpacing.sm),
                child: Row(
                  children: [
                    const Icon(Icons.badge_outlined),
                    const SizedBox(width: RoveSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc.label, style: text.bodyLarge),
                          const SizedBox(height: RoveSpacing.xxs),
                          StatusPill(
                            label: l10n.documentStatus(doc.status),
                            tone: toneFor(doc.status),
                          ),
                          if (doc.rejectionReason != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                l10n.docRejectedReason(doc.rejectionReason!),
                                style: text.bodySmall?.copyWith(
                                  color: context.colors.danger,
                                ),
                              ),
                            ),
                          if (state.uploadFailure != null &&
                              state.uploadFailureType == doc.documentType)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                l10n.failure(state.uploadFailure!),
                                style: text.bodySmall?.copyWith(
                                  color: context.colors.danger,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    RoveButton.secondary(
                      key: ValueKey('upload-${doc.documentType}'),
                      label: doc.status == DocumentStatus.missing
                          ? l10n.uploadDocument
                          : l10n.replaceDocument,
                      loading: state.uploadingType == doc.documentType,
                      onPressed: state.uploadingType != null
                          ? null
                          : () => _upload(context, doc),
                    ),
                  ],
                ),
              ),
            ],
            if (verification.allowsBooking) ...[
              const SizedBox(height: RoveSpacing.sm),
              InlineNotice(
                message: l10n.verificationReady,
                tone: NoticeTone.success,
              ),
            ],
          ],
        );
      },
    );
  }
}
