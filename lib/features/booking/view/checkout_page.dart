import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme/rove_tokens.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/time/zoned_time.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/price_breakdown.dart';
import '../../../core/widgets/rove_button.dart';
import '../../../core/widgets/rove_text_field.dart';
import '../../../core/widgets/section.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vehicle_photo.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/enums.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/booking_repository.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../../shared/repositories/vehicle_repository.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../home/view/trip_summary.dart';
import '../../onboarding/bloc/countries_cubit.dart';
import '../../payments/view/payment_sheet.dart';
import '../../profile/bloc/verification_cubit.dart';
import '../../profile/view/verification_panel.dart';
import '../../search/bloc/trip_cubit.dart';
import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_result.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    final trip = context.read<TripCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CheckoutBloc(
                vehicleId: vehicleId,
                vehicles: context.read<VehicleRepository>(),
                bookings: context.read<BookingRepository>(),
                profiles: context.read<ProfileRepository>(),
              )..add(
                CheckoutStarted(
                  pickupAt: trip.pickupAt,
                  returnAt: trip.returnAt,
                ),
              ),
        ),
        BlocProvider(
          create: (context) =>
              VerificationCubit(context.read<ProfileRepository>()),
        ),
      ],
      child: const _CheckoutView(),
    );
  }
}

/// Opens the payment sheet for a held booking. Resolves to the result to
/// show, or null if the sheet was closed without paying.
Future<CheckoutResult?> openPaymentFor(
  BuildContext context, {
  required Booking booking,
  required CheckoutResult seed,
}) async {
  final intent = seed.retryIntent;
  if (intent == null) return null;
  final countries = context.read<CountriesCubit>().state;
  final countryCode = countries.cityById(booking.city.id)?.countryCode;
  final methods =
      countries.byCode(countryCode)?.paymentMethods ?? const ['card'];
  final result = await showPaymentSheet(
    context,
    bookingId: booking.id,
    intent: intent,
    paymentMethods: methods,
    bookingMode: booking.bookingMode,
  );
  return result;
}

/// Pays and, when there is an outcome, replaces checkout with the result.
Future<void> payAndShowResult(
  BuildContext context, {
  required Booking booking,
  required CheckoutResult seed,
}) async {
  final result = await openPaymentFor(context, booking: booking, seed: seed);
  if (result == null || !context.mounted) return;
  context.go(Routes.bookingResult(booking.id), extra: result);
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<TripCubit, TripState>(
          listenWhen: (a, b) =>
              b.hasDates &&
              (a.pickupAt != b.pickupAt || a.returnAt != b.returnAt),
          listener: (context, trip) => context.read<CheckoutBloc>().add(
            CheckoutPeriodChanged(trip.pickupAt!, trip.returnAt!),
          ),
        ),
        BlocListener<CheckoutBloc, CheckoutState>(
          listenWhen: (a, b) => a.creation == null && b.creation != null,
          listener: (context, state) => payAndShowResult(
            context,
            booking: state.creation!.booking,
            seed: CheckoutResult(
              booking: state.creation!.booking,
              intent: state.creation!.payment,
            ),
          ),
        ),
        BlocListener<CheckoutBloc, CheckoutState>(
          listenWhen: (a, b) => a.stop == null && b.stop != null,
          listener: (context, state) => context.go(
            Routes.bookingResult('none'),
            extra: const CheckoutResult(
              failure: ApiFailure(code: ErrorCodes.vehicleUnavailable),
            ),
          ),
        ),
        BlocListener<CheckoutBloc, CheckoutState>(
          listenWhen: (a, b) =>
              a.step != b.step && b.step == CheckoutStep.verification,
          listener: (context, _) => context.read<VerificationCubit>().load(),
        ),
      ],
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          final vehicle = state.vehicle;
          final canGoBack = state.stepIndex > 0 && state.creation == null;
          return PopScope(
            canPop: !canGoBack,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) {
                context.read<CheckoutBloc>().add(const CheckoutStepBack());
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(l10n.checkoutTitle),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(28),
                  child: _StepHeader(state: state),
                ),
              ),
              body: vehicle == null
                  ? (state.loadFailure != null
                        ? ErrorState(
                            failure: state.loadFailure!,
                            onRetry: () {
                              final trip = context.read<TripCubit>().state;
                              context.read<CheckoutBloc>().add(
                                CheckoutStarted(
                                  pickupAt: trip.pickupAt,
                                  returnAt: trip.returnAt,
                                ),
                              );
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.all(RoveSpacing.md),
                            child: ListSkeleton(),
                          ))
                  : AnimatedSwitcher(
                      duration: RoveMotion.normal,
                      child: KeyedSubtree(
                        key: ValueKey(state.step),
                        child: switch (state.step) {
                          CheckoutStep.trip => _TripStep(vehicle: vehicle),
                          CheckoutStep.driver => const _DriverStep(),
                          CheckoutStep.verification =>
                            const _VerificationStep(),
                          CheckoutStep.review => _ReviewStep(vehicle: vehicle),
                        },
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.state});

  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final total = state.steps.length;
    final current = state.stepIndex + 1;
    final title = switch (state.step) {
      CheckoutStep.trip => l10n.stepTrip,
      CheckoutStep.driver => l10n.stepDriver,
      CheckoutStep.verification => l10n.stepVerification,
      CheckoutStep.review => l10n.stepReview,
    };
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        RoveSpacing.md,
        0,
        RoveSpacing.md,
        RoveSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.stepOf(current, total)} · $title',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: RoveSpacing.xxs),
          LinearProgressIndicator(
            value: current / total,
            minHeight: 2,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}

