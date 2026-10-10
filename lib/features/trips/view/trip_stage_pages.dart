import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/price_breakdown.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/repositories/booking_repository.dart';
import '../bloc/booking_detail_cubit.dart';

enum TripStage { pickup, returning, receipt }

/// Pickup, return and receipt screens. They only display what the backend
/// reports; the customer cannot record inspections themselves.
class TripStagePage extends StatelessWidget {
  const TripStagePage({
    super.key,
    required this.bookingId,
    required this.stage,
  });

  final String bookingId;
  final TripStage stage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = switch (stage) {
      TripStage.pickup => l10n.pickupTitle,
      TripStage.returning => l10n.returnTitle,
      TripStage.receipt => l10n.receiptTitle,
    };
    return BlocProvider(
      create: (context) =>
          BookingDetailCubit(context.read<BookingRepository>(), bookingId)
            ..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: BlocBuilder<BookingDetailCubit, BookingDetailState>(
          builder: (context, state) {
            final booking = state.booking;
            if (booking == null) {
              return state.status == LoadStatus.failure
                  ? ErrorState(
                      failure: state.failure!,
                      onRetry: context.read<BookingDetailCubit>().load,
                    )
                  : const Padding(
                      padding: EdgeInsets.all(RoveSpacing.md),
                      child: ListSkeleton(),
                    );
            }
            return RefreshIndicator(
              onRefresh: context.read<BookingDetailCubit>().load,
              child: ListView(
                padding: const EdgeInsets.all(RoveSpacing.md),
                children: switch (stage) {
                  TripStage.pickup => _pickup(context, booking),
                  TripStage.returning => _return(context, booking),
                  TripStage.receipt => _receipt(context, booking),
                },
              ),
            );
          },
        ),
      ),
    );
  }

  String _at(BuildContext context, Booking b, DateTime t) =>
      ZonedTime.formatDateTime(t, b.timezone, locale: context.localeTag);

  List<Widget> _pickup(BuildContext context, Booking b) {
    final l10n = context.l10n;
    final report = b.pickupReport;
    return [
      _StageStatus(
        done: report != null,
        doneLabel: report == null
            ? ''
            : l10n.pickupConfirmedAt(_at(context, b, report.recordedAt)),
        pendingLabel: l10n.pickupNotYet,
      ),
      const SizedBox(height: RoveSpacing.sm),
      InfoRow(label: l10n.pickupLabel, value: _at(context, b, b.pickupAt)),
      InfoRow(
        label: l10n.bookingWhere,
        value: b.delivery.enabled
            ? l10n.bookingDeliveryTo(b.delivery.address ?? '')
            : (b.pickupLocation?.name ?? b.city.name),
      ),
      if (!b.delivery.enabled && b.pickupLocation?.address != null)
        MutedText(b.pickupLocation!.address!, small: true),
      SectionHeader(title: l10n.instructionsTitle),
      MutedText(b.pickupInstructions ?? ''),
      if (b.requiredDocuments.isNotEmpty) ...[
        SectionHeader(title: l10n.bringDocuments),
        for (final doc in b.requiredDocuments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.badge_outlined, size: 20),
                const SizedBox(width: RoveSpacing.sm),
                Expanded(child: Text(doc)),
              ],
            ),
          ),
      ],
      SectionHeader(title: l10n.inspectionTitle),
      _Inspection(
        report: report,
        pendingText: l10n.inspectionPendingPickup,
        at: report == null ? null : _at(context, b, report.recordedAt),
      ),
    ];
  }

  List<Widget> _return(BuildContext context, Booking b) {
    final l10n = context.l10n;
    final report = b.returnReport;
    return [
      _StageStatus(
        done: report != null,
        doneLabel: report == null
            ? ''
            : l10n.returnConfirmedAt(_at(context, b, report.recordedAt)),
        pendingLabel: l10n.returnNotYet,
      ),
      const SizedBox(height: RoveSpacing.sm),
      InfoRow(label: l10n.returnLabel, value: _at(context, b, b.returnAt)),
      SectionHeader(title: l10n.instructionsTitle),
      MutedText(b.returnInstructions ?? ''),
      SectionHeader(title: l10n.inspectionTitle),
      _Inspection(
        report: report,
        pendingText: l10n.inspectionPendingReturn,
        at: report == null ? null : _at(context, b, report.recordedAt),
      ),
      SectionHeader(title: l10n.bookingDepositStatus),
      InfoRow(
        label: l10n.detailsDeposit,
        value: null,
        trailing: StatusPill(label: l10n.depositStatus(b.depositStatus)),
      ),
      MutedText(l10n.depositBody, small: true),
    ];
  }

  List<Widget> _receipt(BuildContext context, Booking b) {
    final l10n = context.l10n;
    final charged =
        b.paymentStatus == PaymentStatus.captured ||
        b.paymentStatus == PaymentStatus.partiallyRefunded ||
        b.paymentStatus == PaymentStatus.refunded;
    final settled =
        b.status == BookingStatus.completed &&
        b.depositStatus == DepositStatus.released;
    return [
      InfoRow(label: l10n.referenceLabel, value: b.reference),
      InfoRow(label: l10n.bookingPartner, value: b.partner.displayName),
      InfoRow(
        label: l10n.bookingPaymentStatus,
        value: null,
        trailing: StatusPill(
          label: l10n.paymentStatus(b.paymentStatus),
          tone: paymentStatusTone(b.paymentStatus),
        ),
      ),
      SectionHeader(title: l10n.priceDetails),
      PriceBreakdown(
        lineItems: b.lineItems,
        total: b.total,
        totalLabel: charged ? l10n.receiptCharged : l10n.receiptAuthorized,
        deposit: b.deposit,
        conditionalCharges: b.conditionalCharges,
      ),
      if (b.cancellationFee != null && !b.cancellationFee!.isZero)
        PriceRow(
          label: l10n.bookingCancellationFee,
          amount: b.cancellationFee!,
        ),
      if (b.refund != null && !b.refund!.isZero) ...[
        PriceRow(label: l10n.bookingRefundAmount, amount: b.refund!),
        MutedText(l10n.bookingRefundPending, small: true),
      ],
      SectionHeader(title: l10n.bookingDepositStatus),
      InfoRow(
        label: l10n.detailsDeposit,
        value: null,
        trailing: StatusPill(label: l10n.depositStatus(b.depositStatus)),
      ),
      if (settled) ...[
        SectionHeader(title: l10n.receiptOutstanding),
        Text(l10n.receiptNoOutstanding),
      ],
      const SizedBox(height: RoveSpacing.sm),
      MutedText(l10n.receiptOutstandingSupport, small: true),
    ];
  }
}

