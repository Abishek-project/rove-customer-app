import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/rove_tokens.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/widgets/grouped_list.dart';
import '../../../core/widgets/section.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../onboarding/bloc/countries_cubit.dart';

/// Display-only: the methods offered in the customer's country. Nothing is
/// stored on the device or by Rove.
class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  static IconData iconFor(String method) => switch (method) {
    'upi' => Icons.qr_code_2_rounded,
    'apple_pay' => Icons.phone_iphone_rounded,
    _ => Icons.credit_card_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final code = context.select<AuthBloc, String?>(
      (b) => b.state.me?.profile.countryCode,
    );
    final country = context.watch<CountriesCubit>().state.byCode(code);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.paymentMethods)),
      body: ListView(
        padding: const EdgeInsets.all(RoveSpacing.ml),
        children: [
          MutedText(l10n.paymentMethodsBody),
          const SizedBox(height: RoveSpacing.md),
          if (country != null)
            RowGroup(
              title: l10n.paymentMethodsAvailable(country.name),
              children: [
                for (final m in country.paymentMethods)
                  GroupRow(
                    icon: iconFor(m),
                    label: l10n.paymentMethod(m),
                    showChevron: false,
                    onTap: () {},
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