class _VehicleSummaryRow extends StatelessWidget {
  const _VehicleSummaryRow({required this.vehicle});

  final VehicleDetail vehicle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(
          width: 96,
          child: VehiclePhoto(
            url: vehicle.coverImageUrl,
            semanticLabel: context.l10n.vehicleImageLabel(vehicle.title),
            radius: RoveRadius.small,
            memCacheWidth: 300,
          ),
        ),
        const SizedBox(width: RoveSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vehicle.title, style: text.titleSmall),
              MutedText(
                '${vehicle.year} · ${vehicle.partner.displayName}',
                small: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TripStep extends StatefulWidget {
  const _TripStep({required this.vehicle});

  final VehicleDetail vehicle;

  @override
  State<_TripStep> createState() => _TripStepState();
}

class _TripStepState extends State<_TripStep> {
  late final _address = TextEditingController(
    text: context.read<CheckoutBloc>().state.deliveryAddress,
  );
  bool _showAddressError = false;

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  void _continue() {
    final bloc = context.read<CheckoutBloc>();
    if (bloc.state.delivery && _address.text.trim().length < 5) {
      setState(() => _showAddressError = true);
      return;
    }
    bloc.add(const CheckoutTripConfirmed());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final vehicle = widget.vehicle;
    final state = context.watch<CheckoutBloc>().state;
    final trip = context.watch<TripCubit>().state;
    final periodError = context.read<CheckoutBloc>().periodError;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(RoveSpacing.md),
            children: [
              _VehicleSummaryRow(vehicle: vehicle),
              SectionHeader(title: l10n.tripTitle),
              RoveSelectField(
                key: const Key('checkout-dates'),
                label: '${l10n.pickupLabel} → ${l10n.returnLabel}',
                value: trip.hasDates ? tripDatesLabel(context, trip) : null,
                placeholder: l10n.periodMissing,
                icon: Icons.calendar_today_outlined,
                errorText: periodError == null
                    ? null
                    : l10n.periodError(periodError),
                onTap: () => context.push(Routes.dates),
              ),
              const SizedBox(height: RoveSpacing.lg),
              Text(
                l10n.pickupLocationLabel,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: RoveSpacing.xs),
              Text(vehicle.pickupLocation?.name ?? l10n.detailsPickupArranged),
              if (vehicle.pickupLocation?.address != null)
                MutedText(vehicle.pickupLocation!.address!, small: true),
              if (vehicle.deliveryAvailable) ...[
                const SizedBox(height: RoveSpacing.md),
                SwitchListTile(
                  key: const Key('checkout-delivery'),
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.deliverToMe),
                  subtitle: Text(
                    l10n.deliveryFeeNote(vehicle.deliveryFee.format()),
                  ),
                  value: state.delivery,
                  onChanged: (v) => context.read<CheckoutBloc>().add(
                    CheckoutDeliveryChanged(enabled: v),
                  ),
                ),
                if (state.delivery)
                  RoveTextField(
                    fieldKey: const Key('checkout-address'),
                    label: l10n.deliveryAddressLabel,
                    hint: l10n.deliveryAddressHint,
                    controller: _address,
                    maxLines: 2,
                    errorText:
                        _showAddressError && _address.text.trim().length < 5
                        ? l10n.fieldTooShort
                        : null,
                    onChanged: (v) => context.read<CheckoutBloc>().add(
                      CheckoutDeliveryChanged(enabled: true, address: v),
                    ),
                  ),
              ],
            ],
          ),
        ),
        BottomActionBar(
          child: RoveButton(
            key: const Key('checkout-continue'),
            label: l10n.continueLabel,
            expand: true,
            onPressed: periodError == null ? _continue : null,
          ),
        ),
      ],
    );
  }
}

class _DriverStep extends StatefulWidget {
  const _DriverStep();

  @override
  State<_DriverStep> createState() => _DriverStepState();
}