class _StageStatus extends StatelessWidget {
  const _StageStatus({
    required this.done,
    required this.doneLabel,
    required this.pendingLabel,
  });

  final bool done;
  final String doneLabel;
  final String pendingLabel;

  @override
  Widget build(BuildContext context) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: StatusPill(
      label: done ? doneLabel : pendingLabel,
      tone: done ? PillTone.success : PillTone.neutral,
    ),
  );
}

class _Inspection extends StatelessWidget {
  const _Inspection({required this.report, required this.pendingText, this.at});

  final ConditionReportSummary? report;
  final String pendingText;
  final String? at;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final r = report;
    if (r == null) return MutedText(pendingText);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MutedText(l10n.inspectionRecorded(at ?? ''), small: true),
        if (r.odometerKm != null)
          InfoRow(
            label: l10n.odometerLabel,
            value: l10n.odometerValue(r.odometerKm!),
          ),
        if (r.fuelLevelPct != null)
          InfoRow(
            label: l10n.fuelLevelLabel,
            value: l10n.fuelLevelValue(r.fuelLevelPct!),
          ),
        InfoRow(
          label: l10n.inspectionTitle,
          value: r.damages.isEmpty
              ? l10n.damagesNone
              : l10n.damagesNoted(r.damages.length),
        ),
        for (final d in r.damages)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: MutedText(
              [
                d.area,
                d.severity,
                d.description,
              ].whereType<String>().join(' · '),
              small: true,
            ),
          ),
        InfoRow(
          label: l10n.photosLabel,
          value: l10n.photosRecorded(r.photoCount),
        ),
      ],
    );
  }
}
