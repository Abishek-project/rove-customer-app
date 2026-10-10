import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';
import '../../shared/models/enums.dart';
import '../localization/l10n.dart';

enum PillTone { neutral, primary, success, warning, danger, info }

/// A quiet status pill: tinted background, coloured text.
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.tone = PillTone.neutral,
  });

  final String label;
  final PillTone tone;

  static (Color, Color) colors(PillTone tone) => switch (tone) {
    PillTone.neutral => (RoveColors.inputFill, RoveColors.textSecondary),
    PillTone.primary => (RoveColors.primaryTint, RoveColors.primary),
    PillTone.success => (RoveColors.successTint, RoveColors.success),
    PillTone.warning => (RoveColors.warningTint, RoveColors.warning),
    PillTone.danger => (RoveColors.dangerTint, RoveColors.danger),
    PillTone.info => (RoveColors.infoTint, RoveColors.info),
  };

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = colors(tone);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(RoveRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

PillTone bookingStatusTone(BookingStatus status) => switch (status) {
  BookingStatus.held => PillTone.warning,
  BookingStatus.pendingPartner => PillTone.info,
  BookingStatus.confirmed => PillTone.success,
  BookingStatus.active => PillTone.primary,
  BookingStatus.rejected => PillTone.danger,
  _ => PillTone.neutral,
};

PillTone paymentStatusTone(PaymentStatus status) => switch (status) {
  PaymentStatus.captured => PillTone.success,
  PaymentStatus.authorized => PillTone.info,
  PaymentStatus.failed => PillTone.danger,
  PaymentStatus.unpaid => PillTone.warning,
  _ => PillTone.neutral,
};

class BookingStatusBadge extends StatelessWidget {
  const BookingStatusBadge({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) => StatusPill(
    label: context.l10n.bookingStatus(status),
    tone: bookingStatusTone(status),
  );
}
