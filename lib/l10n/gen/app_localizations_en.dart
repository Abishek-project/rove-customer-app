// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Rove';

  @override
  String get retry => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueLabel => 'Continue';

  @override
  String get save => 'Save';

  @override
  String get done => 'Done';

  @override
  String get close => 'Close';

  @override
  String get edit => 'Edit';

  @override
  String get apply => 'Apply';

  @override
  String get reset => 'Reset';

  @override
  String get change => 'Change';

  @override
  String get confirm => 'Confirm';

  @override
  String get ok => 'OK';

  @override
  String get undo => 'Undo';

  @override
  String get seeAll => 'See all';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get notSet => 'Not set';

  @override
  String get navExplore => 'Explore';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navSaved => 'Saved';

  @override
  String get navProfile => 'Profile';

  @override
  String get errorNetwork =>
      'You\'re offline. Check your connection and try again.';

  @override
  String get errorTimeout => 'This is taking too long. Please try again.';

  @override
  String get errorServer =>
      'Something went wrong on our side. Please try again shortly.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get errorRateLimited =>
      'Too many requests. Please wait a moment and try again.';

  @override
  String get errorSessionExpired =>
      'Your session expired. Please sign in again.';

  @override
  String get errorNotFound => 'We couldn\'t find that.';

  @override
  String get errorForbidden => 'You don\'t have access to this.';

  @override
  String get errorUnauthenticated => 'Please sign in to continue.';

  @override
  String get errorVehicleUnavailable =>
      'This car is no longer available for your dates.';

  @override
  String get errorQuoteExpired =>
      'Your price expired. Review the updated price to continue.';

  @override
  String get errorHoldExpired =>
      'Your booking hold expired. Please start again.';

  @override
  String get errorPaymentFailed =>
      'Your payment didn\'t go through. No money was taken.';

  @override
  String get errorValidation => 'Some details need your attention.';

  @override
  String get errorInvalidState =>
      'This booking has changed. Refresh to see its current status.';

  @override
  String get errorFileTooLarge => 'This file is too large.';

  @override
  String get errorUnsupportedFile => 'Upload a PDF, JPEG or PNG file.';

  @override
  String get errorConflict =>
      'This conflicts with a recent change. Refresh and try again.';

  @override
  String get fieldRequired => 'Required';

  @override
  String get fieldTooShort => 'Too short';

  @override
  String get fieldTooLong => 'Too long';

  @override
  String get fieldInvalidPhone => 'Enter a phone number with country code';

  @override
  String get fieldInvalidEmail => 'Enter a valid email address';

  @override
  String get fieldInvalidDate => 'Enter a valid date';

  @override
  String fieldUnderage(int age) {
    return 'Drivers must be at least $age years old';
  }

  @override
  String get periodMissing => 'Choose pickup and return times';

  @override
  String get periodPickupTooSoon => 'Pickup must be at least 2 hours from now';

  @override
  String get periodReturnBeforePickup => 'Return must be after pickup';

  @override
  String get periodTooShort => 'Rentals are at least 24 hours';

  @override
  String get periodTooLong => 'Rentals can be up to 30 days';

  @override
  String get periodTooFarAhead => 'Pickup must be within the next 180 days';

  @override
  String get welcomeTitle => 'Rent a car you can trust';

  @override
  String get welcomeBody =>
      'Compare verified rental companies in India and the UAE. The full price is shown before you book.';

  @override
  String get welcomeGetStarted => 'Get started';

  @override
  String get welcomeTagline => 'Premium car rental, simply.';

  @override
  String get logIn => 'Log in';

  @override
  String get signUp => 'Sign up';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get onboarding1Title => 'Premium car rental in Dubai & Mumbai';

  @override
  String get onboarding1Body =>
      'Compare cars from verified rental companies in the UAE and India.';

  @override
  String get onboarding2Title => 'The full price, before you book';

  @override
  String get onboarding2Body =>
      'Taxes and fees included. Refundable deposits shown separately.';

  @override
  String get onboarding3Title => 'Book in minutes';

  @override
  String get onboarding3Body =>
      'Upload your licence once, pay securely and track every booking.';

  @override
  String onboardingPage(int index, int count) {
    return 'Page $index of $count';
  }

  @override
  String get countryTitle => 'Where are you renting?';

  @override
  String get countryBody =>
      'Prices, taxes and payment options follow this country. You can change it later.';

  @override
  String get countryLoadError => 'We couldn\'t load countries.';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInBody =>
      'Signing in with Google doesn\'t verify your identity or licence. We\'ll ask for those before your first booking.';

  @override
  String get signInGoogle => 'Continue with Google';

  @override
  String get signInDevSection => 'Development sign-in';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signInWithEmail => 'Sign in with email';

  @override
  String get signInCancelled => 'Sign-in was cancelled.';

  @override
  String get signInFailed => 'We couldn\'t sign you in. Please try again.';

  @override
  String get signInInvalidCredentials => 'Email or password is incorrect.';

  @override
  String get signInLaunchFailed => 'We couldn\'t open Google sign-in.';

  @override
  String get signInCallbackFailed => 'Google sign-in didn\'t complete.';

  @override
  String get signInCompleting => 'Completing sign-in';

  @override
  String get signInWaiting =>
      'Finish signing in with Google, then come back here.';

  @override
  String get signInLegal =>
      'By continuing you agree to Rove\'s terms and privacy policy.';

  @override
  String get completeProfileTitle => 'A few details';

  @override
  String get completeProfileBody =>
      'Rental companies use these to reach you about your bookings.';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get phoneLabel => 'Phone number';

  @override
  String phoneHelper(String example) {
    return 'Include the country code, e.g. $example';
  }

  @override
  String get countryLabel => 'Country';

  @override
  String get cityLabel => 'City';

  @override
  String get homeTitle => 'Find a car';

  @override
  String get searchPlaceholder => 'Search cars';

  @override
  String get planTripTitle => 'Plan your trip';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get categoryAll => 'See all';

  @override
  String homeGreeting(String name) {
    return 'Hi $name';
  }

  @override
  String get pickupCityLabel => 'Pickup city';

  @override
  String get selectCity => 'Select a city';

  @override
  String get pickupLabel => 'Pickup';

  @override
  String get returnLabel => 'Return';

  @override
  String get searchCars => 'Search cars';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get locationDenied => 'Location access is off. Choose a city instead.';

  @override
  String get locationUnavailable =>
      'We couldn\'t find a city near you. Choose one instead.';

  @override
  String nearestCityFound(String city) {
    return 'Showing cars near $city';
  }

  @override
  String get categoriesTitle => 'Browse by type';

  @override
  String get featuredTitle => 'Featured';

  @override
  String get recentlyViewedTitle => 'Recently viewed';

  @override
  String get savedCarsTitle => 'Saved';

  @override
  String get trustTitle => 'Why Rove';

  @override
  String get trustPricingTitle => 'The full price, upfront';

  @override
  String get trustPricingBody =>
      'Taxes and fees are included before you book. Deposits are shown separately and are refundable.';

  @override
  String get trustPartnersTitle => 'Verified rental companies';

  @override
  String get trustPartnersBody =>
      'Every rental company is reviewed before it can list cars on Rove.';

  @override
  String get featuredEmpty => 'No featured cars in this city yet.';

  @override
  String get categoryEconomy => 'Economy';

  @override
  String get categorySuv => 'SUV';

  @override
  String get categorySedan => 'Sedan';

  @override
  String get categoryLuxury => 'Luxury';

  @override
  String get categoryElectric => 'Electric';

  @override
  String get categoryOther => 'Other';

  @override
  String get transmissionAutomatic => 'Automatic';

  @override
  String get transmissionManual => 'Manual';

  @override
  String get fuelPetrol => 'Petrol';

  @override
  String get fuelDiesel => 'Diesel';

  @override
  String get fuelHybrid => 'Hybrid';

  @override
  String get fuelElectric => 'Electric';

  @override
  String seatsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seats',
      one: '1 seat',
    );
    return '$_temp0';
  }

  @override
  String bagsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bags',
      one: '1 bag',
    );
    return '$_temp0';
  }

  @override
  String doorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doors',
      one: '1 door',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get perDay => '/day';

  @override
  String priceTotalForDays(String amount, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return '$amount total · $_temp0';
  }

  @override
  String get deliveryPill => 'Delivery';

  @override
  String get anyOption => 'Any';

  @override
  String searchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cars',
      one: '1 car',
      zero: 'No cars',
    );
    return '$_temp0';
  }

  @override
  String get sortLabel => 'Sort';

  @override
  String get sortRelevance => 'Recommended';

  @override
  String get sortPriceAsc => 'Price: low to high';

  @override
  String get sortPriceDesc => 'Price: high to low';

  @override
  String get sortCategory => 'Vehicle type';

  @override
  String get filtersTitle => 'Filters';

  @override
  String filtersWithCount(int count) {
    return 'Filters ($count)';
  }

  @override
  String get showResults => 'Show results';

  @override
  String get filterCategory => 'Vehicle type';

  @override
  String get filterTransmission => 'Transmission';

  @override
  String get filterSeats => 'Seats';

  @override
  String filterSeatsAtLeast(int count) {
    return '$count+';
  }

  @override
  String filterBudget(String currency) {
    return 'Max daily price ($currency)';
  }

  @override
  String get filterBudgetHint => 'No limit';

  @override
  String get filterBudgetInvalid => 'Enter an amount, e.g. 250';

  @override
  String get filterDelivery => 'Delivery available';

  @override
  String get filterFuel => 'Fuel';

  @override
  String get searchEmpty => 'No cars available for these dates.';

  @override
  String get searchEmptyFiltered => 'No cars match these filters.';

  @override
  String get changeSearch => 'Change search';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get loadMoreFailed => 'Couldn\'t load more cars.';

  @override
  String get searchAvailabilityNote =>
      'Only cars available for your full trip are shown.';

  @override
  String get datesTitle => 'Dates';

  @override
  String datesTimezoneNote(String city, String zone) {
    return 'Times are local to $city ($zone).';
  }

  @override
  String get datesApply => 'Apply';

  @override
  String get pickDate => 'Date';

  @override
  String get pickTime => 'Time';

  @override
  String get detailsSpecs => 'Details';

  @override
  String get detailsFeatures => 'Features';

  @override
  String get back => 'Back';

  @override
  String get carDetailsTitle => 'Car details';

  @override
  String get readMore => 'Read more';

  @override
  String get readLess => 'Show less';

  @override
  String get bookNow => 'Book now';

  @override
  String fromPerDay(String price) {
    return 'from $price';
  }

  @override
  String get openInMaps => 'Open in Maps';

  @override
  String get policiesTitle => 'Policies';

  @override
  String get specMileage => 'Mileage';

  @override
  String get specDeposit => 'Deposit';

  @override
  String get specTransmissionShort => 'Transmission';

  @override
  String get mileageUnlimitedShort => 'Unlimited';

  @override
  String mileagePerDayShort(int km) {
    return '$km km/day';
  }

  @override
  String get locationTitle => 'Location';

  @override
  String get dailyRate => 'Daily rate';

  @override
  String get specDoors => 'Doors';

  @override
  String get specLuggage => 'Luggage';

  @override
  String get specMinRental => 'Minimum rental';

  @override
  String get specColor => 'Colour';

  @override
  String get detailsPartner => 'Rental company';

  @override
  String get partnerVerified => 'Verified rental company';

  @override
  String get partnerUnverified => 'Not yet verified';

  @override
  String get detailsPickupDelivery => 'Pickup and delivery';

  @override
  String detailsPickupAt(String name) {
    return 'Pickup at $name';
  }

  @override
  String get detailsPickupArranged => 'Pickup point shared after booking';

  @override
  String detailsDeliveryFee(String fee) {
    return 'Delivery available · $fee';
  }

  @override
  String get detailsDeliveryFree => 'Free delivery available';

  @override
  String get detailsNoDelivery => 'No delivery for this car';

  @override
  String get detailsMileage => 'Mileage';

  @override
  String get mileageUnlimited => 'Unlimited mileage';

  @override
  String mileageLimit(int km) {
    return '$km km per day included';
  }

  @override
  String get extraKm => 'Extra km';

  @override
  String mileageExcess(String fee) {
    return '$fee per extra km';
  }

  @override
  String get detailsFuelPolicy => 'Fuel policy';

  @override
  String get fuelFullToFull => 'Full to full: return with a full tank';

  @override
  String get fuelSameToSame => 'Same to same: return at the pickup level';

  @override
  String get detailsDeposit => 'Refundable deposit';

  @override
  String get depositBody =>
      'Held at pickup and released after the return inspection. Not part of the rental price.';

  @override
  String get detailsCancellation => 'Cancellation';

  @override
  String get detailsInsurance => 'Insurance and protection';

  @override
  String get insuranceMissing =>
      'Ask the rental company about protection before booking.';

  @override
  String get detailsEstimate => 'Estimated total';

  @override
  String estimateIncludes(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return 'Includes taxes and fees · $_temp0';
  }

  @override
  String get estimateNoDates => 'Choose dates to see the total';

  @override
  String get detailsBook => 'Book';

  @override
  String get detailsChooseDates => 'Choose dates';

  @override
  String get detailsUnavailable => 'Not available for these dates';

  @override
  String detailsMinDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return 'Minimum rental: $_temp0';
  }

  @override
  String get bookingModeInstant => 'Instant confirmation';

  @override
  String get bookingModeRequest =>
      'Request to book: the rental company confirms within 24 hours';

  @override
  String get chargesRental => 'Rental charges';

  @override
  String get chargesConditional => 'Only if they apply';

  @override
  String get saveVehicle => 'Save';

  @override
  String get unsaveVehicle => 'Remove from saved';

  @override
  String get favoriteFailed => 'Couldn\'t update saved cars.';

  @override
  String vehicleImageLabel(String vehicle) {
    return 'Photo of $vehicle';
  }

  @override
  String vehiclePhotoCount(int index, int count) {
    return '$index of $count';
  }

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get stepTrip => 'Trip';

  @override
  String get stepDriver => 'Driver';

  @override
  String get stepVerification => 'Licence';

  @override
  String get stepReview => 'Review';

  @override
  String stepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get tripTitle => 'Your trip';

  @override
  String get pickupLocationLabel => 'Pickup location';

  @override
  String get deliverToMe => 'Deliver to an address';

  @override
  String get deliveryAddressLabel => 'Delivery address';

  @override
  String get deliveryAddressHint => 'Building, street, area';

  @override
  String deliveryFeeNote(String fee) {
    return 'Delivery fee: $fee';
  }

  @override
  String get driverTitle => 'Driver details';

  @override
  String get dateOfBirthLabel => 'Date of birth';

  @override
  String get dateOfBirthHint => 'Select date';

  @override
  String get driverAgeNote =>
      'The driver must be 21 or older and bring their licence and ID to pickup.';

  @override
  String get verificationTitle => 'Licence and ID';

  @override
  String get verificationBody =>
      'The rental company checks these at pickup. Files go securely to Rove and aren\'t kept on your phone.';

  @override
  String get docMissing => 'Not uploaded';

  @override
  String get docSubmitted => 'Submitted';

  @override
  String get docApproved => 'Approved';

  @override
  String get docRejected => 'Rejected';

  @override
  String get docExpired => 'Expired';

  @override
  String docRejectedReason(String reason) {
    return 'Rejected: $reason';
  }

  @override
  String get uploadDocument => 'Upload';

  @override
  String get replaceDocument => 'Replace';

  @override
  String get uploadChoosePhoto => 'Choose a photo';

  @override
  String get uploadTakePhoto => 'Take a photo';

  @override
  String get uploadChoosePdf => 'Choose a PDF';

  @override
  String get uploading => 'Uploading';

  @override
  String get verificationReady => 'Documents submitted. You can continue.';

  @override
  String get reviewTitle => 'Review and pay';

  @override
  String get priceDetails => 'Price details';

  @override
  String get priceTotal => 'Total';

  @override
  String get priceDepositNote => 'Held at pickup, not charged now';

  @override
  String get priceConditionalTitle => 'Possible extra charges';

  @override
  String get perKmUnit => 'per km';

  @override
  String quoteHeldUntil(String time) {
    return 'Price held until $time';
  }

  @override
  String get quoteExpired => 'This price expired.';

  @override
  String get refreshPrice => 'Refresh price';

  @override
  String get gettingPrice => 'Getting your price';

  @override
  String get termsAccept =>
      'I accept the rental terms, the cancellation policy and the Rove terms of service.';

  @override
  String get readTerms => 'Read the terms';

  @override
  String get termsRequired => 'Accept the terms to continue.';

  @override
  String bookAndPay(String amount) {
    return 'Book and pay $amount';
  }

  @override
  String requestAndAuthorize(String amount) {
    return 'Request booking · $amount';
  }

  @override
  String get requestModeNote =>
      'Your payment is authorised now and only charged if the rental company accepts.';

  @override
  String get instantModeNote =>
      'Your booking is confirmed as soon as the payment succeeds.';

  @override
  String get paymentTitle => 'Payment';

  @override
  String get paymentAmountDue => 'Amount due';

  @override
  String get paymentMethodLabel => 'Payment method';

  @override
  String get paymentMethodCard => 'Card';

  @override
  String get paymentMethodUpi => 'UPI';

  @override
  String get paymentMethodApplePay => 'Apple Pay';

  @override
  String get paymentTestMode => 'Test mode: no real payment is taken.';

  @override
  String get paymentSimulateDecline => 'Simulate a declined payment';

  @override
  String paymentPay(String amount) {
    return 'Pay $amount';
  }

  @override
  String paymentAuthorize(String amount) {
    return 'Authorise $amount';
  }

  @override
  String get paymentProcessing => 'Processing payment';

  @override
  String get resultConfirmedTitle => 'Booking confirmed';

  @override
  String resultConfirmedBody(String partner) {
    return '$partner has confirmed your booking.';
  }

  @override
  String get resultPendingTitle => 'Request sent';

  @override
  String resultPendingBody(String partner, String time) {
    return '$partner will respond by $time. Your payment is authorised, not charged.';
  }

  @override
  String get resultHeldTitle => 'Payment not completed';

  @override
  String resultHeldBody(String time) {
    return 'The car is held for you until $time.';
  }

  @override
  String get resultDeclinedTitle => 'Payment declined';

  @override
  String resultDeclinedBody(String time) {
    return 'No money was taken. The car is held until $time.';
  }

  @override
  String get resultExpiredTitle => 'Hold expired';

  @override
  String get resultExpiredBody =>
      'The car was released. Start a new booking to try again.';

  @override
  String get resultRejectedTitle => 'Request declined';

  @override
  String get resultRejectedBody =>
      'The rental company declined this request. Any authorisation has been released.';

  @override
  String get resultUnavailableTitle => 'No longer available';

  @override
  String get resultUnavailableBody =>
      'This car was booked for your dates. Try different dates or another car.';

  @override
  String get resultCancelledTitle => 'Booking cancelled';

  @override
  String get resultUnknownTitle => 'We couldn\'t confirm the result';

  @override
  String get resultUnknownBody =>
      'Check Bookings for the latest status. You won\'t be charged twice.';

  @override
  String get referenceLabel => 'Reference';

  @override
  String get viewBooking => 'View booking';

  @override
  String get backToExplore => 'Back to explore';

  @override
  String get retryPayment => 'Try payment again';

  @override
  String get chooseOtherDates => 'Choose other dates';

  @override
  String get checkStatus => 'Check status';

  @override
  String get bookingsTitle => 'Bookings';

  @override
  String get tabUpcoming => 'Upcoming';

  @override
  String get tabPending => 'Pending';

  @override
  String get tabActive => 'Active';

  @override
  String get tabCompleted => 'Completed';

  @override
  String get tabCancelled => 'Cancelled';

  @override
  String get bookingsEmptyUpcoming => 'No upcoming trips.';

  @override
  String get bookingsEmptyPending => 'No pending requests.';

  @override
  String get bookingsEmptyActive => 'No active rentals.';

  @override
  String get bookingsEmptyCompleted => 'No completed rentals yet.';

  @override
  String get bookingsEmptyCancelled => 'No cancelled bookings.';

  @override
  String get findACar => 'Find a car';

  @override
  String get statusHeld => 'Awaiting payment';

  @override
  String get statusPendingPartner => 'Awaiting confirmation';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get statusActive => 'In progress';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusRejected => 'Declined';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusUnknown => 'Updating';

  @override
  String get paymentUnpaid => 'Not paid';

  @override
  String get paymentAuthorized => 'Authorised';

  @override
  String get paymentCaptured => 'Paid';

  @override
  String get paymentPartiallyRefunded => 'Partially refunded';

  @override
  String get paymentRefunded => 'Refunded';

  @override
  String get paymentFailedStatus => 'Failed';

  @override
  String get paymentVoided => 'Authorisation released';

  @override
  String get depositNotHeld => 'Not held';

  @override
  String get depositHeld => 'Held';

  @override
  String get depositReleased => 'Released';

  @override
  String get depositPartiallyReleased => 'Partially released';

  @override
  String get bookingTitle => 'Booking';

  @override
  String get bookingWhen => 'When';

  @override
  String get bookingWhere => 'Where';

  @override
  String bookingDeliveryTo(String address) {
    return 'Delivered to $address';
  }

  @override
  String get bookingPaymentSection => 'Payment';

  @override
  String get bookingPaymentStatus => 'Payment';

  @override
  String get bookingDepositStatus => 'Deposit';

  @override
  String get bookingCancellationFee => 'Cancellation fee';

  @override
  String get bookingRefundAmount => 'Refund';

  @override
  String get bookingRefundPending =>
      'Refunds show as completed once the payment provider confirms them.';

  @override
  String get bookingConditions => 'Rental conditions';

  @override
  String get bookingDriver => 'Driver';

  @override
  String get bookingPickupReturn => 'Pickup and return';

  @override
  String get bookingPickupGuide => 'Pickup';

  @override
  String get bookingReturnGuide => 'Return';

  @override
  String get bookingReceipt => 'Receipt';

  @override
  String get bookingGetHelp => 'Get help';

  @override
  String get bookingCancel => 'Cancel booking';

  @override
  String get bookingCompletePayment => 'Complete payment';

  @override
  String bookingPayBy(String time) {
    return 'Complete payment by $time to keep this booking.';
  }

  @override
  String bookingPartnerDue(String partner, String time) {
    return '$partner responds by $time.';
  }

  @override
  String get bookingHistory => 'History';

  @override
  String get bookingPartner => 'Rental company';

  @override
  String get cancelDialogTitle => 'Cancel this booking?';

  @override
  String cancelFreePaid(String refund) {
    return 'Free cancellation. $refund will be refunded.';
  }

  @override
  String get cancelFreeUnpaid =>
      'Free cancellation. You haven\'t been charged.';

  @override
  String cancelWithFee(String fee, String refund) {
    return 'A cancellation fee of $fee applies. $refund will be refunded.';
  }

  @override
  String get cancelReasonLabel => 'Reason (optional)';

  @override
  String get cancelConfirm => 'Cancel booking';

  @override
  String get cancelKeep => 'Keep booking';

  @override
  String get cancelDone => 'Booking cancelled.';

  @override
  String get cancelChecking => 'Checking cancellation terms';

  @override
  String get pickupTitle => 'Pickup';

  @override
  String get returnTitle => 'Return';

  @override
  String get receiptTitle => 'Receipt';

  @override
  String get instructionsTitle => 'Instructions';

  @override
  String get bringDocuments => 'Bring with you';

  @override
  String get inspectionTitle => 'Vehicle inspection';

  @override
  String get inspectionPendingPickup =>
      'The rental company records the car’s condition with you at pickup.';

  @override
  String get inspectionPendingReturn =>
      'The rental company records the car’s condition with you at return.';

  @override
  String inspectionRecorded(String time) {
    return 'Recorded $time';
  }

  @override
  String get odometerLabel => 'Odometer';

  @override
  String odometerValue(int km) {
    return '$km km';
  }

  @override
  String get fuelLevelLabel => 'Fuel level';

  @override
  String fuelLevelValue(int pct) {
    return '$pct%';
  }

  @override
  String get damagesNone => 'No damage noted';

  @override
  String damagesNoted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marks noted',
      one: '1 mark noted',
    );
    return '$_temp0';
  }

  @override
  String photosRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
      zero: 'No photos',
    );
    return '$_temp0';
  }

  @override
  String get photosLabel => 'Photos';

  @override
  String pickupConfirmedAt(String time) {
    return 'Picked up $time';
  }

  @override
  String returnConfirmedAt(String time) {
    return 'Returned $time';
  }

  @override
  String get pickupNotYet => 'Not picked up yet';

  @override
  String get returnNotYet => 'Not returned yet';

  @override
  String get receiptCharged => 'Total charged';

  @override
  String get receiptAuthorized => 'Total authorised';

  @override
  String get receiptOutstanding => 'Outstanding charges';

  @override
  String get receiptNoOutstanding => 'None';

  @override
  String get receiptOutstandingSupport =>
      'Questions about extra charges? Contact support.';

  @override
  String get savedTitle => 'Saved';

  @override
  String get savedEmpty => 'Cars you save appear here.';

  @override
  String get browseCars => 'Browse cars';

  @override
  String get savedRemoved => 'Removed from saved';

  @override
  String get profileTitle => 'Profile';

  @override
  String get showProfile => 'Show profile';

  @override
  String get settingsGroup => 'Settings';

  @override
  String get personalInformation => 'Personal information';

  @override
  String get paymentMethods => 'Payment methods';

  @override
  String get paymentMethodsBody =>
      'You choose how to pay at checkout. Rove never stores your card details.';

  @override
  String paymentMethodsAvailable(String country) {
    return 'Available in $country';
  }

  @override
  String get countryAndCity => 'Country and city';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get appearanceLight => 'Light';

  @override
  String get partnersGroup => 'Partners';

  @override
  String get listYourFleet => 'List your fleet on Rove';

  @override
  String get supportGroup => 'Support';

  @override
  String get profileEdit => 'Edit profile';

  @override
  String get profileVerification => 'Licence and ID';

  @override
  String get profileBookingHistory => 'Booking history';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileSupport => 'Help and support';

  @override
  String get profilePrivacy => 'Privacy policy';

  @override
  String get profileTerms => 'Terms of service';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get signOutConfirm => 'Sign out of Rove?';

  @override
  String get deleteAccount => 'Request account deletion';

  @override
  String get deleteAccountTitle => 'Delete your account?';

  @override
  String get deleteAccountBody =>
      'We\'ll delete your account and personal data once any open bookings are settled. Records we must keep by law are retained.';

  @override
  String get deleteAccountConfirm => 'Request deletion';

  @override
  String deletionRequestedOn(String date) {
    return 'Deletion requested on $date';
  }

  @override
  String get profileSaved => 'Profile updated';

  @override
  String get verificationNotStarted => 'Not started';

  @override
  String get verificationSubmitted => 'Under review';

  @override
  String get verificationVerified => 'Verified';

  @override
  String get verificationRejected => 'Action needed';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsRegion => 'Region';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get notifEmail => 'Email';

  @override
  String get notifEmailBody => 'Confirmations and receipts';

  @override
  String get notifPush => 'Push notifications';

  @override
  String get notifPushBody => 'Pickup reminders and status changes';

  @override
  String get notifMarketing => 'Offers and news';

  @override
  String get notifMarketingBody => 'Occasional offers from Rove';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String get languageComingSoon => 'Coming soon';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get supportTitle => 'Help and support';

  @override
  String get supportNewRequest => 'New request';

  @override
  String get supportSubject => 'Subject';

  @override
  String get supportMessage => 'How can we help?';

  @override
  String get supportSend => 'Send';

  @override
  String get supportSent => 'Request sent. We\'ll reply by email.';

  @override
  String get supportEmpty => 'No support requests yet.';

  @override
  String supportAboutBooking(String reference) {
    return 'About booking $reference';
  }

  @override
  String get supportStatusOpen => 'Open';

  @override
  String get supportStatusInProgress => 'In progress';

  @override
  String get supportStatusResolved => 'Resolved';

  @override
  String get supportYourRequests => 'Your requests';

  @override
  String get privacyTitle => 'Privacy policy';

  @override
  String get termsTitle => 'Terms of service';

  @override
  String get privacyBody =>
      'Rove collects only what is needed to run your rentals: your name, email, phone number, country, booking history and the driving licence and ID documents you upload.\n\nDocuments are stored privately and shared only with the rental company handling your booking, through short-lived secure links. Rental companies never see your email address or date of birth.\n\nPayments are handled by our payment provider; Rove never stores your card details.\n\nYou can request deletion of your account from your profile at any time. Some booking records are kept where the law requires it.';

  @override
  String get termsBody =>
      'Rove is a marketplace. Your rental agreement is with the rental company shown on your booking.\n\nPrices shown at checkout are calculated by Rove and include taxes and service fees. The refundable deposit is held at pickup and released after the return inspection.\n\nCancellation fees follow the policy shown on the car and on your booking. Refunds are complete only when the payment provider confirms them.\n\nThe driver must be at least 21, hold a valid driving licence and bring the documents uploaded to Rove to pickup.';
}
