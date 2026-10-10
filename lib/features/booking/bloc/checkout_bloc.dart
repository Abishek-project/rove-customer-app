import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/utils/rental_period.dart';
import '../../../shared/models/booking.dart';
import '../../../shared/models/pricing.dart';
import '../../../shared/models/vehicle.dart';
import '../../../shared/repositories/booking_repository.dart';
import '../../../shared/repositories/profile_repository.dart';
import '../../../shared/repositories/vehicle_repository.dart';

enum CheckoutStep { trip, driver, verification, review }

enum QuoteStatus { idle, loading, ready, failure }

/// Terminal outcomes that end the checkout before payment.
enum CheckoutStop { vehicleUnavailable }

class CheckoutState extends Equatable {
  const CheckoutState({
    required this.vehicleId,
    this.step = CheckoutStep.trip,
    this.vehicle,
    this.loadFailure,
    this.pickupAt,
    this.returnAt,
    this.delivery = false,
    this.deliveryAddress = '',
    this.driver,
    this.verificationRequired = false,
    this.checkingVerification = false,
    this.quote,
    this.quoteStatus = QuoteStatus.idle,
    this.quoteFailure,
    this.termsAccepted = false,
    this.submitting = false,
    this.creation,
    this.failure,
    this.stop,
    this.idempotencyKey,
  });

  final String vehicleId;
  final CheckoutStep step;
  final VehicleDetail? vehicle;
  final ApiFailure? loadFailure;
  final DateTime? pickupAt;
  final DateTime? returnAt;
  final bool delivery;
  final String deliveryAddress;
  final DriverDetails? driver;

  /// True when `GET /me/verification` said documents are still needed.
  final bool verificationRequired;
  final bool checkingVerification;
  final Quote? quote;
  final QuoteStatus quoteStatus;
  final ApiFailure? quoteFailure;
  final bool termsAccepted;

  /// `POST /bookings` in flight — the book button is disabled.
  final bool submitting;

  /// The held booking and its payment intent once created. From here on
  /// the primary action opens the payment sheet; a second booking is never
  /// created.
  final BookingCreation? creation;
  final ApiFailure? failure;
  final CheckoutStop? stop;

  /// One key per "Book" action, reused if that action is retried.
  final String? idempotencyKey;

  List<CheckoutStep> get steps => [
    CheckoutStep.trip,
    CheckoutStep.driver,
    if (verificationRequired) CheckoutStep.verification,
    CheckoutStep.review,
  ];

  int get stepIndex => steps.indexOf(step);

  bool isQuoteExpired(DateTime now) =>
      quote != null && !quote!.expiresAt.isAfter(now);

  CheckoutState copyWith({
    CheckoutStep? step,
    VehicleDetail? vehicle,
    ApiFailure? Function()? loadFailure,
    DateTime? pickupAt,
    DateTime? returnAt,
    bool? delivery,
    String? deliveryAddress,
    DriverDetails? driver,
    bool? verificationRequired,
    bool? checkingVerification,
    Quote? Function()? quote,
    QuoteStatus? quoteStatus,
    ApiFailure? Function()? quoteFailure,
    bool? termsAccepted,
    bool? submitting,
    BookingCreation? Function()? creation,
    ApiFailure? Function()? failure,
    CheckoutStop? Function()? stop,
    String? Function()? idempotencyKey,
  }) => CheckoutState(
    vehicleId: vehicleId,
    step: step ?? this.step,
    vehicle: vehicle ?? this.vehicle,
    loadFailure: loadFailure != null ? loadFailure() : this.loadFailure,
    pickupAt: pickupAt ?? this.pickupAt,
    returnAt: returnAt ?? this.returnAt,
    delivery: delivery ?? this.delivery,
    deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    driver: driver ?? this.driver,
    verificationRequired: verificationRequired ?? this.verificationRequired,
    checkingVerification: checkingVerification ?? this.checkingVerification,
    quote: quote != null ? quote() : this.quote,
    quoteStatus: quoteStatus ?? this.quoteStatus,
    quoteFailure: quoteFailure != null ? quoteFailure() : this.quoteFailure,
    termsAccepted: termsAccepted ?? this.termsAccepted,
    submitting: submitting ?? this.submitting,
    creation: creation != null ? creation() : this.creation,
    failure: failure != null ? failure() : this.failure,
    stop: stop != null ? stop() : this.stop,
    idempotencyKey: idempotencyKey != null
        ? idempotencyKey()
        : this.idempotencyKey,
  );

  @override
  List<Object?> get props => [
    vehicleId,
    step,
    vehicle,
    loadFailure,
    pickupAt,
    returnAt,
    delivery,
    deliveryAddress,
    driver,
    verificationRequired,
    checkingVerification,
    quote,
    quoteStatus,
    quoteFailure,
    termsAccepted,
    submitting,
    creation,
    failure,
    stop,
    idempotencyKey,
  ];
}

sealed class CheckoutEvent {
  const CheckoutEvent();
}

class CheckoutStarted extends CheckoutEvent {
  const CheckoutStarted({required this.pickupAt, required this.returnAt});
  final DateTime? pickupAt;
  final DateTime? returnAt;
}

