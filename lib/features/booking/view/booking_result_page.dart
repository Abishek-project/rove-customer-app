import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/repositories/booking_repository.dart';
import '../bloc/booking_result_cubit.dart';
import '../bloc/checkout_result.dart';
import 'checkout_page.dart';

/// The authoritative booking result. Everything shown comes from the
/// backend's booking (or error) — tapping "Pay" alone proves nothing.
class BookingResultPage extends StatelessWidget {
  const BookingResultPage({super.key, required this.bookingId, this.initial});

  final String bookingId;
  final CheckoutResult? initial;

  @override
  Widget build(BuildContext context) {
    final id = bookingId == 'none' ? null : bookingId;
    return BlocProvider(
      create: (context) {
        final cubit = BookingResultCubit(
          context.read<BookingRepository>(),
          initial ?? const CheckoutResult(),
          id,
        );
        // Without a booking in hand (e.g. app restored), ask the backend.
        if (initial?.booking == null && id != null) cubit.refresh();
        return cubit;
      },
      child: const _ResultView(),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<BookingResultCubit, BookingResultState>(
      builder: (context, state) {
        final result = state.result;
        final booking = result.booking;
        final kind = result.kind;
        final tz = booking?.timezone;
        final locale = context.localeTag;
        String time(DateTime? t) =>
            t == null ? '' : ZonedTime.formatDateTime(t, tz, locale: locale);
        final partner = booking?.partner.displayName ?? '';
        final (icon, tone, title, body) = switch (kind) {
          ResultKind.confirmed => (
            Icons.check_circle_outline_rounded,
            RoveColors.success,
            l10n.resultConfirmedTitle,
            l10n.resultConfirmedBody(partner),
          ),
          ResultKind.pending => (
            Icons.schedule_rounded,
            RoveColors.info,
            l10n.resultPendingTitle,
            l10n.resultPendingBody(
              partner,
              time(booking?.partnerResponseDueAt),
            ),
          ),
          ResultKind.held => (
            Icons.hourglass_bottom_rounded,
            RoveColors.warning,
            l10n.resultHeldTitle,
            l10n.resultHeldBody(time(booking?.holdExpiresAt)),
          ),
          ResultKind.declined => (
            Icons.credit_card_off_outlined,
            RoveColors.danger,
            l10n.resultDeclinedTitle,
            l10n.resultDeclinedBody(time(booking?.holdExpiresAt)),
          ),
          ResultKind.expired => (
            Icons.timer_off_outlined,
            RoveColors.textSecondary,
            l10n.resultExpiredTitle,
            l10n.resultExpiredBody,
          ),
          ResultKind.rejected => (
            Icons.block_rounded,
            RoveColors.danger,
            l10n.resultRejectedTitle,
            l10n.resultRejectedBody,
          ),
          ResultKind.cancelled => (
            Icons.cancel_outlined,
            RoveColors.textSecondary,
            l10n.resultCancelledTitle,
            '',
          ),
          ResultKind.unavailable => (
            Icons.event_busy_outlined,
            RoveColors.textSecondary,
            l10n.resultUnavailableTitle,
            l10n.resultUnavailableBody,
          ),
          ResultKind.unknown => (
            Icons.help_outline_rounded,
            RoveColors.warning,
            l10n.resultUnknownTitle,
            l10n.resultUnknownBody,
          ),
        };
        final canRetryPayment =
            (kind == ResultKind.held || kind == ResultKind.declined) &&
            result.retryIntent != null;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) context.go(Routes.explore);
          },
          child: Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(RoveSpacing.lg),
                children: [
                  const SizedBox(height: RoveSpacing.xl),
                  Icon(icon, size: 48, color: tone),
                  const SizedBox(height: RoveSpacing.md),
                  Text(
                    title,
                    key: Key('result-${kind.name}'),
                    style: text.headlineSmall,
                  ),
                  if (body.isNotEmpty) ...[
                    const SizedBox(height: RoveSpacing.xs),
                    MutedText(body),
                  ],
                  if (booking != null) ...[
                    const SizedBox(height: RoveSpacing.lg),
                    _Summary(booking: booking),
                  ],
                  const SizedBox(height: RoveSpacing.xl),
                  if (canRetryPayment)
                    RoveButton(
                      key: const Key('result-retry-payment'),
                      label: l10n.retryPayment,
                      expand: true,
                      onPressed: () async {
                        final cubit = context.read<BookingResultCubit>();
                        final next = await openPaymentFor(
                          context,
                          booking: booking!,
                          seed: result,
                        );
                        if (next != null) cubit.update(next);
                      },
                    )
                  else if (kind == ResultKind.unknown)
                    RoveButton(
                      key: const Key('result-check-status'),
                      label: l10n.checkStatus,
                      expand: true,
                      loading: state.refreshing,
                      onPressed: context.read<BookingResultCubit>().refresh,
                    )
                  else if (booking != null)
                    RoveButton(
                      key: const Key('result-view-booking'),
                      label: l10n.viewBooking,
                      expand: true,
                      onPressed: () => context.go(Routes.booking(booking.id)),
                    ),
                  const SizedBox(height: RoveSpacing.sm),
                  if (booking != null &&
                      (canRetryPayment || kind == ResultKind.unknown))
                    RoveButton.secondary(
                      label: l10n.viewBooking,
                      expand: true,
                      onPressed: () => context.go(Routes.booking(booking.id)),
                    ),
                  RoveButton.text(
                    key: const Key('result-explore'),
                    label: l10n.backToExplore,
                    expand: true,
                    onPressed: () => context.go(Routes.explore),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = context.localeTag;
    return RoveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.vehicle.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              BookingStatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: RoveSpacing.sm),
          InfoRow(label: l10n.referenceLabel, value: booking.reference),
          InfoRow(
            label: l10n.pickupLabel,
            value: ZonedTime.formatDateTime(
              booking.pickupAt,
              booking.timezone,
              locale: locale,
            ),
          ),
          InfoRow(
            label: l10n.returnLabel,
            value: ZonedTime.formatDateTime(
              booking.returnAt,
              booking.timezone,
              locale: locale,
            ),
          ),
          InfoRow(label: l10n.priceTotal, value: booking.total.format()),
          InfoRow(
            label: l10n.bookingPaymentStatus,
            value: null,
            trailing: StatusPill(
              label: l10n.paymentStatus(booking.paymentStatus),
              tone: paymentStatusTone(booking.paymentStatus),
            ),
          ),
        ],
      ),
    );
  }
}
