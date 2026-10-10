import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/utils/load_status.dart';
import '../../../core/widgets/price_breakdown.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/vehicle_photo.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/repositories/booking_repository.dart';
import '../../booking/bloc/checkout_result.dart';
import '../../booking/view/checkout_page.dart';
import '../bloc/booking_detail_cubit.dart';

class BookingDetailPage extends StatelessWidget {
  const BookingDetailPage({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingDetailCubit(context.read<BookingRepository>(), bookingId)
            ..load(),
      child: const _BookingDetailView(),
    );
  }
}

class _BookingDetailView extends StatelessWidget {
  const _BookingDetailView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<BookingDetailCubit, BookingDetailState>(
      listenWhen: (a, b) =>
          a.cancelStatus != b.cancelStatus &&
          b.cancelStatus == CancelStatus.cancelled,
      listener: (context, _) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.cancelDone))),
      builder: (context, state) {
        final booking = state.booking;
        if (booking == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.bookingTitle)),
            body: state.status == LoadStatus.failure
                ? ErrorState(
                    failure: state.failure!,
                    onRetry: context.read<BookingDetailCubit>().load,
                  )
                : const Padding(
                    padding: EdgeInsets.all(RoveSpacing.md),
                    child: ListSkeleton(),
                  ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(booking.reference)),
          body: RefreshIndicator(
            onRefresh: context.read<BookingDetailCubit>().load,
            child: _Body(booking: booking),
          ),
          bottomNavigationBar: _Actions(booking: booking),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final locale = context.localeTag;
    final tz = booking.timezone;
    String at(DateTime t) => ZonedTime.formatDateTime(t, tz, locale: locale);
    final refund = booking.refund;
    final fee = booking.cancellationFee;
    return ListView(
      padding: const EdgeInsets.all(RoveSpacing.md),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 96,
              child: VehiclePhoto(
                url: booking.vehicle.coverImageUrl,
                semanticLabel: l10n.vehicleImageLabel(booking.vehicle.title),
                radius: RoveRadius.small,
                memCacheWidth: 300,
              ),
            ),
            const SizedBox(width: RoveSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.vehicle.title, style: text.titleSmall),
                  MutedText(
                    '${booking.vehicle.year} · ${booking.partner.displayName}',
                    small: true,
                  ),
                  const SizedBox(height: RoveSpacing.xs),
                  BookingStatusBadge(
                    key: const Key('booking-status'),
                    status: booking.status,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (booking.status == BookingStatus.held &&
            booking.holdExpiresAt != null) ...[
          const SizedBox(height: RoveSpacing.md),
          InlineNotice(
            message: l10n.bookingPayBy(at(booking.holdExpiresAt!)),
            tone: NoticeTone.warning,
          ),
        ],
        if (booking.status == BookingStatus.pendingPartner &&
            booking.partnerResponseDueAt != null) ...[
          const SizedBox(height: RoveSpacing.md),
          InlineNotice(
            message: l10n.bookingPartnerDue(
              booking.partner.displayName,
              at(booking.partnerResponseDueAt!),
            ),
          ),
        ],
        SectionHeader(title: l10n.tripTitle),
        InfoRow(label: l10n.referenceLabel, value: booking.reference),
        InfoRow(label: l10n.pickupLabel, value: at(booking.pickupAt)),
        InfoRow(label: l10n.returnLabel, value: at(booking.returnAt)),
        InfoRow(
          label: l10n.bookingWhere,
          value: booking.delivery.enabled
              ? l10n.bookingDeliveryTo(booking.delivery.address ?? '')
              : (booking.pickupLocation?.name ?? booking.city.name),
        ),
        if (booking.pickupLocation?.address != null &&
            !booking.delivery.enabled)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: MutedText(booking.pickupLocation!.address!, small: true),
          ),
        InfoRow(label: l10n.bookingPartner, value: booking.partner.displayName),
        if (booking.driver != null)
          InfoRow(label: l10n.bookingDriver, value: booking.driver!.fullName),
        SectionHeader(title: l10n.bookingPaymentSection),
        InfoRow(
          label: l10n.bookingPaymentStatus,
          value: null,
          trailing: StatusPill(
            key: const Key('payment-status'),
            label: l10n.paymentStatus(booking.paymentStatus),
            tone: paymentStatusTone(booking.paymentStatus),
          ),
        ),
        InfoRow(
          label: l10n.bookingDepositStatus,
          value: null,
          trailing: StatusPill(
            label: l10n.depositStatus(booking.depositStatus),
          ),
        ),
        if (fee != null && !fee.isZero)
          InfoRow(label: l10n.bookingCancellationFee, value: fee.format()),
        if (refund != null && !refund.isZero) ...[
          InfoRow(label: l10n.bookingRefundAmount, value: refund.format()),
          MutedText(l10n.bookingRefundPending, small: true),
        ],
        SectionHeader(title: l10n.priceDetails),
        PriceBreakdown(
          lineItems: booking.lineItems,
          total: booking.total,
          deposit: booking.deposit,
          depositNote: l10n.priceDepositNote,
          conditionalCharges: booking.conditionalCharges,
        ),
        if (booking.cancellationPolicy != null) ...[
          SectionHeader(title: l10n.bookingConditions),
          MutedText(booking.cancellationPolicy!.summary),
        ],
        SectionHeader(title: l10n.bookingPickupReturn),
        _LinkTile(
          icon: Icons.key_outlined,
          label: l10n.bookingPickupGuide,
          onTap: () => context.push(Routes.bookingPickup(booking.id)),
        ),
        _LinkTile(
          icon: Icons.assignment_return_outlined,
          label: l10n.bookingReturnGuide,
          onTap: () => context.push(Routes.bookingReturn(booking.id)),
        ),
        _LinkTile(
          icon: Icons.receipt_long_outlined,
          label: l10n.bookingReceipt,
          onTap: () => context.push(Routes.bookingReceipt(booking.id)),
        ),
        if (booking.events.isNotEmpty) ...[
          SectionHeader(title: l10n.bookingHistory),
          for (final e in booking.events.reversed)
            InfoRow(
              label: e.toStatus == null
                  ? e.type
                  : l10n.bookingStatus(e.toStatus!),
              value: at(e.at),
            ),
        ],
        const SizedBox(height: RoveSpacing.lg),
      ],
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon),
    title: Text(label),
    trailing: const Icon(Icons.chevron_right_rounded),
    onTap: onTap,
  );
}