class CheckoutPeriodChanged extends CheckoutEvent {
  const CheckoutPeriodChanged(this.pickupAt, this.returnAt);
  final DateTime pickupAt;
  final DateTime returnAt;
}

class CheckoutDeliveryChanged extends CheckoutEvent {
  const CheckoutDeliveryChanged({required this.enabled, this.address});
  final bool enabled;
  final String? address;
}

class CheckoutTripConfirmed extends CheckoutEvent {
  const CheckoutTripConfirmed();
}

class CheckoutDriverSubmitted extends CheckoutEvent {
  const CheckoutDriverSubmitted(this.driver);
  final DriverDetails driver;
}

class CheckoutVerificationCompleted extends CheckoutEvent {
  const CheckoutVerificationCompleted();
}

class CheckoutQuoteRequested extends CheckoutEvent {
  const CheckoutQuoteRequested();
}

class CheckoutTermsChanged extends CheckoutEvent {
  const CheckoutTermsChanged(this.accepted);
  final bool accepted;
}

class CheckoutBookingRequested extends CheckoutEvent {
  const CheckoutBookingRequested();
}

class CheckoutStepBack extends CheckoutEvent {
  const CheckoutStepBack();
}

class CheckoutFailureDismissed extends CheckoutEvent {
  const CheckoutFailureDismissed();
}

