import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';
import '../../shared/models/pricing.dart';
import '../localization/l10n.dart';
import '../money/money.dart';

/// One line of a price list.
class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.amount,
    this.emphasize = false,
    this.muted = false,
    this.suffix,
  });

  final String label;
  final Money amount;
  final bool emphasize;
  final bool muted;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final base = emphasize ? text.titleSmall : text.bodyMedium;
    final style = muted
        ? base?.copyWith(color: RoveColors.textSecondary)
        : base;
    final value = suffix == null
        ? amount.format()
        : '${amount.format()} $suffix';
    return Semantics(
      label: '$label, $value',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(label, style: style)),
            const SizedBox(width: RoveSpacing.md),
            Text(value, style: style),
          ],
        ),
      ),
    );
  }
}

/// Backend line items as a plain two-column list, a hairline above the
/// total, then the refundable deposit and conditional charges kept apart
/// from what is charged (DESIGN.md: price breakdown).
class PriceBreakdown extends StatelessWidget {
  const PriceBreakdown({
    super.key,
    required this.lineItems,
    required this.total,
    this.totalLabel,
    this.deposit,
    this.depositNote,
    this.conditionalCharges = const [],
  });

  final List<LineItem> lineItems;
  final Money total;
  final String? totalLabel;
  final Money? deposit;
  final String? depositNote;
  final List<ConditionalCharge> conditionalCharges;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in lineItems)
          PriceRow(label: item.label, amount: item.amount),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: RoveSpacing.xs),
          child: Divider(),
        ),
        PriceRow(
          label: totalLabel ?? l10n.priceTotal,
          amount: total,
          emphasize: true,
        ),
        if (deposit != null && !deposit!.isZero) ...[
          const SizedBox(height: RoveSpacing.sm),
          PriceRow(label: l10n.detailsDeposit, amount: deposit!, muted: true),
          if (depositNote != null)
            Text(depositNote!, style: Theme.of(context).textTheme.bodySmall),
        ],
        if (conditionalCharges.isNotEmpty) ...[
          const SizedBox(height: RoveSpacing.md),
          Text(
            l10n.priceConditionalTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: RoveColors.textSecondary),
          ),
          for (final charge in conditionalCharges)
            PriceRow(
              label: charge.label,
              amount: charge.amount,
              muted: true,
              suffix: charge.unit == 'per_km' ? l10n.perKmUnit : null,
            ),
        ],
      ],
    );
  }
}