/// Only the actions the backend lists in `allowedActions`.
class _Actions extends StatelessWidget {
  const _Actions({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canPay = booking.can(CustomerActions.pay) && booking.payment != null;
    final canCancel = booking.can(CustomerActions.cancel);
    final canSupport = booking.can(CustomerActions.contactSupport);
    if (!canPay && !canCancel && !canSupport) return const SizedBox.shrink();
    return BottomActionBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (canPay)
            RoveButton(
              key: const Key('booking-pay'),
              label: l10n.bookingCompletePayment,
              expand: true,
              onPressed: () async {
                final cubit = context.read<BookingDetailCubit>();
                final result = await openPaymentFor(
                  context,
                  booking: booking,
                  seed: CheckoutResult(
                    booking: booking,
                    intent: booking.payment,
                  ),
                );
                if (result?.booking != null) {
                  cubit.replace(result!.booking!);
                } else if (result != null) {
                  await cubit.load();
                }
              },
            ),
          Row(
            children: [
              if (canSupport)
                Expanded(
                  child: RoveButton.text(
                    key: const Key('booking-support'),
                    label: l10n.bookingGetHelp,
                    icon: Icons.support_agent_outlined,
                    onPressed: () => context.push(
                      Routes.bookingSupport(booking.id),
                      extra: booking.reference,
                    ),
                  ),
                ),
              if (canCancel)
                Expanded(
                  child: RoveButton.text(
                    key: const Key('booking-cancel'),
                    label: l10n.bookingCancel,
                    destructive: true,
                    onPressed: () => _cancel(context),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _cancel(BuildContext context) async {
    final cubit = context.read<BookingDetailCubit>();
    unawaited(cubit.previewCancellation());
    await showDialog<void>(
      context: context,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const _CancelDialog()),
    );
    if (cubit.state.cancelStatus != CancelStatus.cancelled) {
      cubit.resetCancellation();
    }
  }
}

class _CancelDialog extends StatefulWidget {
  const _CancelDialog();

  @override
  State<_CancelDialog> createState() => _CancelDialogState();
}

class _CancelDialogState extends State<_CancelDialog> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<BookingDetailCubit, BookingDetailState>(
      listenWhen: (a, b) => b.cancelStatus == CancelStatus.cancelled,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        final preview = state.preview;
        final paid = state.booking?.paymentStatus == PaymentStatus.captured;
        Widget content;
        if (state.cancelStatus == CancelStatus.previewing) {
          content = CenteredLoader(label: l10n.cancelChecking);
        } else if (preview == null) {
          content = state.cancelFailure == null
              ? const SizedBox.shrink()
              : Text(l10n.failure(state.cancelFailure!));
        } else if (!preview.eligible) {
          content = Text(preview.reason ?? l10n.errorInvalidState);
        } else {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                key: const Key('cancel-terms'),
                preview.free
                    ? (paid
                          ? l10n.cancelFreePaid(preview.refund.format())
                          : l10n.cancelFreeUnpaid)
                    : l10n.cancelWithFee(
                        preview.fee.format(),
                        preview.refund.format(),
                      ),
              ),
              const SizedBox(height: RoveSpacing.md),
              RoveTextField(
                label: l10n.cancelReasonLabel,
                controller: _reason,
                maxLines: 2,
                maxLength: 500,
              ),
              if (state.cancelFailure != null) ...[
                const SizedBox(height: RoveSpacing.sm),
                Text(
                  l10n.failure(state.cancelFailure!),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: context.colors.danger),
                ),
              ],
            ],
          );
        }
        final canConfirm = preview != null && preview.eligible;
        return AlertDialog(
          title: Text(l10n.cancelDialogTitle),
          content: SingleChildScrollView(child: content),
          actions: [
            RoveButton.text(
              label: l10n.cancelKeep,
              onPressed: state.cancelStatus == CancelStatus.cancelling
                  ? null
                  : () => Navigator.of(context).pop(),
            ),
            if (canConfirm)
              RoveButton(
                key: const Key('cancel-confirm'),
                label: l10n.cancelConfirm,
                destructive: true,
                loading: state.cancelStatus == CancelStatus.cancelling,
                onPressed: () => context
                    .read<BookingDetailCubit>()
                    .confirmCancellation(reason: _reason.text.trim()),
              ),
          ],
        );
      },
    );
  }
}
