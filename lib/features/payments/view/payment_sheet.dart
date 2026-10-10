import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/state_views.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/pricing.dart';
import '../../../shared/repositories/payment_repository.dart';
import '../../booking/bloc/checkout_result.dart';
import '../bloc/payment_cubit.dart';

/// Opens the (mock) checkout sheet for [intent]. Resolves to the result to
/// show, or null if the customer closed it without paying.
Future<CheckoutResult?> showPaymentSheet(
  BuildContext context, {
  required String bookingId,
  required PaymentIntent intent,
  required List<String> paymentMethods,
  required BookingMode bookingMode,
}) {
  return showModalBottomSheet<CheckoutResult>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: false,
    enableDrag: false,
    builder: (_) => BlocProvider(
      create: (_) => PaymentCubit(
        repository: context.read<PaymentRepository>(),
        bookingId: bookingId,
        intent: intent,
        defaultMethod: paymentMethods.firstOrNull,
      ),
      child: _PaymentSheet(
        paymentMethods: paymentMethods,
        bookingMode: bookingMode,
      ),
    ),
  );
}

class _PaymentSheet extends StatelessWidget {
  const _PaymentSheet({
    required this.paymentMethods,
    required this.bookingMode,
  });

  final List<String> paymentMethods;
  final BookingMode bookingMode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        switch (state.status) {
          case PaymentFlowStatus.succeeded:
          case PaymentFlowStatus.declined:
            Navigator.of(context).pop(
              CheckoutResult(
                booking: state.booking,
                intent: state.intent,
                failure: state.failure,
              ),
            );
          case PaymentFlowStatus.failed
              when state.failure?.code == ErrorCodes.holdExpired:
            Navigator.of(
              context,
            ).pop(CheckoutResult(intent: state.intent, failure: state.failure));
          default:
            break;
        }
      },
      builder: (context, state) {
        final processing = state.status == PaymentFlowStatus.processing;
        final amount = state.intent.amount.format();
        return PopScope(
          canPop: !processing,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              RoveSpacing.lg,
              RoveSpacing.lg,
              RoveSpacing.lg,
              RoveSpacing.lg + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(l10n.paymentTitle, style: text.titleMedium),
                    ),
                    IconButton(
                      tooltip: l10n.close,
                      icon: const Icon(Icons.close_rounded),
                      onPressed: processing
                          ? null
                          : () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: RoveSpacing.md),
                MutedText(l10n.paymentAmountDue),
                Text(amount, style: text.headlineMedium),
                const SizedBox(height: RoveSpacing.xs),
                MutedText(
                  bookingMode == BookingMode.request
                      ? l10n.requestModeNote
                      : l10n.instantModeNote,
                  small: true,
                ),
                SectionHeader(title: l10n.paymentMethodLabel),
                for (final method in paymentMethods)
                  Padding(
                    padding: const EdgeInsets.only(bottom: RoveSpacing.xs),
                    child: _MethodTile(
                      key: ValueKey('method-$method'),
                      method: method,
                      label: l10n.paymentMethod(method),
                      selected: state.method == method,
                      onTap: processing
                          ? null
                          : () => context.read<PaymentCubit>().selectMethod(
                              method,
                            ),
                    ),
                  ),
                if (state.isMockProvider) ...[
                  const SizedBox(height: RoveSpacing.xs),
                  InlineNotice(
                    message: l10n.paymentTestMode,
                    tone: NoticeTone.neutral,
                  ),
                  SwitchListTile(
                    key: const Key('simulate-decline'),
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.paymentSimulateDecline),
                    value: state.simulateDecline,
                    onChanged: processing
                        ? null
                        : context.read<PaymentCubit>().setSimulateDecline,
                  ),
                ],
                if (state.status == PaymentFlowStatus.failed &&
                    state.failure != null) ...[
                  const SizedBox(height: RoveSpacing.sm),
                  InlineNotice(
                    key: const Key('payment-error'),
                    message: l10n.failure(state.failure!),
                    tone: NoticeTone.danger,
                  ),
                ],
                const SizedBox(height: RoveSpacing.lg),
                RoveButton(
                  key: const Key('payment-pay'),
                  label: bookingMode == BookingMode.request
                      ? l10n.paymentAuthorize(amount)
                      : l10n.paymentPay(amount),
                  expand: true,
                  loading: processing,
                  onPressed: state.method == null
                      ? null
                      : context.read<PaymentCubit>().confirm,
                ),
                if (processing) ...[
                  const SizedBox(height: RoveSpacing.sm),
                  Center(
                    child: Text(
                      l10n.paymentProcessing,
                      style: text.bodySmall?.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A wallet-style payment method row: icon circle, label, check.
class _MethodTile extends StatelessWidget {
  const _MethodTile({
    super.key,
    required this.method,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String method;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  static IconData iconFor(String method) => switch (method) {
    'upi' => Icons.qr_code_2_rounded,
    'apple_pay' => Icons.phone_iphone_rounded,
    _ => Icons.credit_card_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: selected ? c.primaryTint : c.inputFill,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RoveRadius.tile),
          side: BorderSide(
            color: selected ? c.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(RoveRadius.tile),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: c.surface3,
                  child: Icon(iconFor(method), size: 20, color: c.textPrimary),
                ),
                const SizedBox(width: RoveSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Icon(
                  selected
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: selected ? c.primary : c.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