class _DriverStepState extends State<_DriverStep> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;
  DateTime? _dob;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final existing = context.read<CheckoutBloc>().state.driver;
    final profile = context.read<AuthBloc>().state.me?.profile;
    _name = TextEditingController(
      text: existing?.fullName ?? profile?.fullName,
    );
    _phone = TextEditingController(text: existing?.phone ?? profile?.phone);
    _dob = existing?.dateOfBirth;
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Future<void> _pickDob() async {
    final today = _today;
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(today.year - 30, today.month, today.day),
      firstDate: DateTime(1900),
      lastDate: today,
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null) setState(() => _dob = picked);
  }

  void _submit() {
    setState(() => _submitted = true);
    final validForm = _formKey.currentState?.validate() ?? false;
    if (!validForm || Validators.dateOfBirth(_dob, today: _today) != null) {
      return;
    }
    context.read<CheckoutBloc>().add(
      CheckoutDriverSubmitted(
        DriverDetails(
          fullName: _name.text.trim(),
          phone: _phone.text.trim(),
          dateOfBirth: _dob!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<CheckoutBloc>().state;
    final dobError = _submitted
        ? Validators.dateOfBirth(_dob, today: _today)
        : null;
    final locale = context.localeTag;
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(RoveSpacing.md),
              children: [
                Text(
                  l10n.driverTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: RoveSpacing.xs),
                MutedText(l10n.driverAgeNote),
                const SizedBox(height: RoveSpacing.lg),
                if (state.failure != null) ...[
                  InlineNotice(
                    message: l10n.failure(state.failure!),
                    tone: NoticeTone.danger,
                  ),
                  const SizedBox(height: RoveSpacing.md),
                ],
                RoveTextField(
                  fieldKey: const Key('driver-name'),
                  label: l10n.fullNameLabel,
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  validator: (v) {
                    final e = Validators.fullName(v);
                    return e == null ? null : l10n.fieldError(e);
                  },
                ),
                const SizedBox(height: RoveSpacing.md),
                RoveTextField(
                  fieldKey: const Key('driver-phone'),
                  label: l10n.phoneLabel,
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    final e = Validators.phone(v);
                    return e == null ? null : l10n.fieldError(e);
                  },
                ),
                const SizedBox(height: RoveSpacing.md),
                RoveSelectField(
                  key: const Key('driver-dob'),
                  label: l10n.dateOfBirthLabel,
                  value: _dob == null
                      ? null
                      : ZonedTime.formatDate(
                          DateTime.utc(_dob!.year, _dob!.month, _dob!.day),
                          'UTC',
                          locale: locale,
                        ),
                  placeholder: l10n.dateOfBirthHint,
                  icon: Icons.cake_outlined,
                  errorText: dobError == null
                      ? null
                      : l10n.fieldError(dobError),
                  onTap: _pickDob,
                ),
              ],
            ),
          ),
        ),
        BottomActionBar(
          child: RoveButton(
            key: const Key('driver-continue'),
            label: l10n.continueLabel,
            expand: true,
            loading: state.checkingVerification,
            onPressed: _submit,
          ),
        ),
      ],
    );
  }
}