/// The checkout: trip → driver → licence/ID (only when required) → review
/// with the backend quote → `POST /bookings` (idempotent). The price shown is
/// always the backend's quote; the client never computes a total.
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required String vehicleId,
    required VehicleRepository vehicles,
    required BookingRepository bookings,
    required ProfileRepository profiles,
    DateTime Function()? clock,
    Uuid? uuid,
  }) : _vehicles = vehicles,
       _bookings = bookings,
       _profiles = profiles,
       _clock = clock ?? (() => DateTime.now().toUtc()),
       _uuid = uuid ?? const Uuid(),
       super(CheckoutState(vehicleId: vehicleId)) {
    on<CheckoutStarted>(_onStarted, transformer: restartable());
    on<CheckoutPeriodChanged>(_onPeriodChanged);
    on<CheckoutDeliveryChanged>(_onDeliveryChanged);
    on<CheckoutTripConfirmed>(_onTripConfirmed);
    on<CheckoutDriverSubmitted>(_onDriverSubmitted, transformer: droppable());
    on<CheckoutVerificationCompleted>(_onVerificationCompleted);
    on<CheckoutQuoteRequested>(
      (_, emit) => _fetchQuote(emit),
      transformer: restartable(),
    );
    on<CheckoutTermsChanged>(
      (e, emit) => emit(state.copyWith(termsAccepted: e.accepted)),
    );
    on<CheckoutBookingRequested>(_onBook, transformer: droppable());
    on<CheckoutStepBack>(_onBack);
    on<CheckoutFailureDismissed>(
      (_, emit) => emit(state.copyWith(failure: () => null)),
    );
  }

  final VehicleRepository _vehicles;
  final BookingRepository _bookings;
  final ProfileRepository _profiles;
  final DateTime Function() _clock;
  final Uuid _uuid;

  DateTime get now => _clock();

  RentalPeriodError? get periodError => RentalPeriod.validatePeriod(
    pickupAt: state.pickupAt,
    returnAt: state.returnAt,
    now: now,
  );

  Future<void> _onStarted(
    CheckoutStarted e,
    Emitter<CheckoutState> emit,
  ) async {
    emit(
      state.copyWith(
        pickupAt: e.pickupAt,
        returnAt: e.returnAt,
        loadFailure: () => null,
      ),
    );
    try {
      final vehicle = await _vehicles.getVehicle(
        state.vehicleId,
        pickupAt: e.pickupAt,
        returnAt: e.returnAt,
      );
      emit(state.copyWith(vehicle: vehicle));
      if (vehicle.availability.checked &&
          vehicle.availability.available == false) {
        emit(state.copyWith(stop: () => CheckoutStop.vehicleUnavailable));
      }
    } on ApiFailure catch (f) {
      emit(state.copyWith(loadFailure: () => f));
    }
  }

  void _onPeriodChanged(CheckoutPeriodChanged e, Emitter<CheckoutState> emit) {
    if (state.creation != null) return;
    emit(
      state.copyWith(
        pickupAt: e.pickupAt,
        returnAt: e.returnAt,
        quote: () => null,
        quoteStatus: QuoteStatus.idle,
        step: CheckoutStep.trip,
      ),
    );
  }

  void _onDeliveryChanged(
    CheckoutDeliveryChanged e,
    Emitter<CheckoutState> emit,
  ) {
    if (state.creation != null) return;
    final changed = e.enabled != state.delivery;
    emit(
      state.copyWith(
        delivery: e.enabled,
        deliveryAddress: e.address ?? state.deliveryAddress,
        quote: changed ? () => null : null,
        quoteStatus: changed ? QuoteStatus.idle : null,
      ),
    );
  }

  void _onTripConfirmed(CheckoutTripConfirmed e, Emitter<CheckoutState> emit) {
    if (periodError != null) return;
    if (state.delivery && state.deliveryAddress.trim().length < 5) return;
    emit(state.copyWith(step: CheckoutStep.driver, failure: () => null));
  }

  Future<void> _onDriverSubmitted(
    CheckoutDriverSubmitted e,
    Emitter<CheckoutState> emit,
  ) async {
    emit(
      state.copyWith(
        driver: e.driver,
        checkingVerification: true,
        failure: () => null,
      ),
    );
    try {
      final verification = await _profiles.getVerification();
      final required = !verification.allowsBooking;
      emit(
        state.copyWith(
          checkingVerification: false,
          verificationRequired: required,
          step: required ? CheckoutStep.verification : CheckoutStep.review,
        ),
      );
      if (!required) await _fetchQuote(emit);
    } on ApiFailure catch (f) {
      emit(state.copyWith(checkingVerification: false, failure: () => f));
    }
  }

  Future<void> _onVerificationCompleted(
    CheckoutVerificationCompleted e,
    Emitter<CheckoutState> emit,
  ) async {
    emit(state.copyWith(step: CheckoutStep.review));
    await _fetchQuote(emit);
  }

  Future<void> _fetchQuote(Emitter<CheckoutState> emit) async {
    if (state.creation != null) return;
    final pickupAt = state.pickupAt;
    final returnAt = state.returnAt;
    if (pickupAt == null || returnAt == null) return;
    emit(
      state.copyWith(
        quoteStatus: QuoteStatus.loading,
        quoteFailure: () => null,
        failure: () => null,
      ),
    );
    try {
      final quote = await _bookings.quote(
        QuoteRequest(
          vehicleId: state.vehicleId,
          pickupAt: pickupAt,
          returnAt: returnAt,
          delivery: state.delivery,
          deliveryAddress: state.delivery ? state.deliveryAddress.trim() : null,
        ),
      );
      emit(
        state.copyWith(
          quote: () => quote,
          quoteStatus: QuoteStatus.ready,
          // A new price is a new user decision: new idempotency key.
          idempotencyKey: () => _uuid.v4(),
        ),
      );
    } on ApiFailure catch (f) {
      if (f.code == ErrorCodes.vehicleUnavailable) {
        emit(
          state.copyWith(
            quoteStatus: QuoteStatus.failure,
            quoteFailure: () => f,
            stop: () => CheckoutStop.vehicleUnavailable,
          ),
        );
        return;
      }
      emit(
        state.copyWith(quoteStatus: QuoteStatus.failure, quoteFailure: () => f),
      );
    }
  }

  Future<void> _onBook(
    CheckoutBookingRequested e,
    Emitter<CheckoutState> emit,
  ) async {
    final quote = state.quote;
    final driver = state.driver;
    if (state.creation != null || state.submitting) return;
    if (quote == null || driver == null || !state.termsAccepted) return;
    if (state.isQuoteExpired(now)) {
      emit(
        state.copyWith(
          failure: () => const ApiFailure(code: ErrorCodes.quoteExpired),
        ),
      );
      return;
    }
    final key = state.idempotencyKey ?? _uuid.v4();
    emit(
      state.copyWith(
        submitting: true,
        failure: () => null,
        idempotencyKey: () => key,
      ),
    );
    try {
      final creation = await _bookings.create(
        quoteId: quote.id,
        driver: driver,
        idempotencyKey: key,
      );
      emit(state.copyWith(submitting: false, creation: () => creation));
    } on ApiFailure catch (f) {
      switch (f.code) {
        case ErrorCodes.vehicleUnavailable:
          emit(
            state.copyWith(
              submitting: false,
              failure: () => f,
              stop: () => CheckoutStop.vehicleUnavailable,
            ),
          );
        case ErrorCodes.quoteExpired:
          emit(
            state.copyWith(
              submitting: false,
              quote: () => null,
              quoteStatus: QuoteStatus.idle,
            ),
          );
          // Get the current price; the customer reviews it and books again.
          await _fetchQuote(emit);
          emit(state.copyWith(failure: () => f));
        case ErrorCodes.validationFailed
            when f.reason == 'verification_required':
          emit(
            state.copyWith(
              submitting: false,
              failure: () => f,
              verificationRequired: true,
              step: CheckoutStep.verification,
            ),
          );
        case ErrorCodes.validationFailed when f.reason == 'driver_age':
          emit(
            state.copyWith(
              submitting: false,
              failure: () => f,
              step: CheckoutStep.driver,
            ),
          );
        default:
          // Network errors keep the same key: retrying replays the same
          // request, so a booking that did get created is not duplicated.
          emit(state.copyWith(submitting: false, failure: () => f));
      }
    }
  }

  void _onBack(CheckoutStepBack e, Emitter<CheckoutState> emit) {
    final index = state.stepIndex;
    if (index <= 0 || state.creation != null) return;
    emit(state.copyWith(step: state.steps[index - 1], failure: () => null));
  }
}
