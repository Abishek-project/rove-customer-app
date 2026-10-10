import 'package:flutter/widgets.dart';

import '../../l10n/gen/app_localizations.dart';
import '../../shared/models/enums.dart';
import '../errors/api_failure.dart';
import '../utils/rental_period.dart';
import '../utils/validators.dart';

export '../../l10n/gen/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Locale tag for intl formatting (dates).
  String get localeTag => Localizations.localeOf(this).toLanguageTag();
}

/// Localised labels for enums and failures. Keeping them here keeps widgets
/// free of switch statements and makes them testable.
extension L10nLabels on AppLocalizations {
  String category(VehicleCategory value) => switch (value) {
    VehicleCategory.economy => categoryEconomy,
    VehicleCategory.suv => categorySuv,
    VehicleCategory.sedan => categorySedan,
    VehicleCategory.luxury => categoryLuxury,
    VehicleCategory.electric => categoryElectric,
    VehicleCategory.unknown => categoryOther,
  };

  String transmission(Transmission value) => switch (value) {
    Transmission.automatic => transmissionAutomatic,
    Transmission.manual => transmissionManual,
    Transmission.unknown => categoryOther,
  };

  String fuel(FuelType value) => switch (value) {
    FuelType.petrol => fuelPetrol,
    FuelType.diesel => fuelDiesel,
    FuelType.hybrid => fuelHybrid,
    FuelType.electric => fuelElectric,
    FuelType.unknown => categoryOther,
  };

  String fuelPolicy(FuelPolicy value) => switch (value) {
    FuelPolicy.fullToFull => fuelFullToFull,
    FuelPolicy.sameToSame => fuelSameToSame,
    FuelPolicy.unknown => notSet,
  };

  String sort(VehicleSort value) => switch (value) {
    VehicleSort.relevance => sortRelevance,
    VehicleSort.priceAsc => sortPriceAsc,
    VehicleSort.priceDesc => sortPriceDesc,
    VehicleSort.category => sortCategory,
  };

  String bookingStatus(BookingStatus value) => switch (value) {
    BookingStatus.held => statusHeld,
    BookingStatus.pendingPartner => statusPendingPartner,
    BookingStatus.confirmed => statusConfirmed,
    BookingStatus.active => statusActive,
    BookingStatus.completed => statusCompleted,
    BookingStatus.rejected => statusRejected,
    BookingStatus.cancelled => statusCancelled,
    BookingStatus.expired => statusExpired,
    BookingStatus.unknown => statusUnknown,
  };

  String paymentStatus(PaymentStatus value) => switch (value) {
    PaymentStatus.unpaid => paymentUnpaid,
    PaymentStatus.authorized => paymentAuthorized,
    PaymentStatus.captured => paymentCaptured,
    PaymentStatus.partiallyRefunded => paymentPartiallyRefunded,
    PaymentStatus.refunded => paymentRefunded,
    PaymentStatus.failed => paymentFailedStatus,
    PaymentStatus.voided => paymentVoided,
    PaymentStatus.unknown => statusUnknown,
  };

  String depositStatus(DepositStatus value) => switch (value) {
    DepositStatus.notHeld => depositNotHeld,
    DepositStatus.held => depositHeld,
    DepositStatus.released => depositReleased,
    DepositStatus.partiallyReleased => depositPartiallyReleased,
    DepositStatus.unknown => statusUnknown,
  };

  String verificationStatus(VerificationStatus value) => switch (value) {
    VerificationStatus.notStarted => verificationNotStarted,
    VerificationStatus.submitted => verificationSubmitted,
    VerificationStatus.verified => verificationVerified,
    VerificationStatus.rejected => verificationRejected,
    VerificationStatus.unknown => statusUnknown,
  };

  String documentStatus(DocumentStatus value) => switch (value) {
    DocumentStatus.missing => docMissing,
    DocumentStatus.submitted => docSubmitted,
    DocumentStatus.approved => docApproved,
    DocumentStatus.rejected => docRejected,
    DocumentStatus.expired => docExpired,
    DocumentStatus.unknown => statusUnknown,
  };

  String supportStatus(SupportStatus value) => switch (value) {
    SupportStatus.open => supportStatusOpen,
    SupportStatus.inProgress => supportStatusInProgress,
    SupportStatus.resolved => supportStatusResolved,
    SupportStatus.unknown => statusUnknown,
  };

  String bookingGroup(BookingGroup value) => switch (value) {
    BookingGroup.upcoming => tabUpcoming,
    BookingGroup.pending => tabPending,
    BookingGroup.active => tabActive,
    BookingGroup.completed => tabCompleted,
    BookingGroup.cancelled => tabCancelled,
  };

  String bookingGroupEmpty(BookingGroup value) => switch (value) {
    BookingGroup.upcoming => bookingsEmptyUpcoming,
    BookingGroup.pending => bookingsEmptyPending,
    BookingGroup.active => bookingsEmptyActive,
    BookingGroup.completed => bookingsEmptyCompleted,
    BookingGroup.cancelled => bookingsEmptyCancelled,
  };

  String paymentMethod(String code) => switch (code) {
    'card' => paymentMethodCard,
    'upi' => paymentMethodUpi,
    'apple_pay' => paymentMethodApplePay,
    _ => code,
  };

  String periodError(RentalPeriodError error) => switch (error) {
    RentalPeriodError.missing => periodMissing,
    RentalPeriodError.pickupTooSoon => periodPickupTooSoon,
    RentalPeriodError.returnBeforePickup => periodReturnBeforePickup,
    RentalPeriodError.tooShort => periodTooShort,
    RentalPeriodError.tooLong => periodTooLong,
    RentalPeriodError.tooFarAhead => periodTooFarAhead,
  };

  String fieldError(FieldError error, {int minAge = 21}) => switch (error) {
    FieldError.required => fieldRequired,
    FieldError.tooShort => fieldTooShort,
    FieldError.tooLong => fieldTooLong,
    FieldError.invalidPhone => fieldInvalidPhone,
    FieldError.invalidEmail => fieldInvalidEmail,
    FieldError.invalidDate => fieldInvalidDate,
    FieldError.underage => fieldUnderage(minAge),
  };

  /// User-facing message for a failure: the server's message for 4xx
  /// responses (contract: user-safe), a generic one otherwise. Never a
  /// stack trace.
  String failure(ApiFailure failure) {
    switch (failure.code) {
      case ErrorCodes.network:
        return errorNetwork;
      case ErrorCodes.timeout:
        return errorTimeout;
      case ErrorCodes.sessionExpired:
        return errorSessionExpired;
    }
    if (failure.isServerError) return errorServer;
    if (failure.hasDisplayableMessage) return failure.message!;
    return switch (failure.code) {
      ErrorCodes.unauthenticated => errorUnauthenticated,
      ErrorCodes.forbidden => errorForbidden,
      ErrorCodes.notFound => errorNotFound,
      ErrorCodes.validationFailed => errorValidation,
      ErrorCodes.vehicleUnavailable => errorVehicleUnavailable,
      ErrorCodes.quoteExpired => errorQuoteExpired,
      ErrorCodes.holdExpired => errorHoldExpired,
      ErrorCodes.paymentFailed => errorPaymentFailed,
      ErrorCodes.invalidStateTransition => errorInvalidState,
      ErrorCodes.rateLimited => errorRateLimited,
      ErrorCodes.fileTooLarge => errorFileTooLarge,
      ErrorCodes.unsupportedFileType => errorUnsupportedFile,
      ErrorCodes.conflict || ErrorCodes.idempotencyConflict => errorConflict,
      _ => errorUnknown,
    };
  }
}