class _VerificationStep extends StatelessWidget {
  const _VerificationStep();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<CheckoutBloc>().state;
    final allows = context.select<VerificationCubit, bool>(
      (c) => c.state.allowsBooking,
    );
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(RoveSpacing.md),
            children: [
              Text(
                l10n.verificationTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: RoveSpacing.xs),
              MutedText(l10n.verificationBody),
              const SizedBox(height: RoveSpacing.md),
              if (state.failure != null) ...[
                InlineNotice(
                  message: l10n.failure(state.failure!),
                  tone: NoticeTone.danger,
                ),
                const SizedBox(height: RoveSpacing.md),
              ],
              const VerificationPanel(),
            ],
          ),
        ),
        BottomActionBar(
          child: RoveButton(
            key: const Key('verification-continue'),
            label: l10n.continueLabel,
            expand: true,
            onPressed: allows
                ? () => context.read<CheckoutBloc>().add(
                    const CheckoutVerificationCompleted(),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class _ReviewStep extends StatefulWidget {
  const _ReviewStep({required this.vehicle});

  final VehicleDetail vehicle;

  @override
  State<_ReviewStep> createState() => _ReviewStepState();
}

class _ReviewStepState extends State<_ReviewStep> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // Re-evaluate the quote expiry while the customer reads.
    _ticker = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final bloc = context.read<CheckoutBloc>();
    final state = context.watch<CheckoutBloc>().state;
    final trip = context.watch<TripCubit>().state;
    final quote = state.quote;
    final expired = state.isQuoteExpired(bloc.now);
    final creation = state.creation;
    final tz = widget.vehicle.timezone;
    final locale = context.localeTag;

    Widget priceSection() {
      switch (state.quoteStatus) {
        case QuoteStatus.idle:
        case QuoteStatus.loading:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MutedText(l10n.gettingPrice, small: true),
              const SizedBox(height: RoveSpacing.sm),
              const ListSkeleton(rows: 3),
            ],
          );
        case QuoteStatus.failure:
          return ErrorState(
            failure: state.quoteFailure!,
            compact: true,
            onRetry: () => bloc.add(const CheckoutQuoteRequested()),
          );
        case QuoteStatus.ready:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PriceBreakdown(
                lineItems: quote!.lineItems,
                total: quote.total,
                deposit: quote.deposit,
                depositNote: l10n.priceDepositNote,
                conditionalCharges: quote.conditionalCharges,
              ),
              const SizedBox(height: RoveSpacing.sm),
              if (creation == null)
                expired
                    ? InlineNotice(
                        key: const Key('quote-expired'),
                        message: l10n.quoteExpired,
                        tone: NoticeTone.warning,
                        action: RoveButton.text(
                          label: l10n.refreshPrice,
                          onPressed: () =>
                              bloc.add(const CheckoutQuoteRequested()),
                        ),
                      )
                    : MutedText(
                        l10n.quoteHeldUntil(
                          ZonedTime.formatTime(
                            quote.expiresAt,
                            tz,
                            locale: locale,
                          ),
                        ),
                        small: true,
                      ),
            ],
          );
      }
    }

    final Widget primary;
    if (creation != null) {
      final holdUntil = creation.booking.holdExpiresAt;
      primary = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (holdUntil != null)
            Padding(
              padding: const EdgeInsets.only(bottom: RoveSpacing.xs),
              child: MutedText(
                l10n.bookingPayBy(
                  ZonedTime.formatTime(holdUntil, tz, locale: locale),
                ),
                small: true,
              ),
            ),
          RoveButton(
            key: const Key('checkout-complete-payment'),
            label: l10n.bookingCompletePayment,
            expand: true,
            onPressed: () => payAndShowResult(
              context,
              booking: creation.booking,
              seed: CheckoutResult(
                booking: creation.booking,
                intent: creation.payment,
              ),
            ),
          ),
        ],
      );
    } else {
      final total = quote?.total.format() ?? '';
      primary = RoveButton(
        key: const Key('checkout-book'),
        label: widget.vehicle.bookingMode == BookingMode.request
            ? l10n.requestAndAuthorize(total)
            : l10n.bookAndPay(total),
        expand: true,
        loading: state.submitting,
        onPressed:
            state.quoteStatus == QuoteStatus.ready &&
                state.termsAccepted &&
                !expired
            ? () => bloc.add(const CheckoutBookingRequested())
            : null,
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(RoveSpacing.md),
            children: [
              _VehicleSummaryRow(vehicle: widget.vehicle),
              const SizedBox(height: RoveSpacing.md),
              InfoRow(
                label: l10n.bookingWhen,
                value: tripDatesLabel(context, trip),
              ),
              InfoRow(
                label: l10n.bookingWhere,
                value: state.delivery
                    ? l10n.bookingDeliveryTo(state.deliveryAddress.trim())
                    : (widget.vehicle.pickupLocation?.name ??
                          l10n.detailsPickupArranged),
              ),
              if (state.driver != null)
                InfoRow(
                  label: l10n.bookingDriver,
                  value: state.driver!.fullName,
                ),
              SectionHeader(title: l10n.priceDetails),
              priceSection(),
              SectionHeader(title: l10n.detailsCancellation),
              MutedText(
                (quote?.cancellationPolicy ?? widget.vehicle.cancellationPolicy)
                    .summary,
              ),
              const SizedBox(height: RoveSpacing.xs),
              MutedText(
                widget.vehicle.bookingMode == BookingMode.request
                    ? l10n.requestModeNote
                    : l10n.instantModeNote,
                small: true,
              ),
              const SizedBox(height: RoveSpacing.md),
              if (creation == null)
                CheckboxListTile(
                  key: const Key('checkout-terms'),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: state.termsAccepted,
                  onChanged: (v) => bloc.add(CheckoutTermsChanged(v ?? false)),
                  title: Text(l10n.termsAccept, style: text.bodyMedium),
                ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: RoveButton.text(
                  label: l10n.readTerms,
                  onPressed: () => context.push(Routes.terms),
                ),
              ),
              if (state.failure != null) ...[
                const SizedBox(height: RoveSpacing.sm),
                InlineNotice(
                  key: const Key('checkout-error'),
                  message: l10n.failure(state.failure!),
                  tone: NoticeTone.danger,
                ),
              ],
            ],
          ),
        ),
        BottomActionBar(child: primary),
      ],
    );
  }
}
