import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Rove'**
  String get appName;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingLabel;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get navSaved;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Check your connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'This is taking too long. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Please try again shortly.'**
  String get errorServer;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait a moment and try again.'**
  String get errorRateLimited;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Please sign in again.'**
  String get errorSessionExpired;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that.'**
  String get errorNotFound;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have access to this.'**
  String get errorForbidden;

  /// No description provided for @errorUnauthenticated.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue.'**
  String get errorUnauthenticated;

  /// No description provided for @errorVehicleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This car is no longer available for your dates.'**
  String get errorVehicleUnavailable;

  /// No description provided for @errorQuoteExpired.
  ///
  /// In en, this message translates to:
  /// **'Your price expired. Review the updated price to continue.'**
  String get errorQuoteExpired;

  /// No description provided for @errorHoldExpired.
  ///
  /// In en, this message translates to:
  /// **'Your booking hold expired. Please start again.'**
  String get errorHoldExpired;

  /// No description provided for @errorPaymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Your payment didn\'t go through. No money was taken.'**
  String get errorPaymentFailed;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Some details need your attention.'**
  String get errorValidation;

  /// No description provided for @errorInvalidState.
  ///
  /// In en, this message translates to:
  /// **'This booking has changed. Refresh to see its current status.'**
  String get errorInvalidState;

  /// No description provided for @errorFileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'This file is too large.'**
  String get errorFileTooLarge;

  /// No description provided for @errorUnsupportedFile.
  ///
  /// In en, this message translates to:
  /// **'Upload a PDF, JPEG or PNG file.'**
  String get errorUnsupportedFile;

  /// No description provided for @errorConflict.
  ///
  /// In en, this message translates to:
  /// **'This conflicts with a recent change. Refresh and try again.'**
  String get errorConflict;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @fieldTooShort.
  ///
  /// In en, this message translates to:
  /// **'Too short'**
  String get fieldTooShort;

  /// No description provided for @fieldTooLong.
  ///
  /// In en, this message translates to:
  /// **'Too long'**
  String get fieldTooLong;

  /// No description provided for @fieldInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number with country code'**
  String get fieldInvalidPhone;

  /// No description provided for @fieldInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get fieldInvalidEmail;

  /// No description provided for @fieldInvalidDate.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date'**
  String get fieldInvalidDate;

  /// No description provided for @fieldUnderage.
  ///
  /// In en, this message translates to:
  /// **'Drivers must be at least {age} years old'**
  String fieldUnderage(int age);

  /// No description provided for @periodMissing.
  ///
  /// In en, this message translates to:
  /// **'Choose pickup and return times'**
  String get periodMissing;

  /// No description provided for @periodPickupTooSoon.
  ///
  /// In en, this message translates to:
  /// **'Pickup must be at least 2 hours from now'**
  String get periodPickupTooSoon;

  /// No description provided for @periodReturnBeforePickup.
  ///
  /// In en, this message translates to:
  /// **'Return must be after pickup'**
  String get periodReturnBeforePickup;

  /// No description provided for @periodTooShort.
  ///
  /// In en, this message translates to:
  /// **'Rentals are at least 24 hours'**
  String get periodTooShort;

  /// No description provided for @periodTooLong.
  ///
  /// In en, this message translates to:
  /// **'Rentals can be up to 30 days'**
  String get periodTooLong;

  /// No description provided for @periodTooFarAhead.
  ///
  /// In en, this message translates to:
  /// **'Pickup must be within the next 180 days'**
  String get periodTooFarAhead;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Rent a car you can trust'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Compare verified rental companies in India and the UAE. The full price is shown before you book.'**
  String get welcomeBody;

  /// No description provided for @welcomeGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get welcomeGetStarted;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Premium car rental, simply.'**
  String get welcomeTagline;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Premium car rental in Dubai & Mumbai'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Compare cars from verified rental companies in the UAE and India.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'The full price, before you book'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Taxes and fees included. Refundable deposits shown separately.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Book in minutes'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'Upload your licence once, pay securely and track every booking.'**
  String get onboarding3Body;

  /// No description provided for @onboardingPage.
  ///
  /// In en, this message translates to:
  /// **'Page {index} of {count}'**
  String onboardingPage(int index, int count);

  /// No description provided for @countryTitle.
  ///
  /// In en, this message translates to:
  /// **'Where are you renting?'**
  String get countryTitle;

  /// No description provided for @countryBody.
  ///
  /// In en, this message translates to:
  /// **'Prices, taxes and payment options follow this country. You can change it later.'**
  String get countryBody;

  /// No description provided for @countryLoadError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load countries.'**
  String get countryLoadError;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @signInBody.
  ///
  /// In en, this message translates to:
  /// **'Signing in with Google doesn\'t verify your identity or licence. We\'ll ask for those before your first booking.'**
  String get signInBody;

  /// No description provided for @signInGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInGoogle;

  /// No description provided for @signInDevSection.
  ///
  /// In en, this message translates to:
  /// **'Development sign-in'**
  String get signInDevSection;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @signInWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign in with email'**
  String get signInWithEmail;

  /// No description provided for @signInCancelled.
  ///
  /// In en, this message translates to:
  /// **'Sign-in was cancelled.'**
  String get signInCancelled;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t sign you in. Please try again.'**
  String get signInFailed;

  /// No description provided for @signInInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get signInInvalidCredentials;

  /// No description provided for @signInLaunchFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t open Google sign-in.'**
  String get signInLaunchFailed;

  /// No description provided for @signInCallbackFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in didn\'t complete.'**
  String get signInCallbackFailed;

  /// No description provided for @signInCompleting.
  ///
  /// In en, this message translates to:
  /// **'Completing sign-in'**
  String get signInCompleting;

  /// No description provided for @signInWaiting.
  ///
  /// In en, this message translates to:
  /// **'Finish signing in with Google, then come back here.'**
  String get signInWaiting;

  /// No description provided for @signInLegal.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to Rove\'s terms and privacy policy.'**
  String get signInLegal;

  /// No description provided for @completeProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'A few details'**
  String get completeProfileTitle;

  /// No description provided for @completeProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Rental companies use these to reach you about your bookings.'**
  String get completeProfileBody;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneLabel;

  /// No description provided for @phoneHelper.
  ///
  /// In en, this message translates to:
  /// **'Include the country code, e.g. {example}'**
  String phoneHelper(String example);

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Find a car'**
  String get homeTitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search cars'**
  String get searchPlaceholder;

  /// No description provided for @planTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your trip'**
  String get planTripTitle;

  /// No description provided for @notificationsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTooltip;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get categoryAll;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}'**
  String homeGreeting(String name);

  /// No description provided for @pickupCityLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup city'**
  String get pickupCityLabel;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select a city'**
  String get selectCity;

  /// No description provided for @pickupLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickupLabel;

  /// No description provided for @returnLabel.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnLabel;

  /// No description provided for @searchCars.
  ///
  /// In en, this message translates to:
  /// **'Search cars'**
  String get searchCars;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @locationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location access is off. Choose a city instead.'**
  String get locationDenied;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find a city near you. Choose one instead.'**
  String get locationUnavailable;

  /// No description provided for @nearestCityFound.
  ///
  /// In en, this message translates to:
  /// **'Showing cars near {city}'**
  String nearestCityFound(String city);

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Browse by type'**
  String get categoriesTitle;

  /// No description provided for @featuredTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featuredTitle;

  /// No description provided for @recentlyViewedTitle.
  ///
  /// In en, this message translates to:
  /// **'Recently viewed'**
  String get recentlyViewedTitle;

  /// No description provided for @savedCarsTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedCarsTitle;

  /// No description provided for @trustTitle.
  ///
  /// In en, this message translates to:
  /// **'Why Rove'**
  String get trustTitle;

  /// No description provided for @trustPricingTitle.
  ///
  /// In en, this message translates to:
  /// **'The full price, upfront'**
  String get trustPricingTitle;

  /// No description provided for @trustPricingBody.
  ///
  /// In en, this message translates to:
  /// **'Taxes and fees are included before you book. Deposits are shown separately and are refundable.'**
  String get trustPricingBody;

  /// No description provided for @trustPartnersTitle.
  ///
  /// In en, this message translates to:
  /// **'Verified rental companies'**
  String get trustPartnersTitle;

  /// No description provided for @trustPartnersBody.
  ///
  /// In en, this message translates to:
  /// **'Every rental company is reviewed before it can list cars on Rove.'**
  String get trustPartnersBody;

  /// No description provided for @featuredEmpty.
  ///
  /// In en, this message translates to:
  /// **'No featured cars in this city yet.'**
  String get featuredEmpty;

  /// No description provided for @categoryEconomy.
  ///
  /// In en, this message translates to:
  /// **'Economy'**
  String get categoryEconomy;

  /// No description provided for @categorySuv.
  ///
  /// In en, this message translates to:
  /// **'SUV'**
  String get categorySuv;

  /// No description provided for @categorySedan.
  ///
  /// In en, this message translates to:
  /// **'Sedan'**
  String get categorySedan;

  /// No description provided for @categoryLuxury.
  ///
  /// In en, this message translates to:
  /// **'Luxury'**
  String get categoryLuxury;

  /// No description provided for @categoryElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get categoryElectric;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @transmissionAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get transmissionAutomatic;

  /// No description provided for @transmissionManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get transmissionManual;

  /// No description provided for @fuelPetrol.
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get fuelPetrol;

  /// No description provided for @fuelDiesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get fuelDiesel;

  /// No description provided for @fuelHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get fuelHybrid;

  /// No description provided for @fuelElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get fuelElectric;

  /// No description provided for @seatsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 seat} other{{count} seats}}'**
  String seatsCount(int count);

  /// No description provided for @bagsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 bag} other{{count} bags}}'**
  String bagsCount(int count);

  /// No description provided for @doorsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 door} other{{count} doors}}'**
  String doorsCount(int count);

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String daysCount(int count);

  /// No description provided for @perDay.
  ///
  /// In en, this message translates to:
  /// **'/day'**
  String get perDay;

  /// No description provided for @priceTotalForDays.
  ///
  /// In en, this message translates to:
  /// **'{amount} total · {days, plural, =1{1 day} other{{days} days}}'**
  String priceTotalForDays(String amount, int days);

  /// No description provided for @deliveryPill.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryPill;

  /// No description provided for @anyOption.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get anyOption;

  /// No description provided for @searchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No cars} =1{1 car} other{{count} cars}}'**
  String searchResultsCount(int count);

  /// No description provided for @sortLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortLabel;

  /// No description provided for @sortRelevance.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get sortRelevance;

  /// No description provided for @sortPriceAsc.
  ///
  /// In en, this message translates to:
  /// **'Price: low to high'**
  String get sortPriceAsc;

  /// No description provided for @sortPriceDesc.
  ///
  /// In en, this message translates to:
  /// **'Price: high to low'**
  String get sortPriceDesc;

  /// No description provided for @sortCategory.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get sortCategory;

  /// No description provided for @filtersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTitle;

  /// No description provided for @filtersWithCount.
  ///
  /// In en, this message translates to:
  /// **'Filters ({count})'**
  String filtersWithCount(int count);

  /// No description provided for @showResults.
  ///
  /// In en, this message translates to:
  /// **'Show results'**
  String get showResults;

  /// No description provided for @filterCategory.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get filterCategory;

  /// No description provided for @filterTransmission.
  ///
  /// In en, this message translates to:
  /// **'Transmission'**
  String get filterTransmission;

  /// No description provided for @filterSeats.
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get filterSeats;

  /// No description provided for @filterSeatsAtLeast.
  ///
  /// In en, this message translates to:
  /// **'{count}+'**
  String filterSeatsAtLeast(int count);

  /// No description provided for @filterBudget.
  ///
  /// In en, this message translates to:
  /// **'Max daily price ({currency})'**
  String filterBudget(String currency);

  /// No description provided for @filterBudgetHint.
  ///
  /// In en, this message translates to:
  /// **'No limit'**
  String get filterBudgetHint;

  /// No description provided for @filterBudgetInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount, e.g. 250'**
  String get filterBudgetInvalid;

  /// No description provided for @filterDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery available'**
  String get filterDelivery;

  /// No description provided for @filterFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get filterFuel;

  /// No description provided for @searchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No cars available for these dates.'**
  String get searchEmpty;

  /// No description provided for @searchEmptyFiltered.
  ///
  /// In en, this message translates to:
  /// **'No cars match these filters.'**
  String get searchEmptyFiltered;

  /// No description provided for @changeSearch.
  ///
  /// In en, this message translates to:
  /// **'Change search'**
  String get changeSearch;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @loadMoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load more cars.'**
  String get loadMoreFailed;

  /// No description provided for @searchAvailabilityNote.
  ///
  /// In en, this message translates to:
  /// **'Only cars available for your full trip are shown.'**
  String get searchAvailabilityNote;

  /// No description provided for @datesTitle.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get datesTitle;

  /// No description provided for @datesTimezoneNote.
  ///
  /// In en, this message translates to:
  /// **'Times are local to {city} ({zone}).'**
  String datesTimezoneNote(String city, String zone);

  /// No description provided for @datesApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get datesApply;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pickDate;

  /// No description provided for @pickTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get pickTime;

  /// No description provided for @detailsSpecs.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsSpecs;

  /// No description provided for @detailsFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get detailsFeatures;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @carDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Car details'**
  String get carDetailsTitle;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get readLess;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get bookNow;

  /// No description provided for @fromPerDay.
  ///
  /// In en, this message translates to:
  /// **'from {price}'**
  String fromPerDay(String price);

  /// No description provided for @openInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMaps;

  /// No description provided for @policiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get policiesTitle;

  /// No description provided for @specMileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get specMileage;

  /// No description provided for @specDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get specDeposit;

  /// No description provided for @specTransmissionShort.
  ///
  /// In en, this message translates to:
  /// **'Transmission'**
  String get specTransmissionShort;

  /// No description provided for @mileageUnlimitedShort.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get mileageUnlimitedShort;

  /// No description provided for @mileagePerDayShort.
  ///
  /// In en, this message translates to:
  /// **'{km} km/day'**
  String mileagePerDayShort(int km);

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationTitle;

  /// No description provided for @dailyRate.
  ///
  /// In en, this message translates to:
  /// **'Daily rate'**
  String get dailyRate;

  /// No description provided for @specDoors.
  ///
  /// In en, this message translates to:
  /// **'Doors'**
  String get specDoors;

  /// No description provided for @specLuggage.
  ///
  /// In en, this message translates to:
  /// **'Luggage'**
  String get specLuggage;

  /// No description provided for @specMinRental.
  ///
  /// In en, this message translates to:
  /// **'Minimum rental'**
  String get specMinRental;

  /// No description provided for @specColor.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get specColor;

  /// No description provided for @detailsPartner.
  ///
  /// In en, this message translates to:
  /// **'Rental company'**
  String get detailsPartner;

  /// No description provided for @partnerVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified rental company'**
  String get partnerVerified;

  /// No description provided for @partnerUnverified.
  ///
  /// In en, this message translates to:
  /// **'Not yet verified'**
  String get partnerUnverified;

  /// No description provided for @detailsPickupDelivery.
  ///
  /// In en, this message translates to:
  /// **'Pickup and delivery'**
  String get detailsPickupDelivery;

  /// No description provided for @detailsPickupAt.
  ///
  /// In en, this message translates to:
  /// **'Pickup at {name}'**
  String detailsPickupAt(String name);

  /// No description provided for @detailsPickupArranged.
  ///
  /// In en, this message translates to:
  /// **'Pickup point shared after booking'**
  String get detailsPickupArranged;

  /// No description provided for @detailsDeliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery available · {fee}'**
  String detailsDeliveryFee(String fee);

  /// No description provided for @detailsDeliveryFree.
  ///
  /// In en, this message translates to:
  /// **'Free delivery available'**
  String get detailsDeliveryFree;

  /// No description provided for @detailsNoDelivery.
  ///
  /// In en, this message translates to:
  /// **'No delivery for this car'**
  String get detailsNoDelivery;

  /// No description provided for @detailsMileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get detailsMileage;

  /// No description provided for @mileageUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited mileage'**
  String get mileageUnlimited;

  /// No description provided for @mileageLimit.
  ///
  /// In en, this message translates to:
  /// **'{km} km per day included'**
  String mileageLimit(int km);

  /// No description provided for @extraKm.
  ///
  /// In en, this message translates to:
  /// **'Extra km'**
  String get extraKm;

  /// No description provided for @mileageExcess.
  ///
  /// In en, this message translates to:
  /// **'{fee} per extra km'**
  String mileageExcess(String fee);

  /// No description provided for @detailsFuelPolicy.
  ///
  /// In en, this message translates to:
  /// **'Fuel policy'**
  String get detailsFuelPolicy;

  /// No description provided for @fuelFullToFull.
  ///
  /// In en, this message translates to:
  /// **'Full to full: return with a full tank'**
  String get fuelFullToFull;

  /// No description provided for @fuelSameToSame.
  ///
  /// In en, this message translates to:
  /// **'Same to same: return at the pickup level'**
  String get fuelSameToSame;

  /// No description provided for @detailsDeposit.
  ///
  /// In en, this message translates to:
  /// **'Refundable deposit'**
  String get detailsDeposit;

  /// No description provided for @depositBody.
  ///
  /// In en, this message translates to:
  /// **'Held at pickup and released after the return inspection. Not part of the rental price.'**
  String get depositBody;

  /// No description provided for @detailsCancellation.
  ///
  /// In en, this message translates to:
  /// **'Cancellation'**
  String get detailsCancellation;

  /// No description provided for @detailsInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance and protection'**
  String get detailsInsurance;

  /// No description provided for @insuranceMissing.
  ///
  /// In en, this message translates to:
  /// **'Ask the rental company about protection before booking.'**
  String get insuranceMissing;

  /// No description provided for @detailsEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimated total'**
  String get detailsEstimate;

  /// No description provided for @estimateIncludes.
  ///
  /// In en, this message translates to:
  /// **'Includes taxes and fees · {days, plural, =1{1 day} other{{days} days}}'**
  String estimateIncludes(int days);

  /// No description provided for @estimateNoDates.
  ///
  /// In en, this message translates to:
  /// **'Choose dates to see the total'**
  String get estimateNoDates;

  /// No description provided for @detailsBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get detailsBook;

  /// No description provided for @detailsChooseDates.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get detailsChooseDates;

  /// No description provided for @detailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Not available for these dates'**
  String get detailsUnavailable;

  /// No description provided for @detailsMinDays.
  ///
  /// In en, this message translates to:
  /// **'Minimum rental: {count, plural, =1{1 day} other{{count} days}}'**
  String detailsMinDays(int count);

  /// No description provided for @bookingModeInstant.
  ///
  /// In en, this message translates to:
  /// **'Instant confirmation'**
  String get bookingModeInstant;

  /// No description provided for @bookingModeRequest.
  ///
  /// In en, this message translates to:
  /// **'Request to book: the rental company confirms within 24 hours'**
  String get bookingModeRequest;

  /// No description provided for @chargesRental.
  ///
  /// In en, this message translates to:
  /// **'Rental charges'**
  String get chargesRental;

  /// No description provided for @chargesConditional.
  ///
  /// In en, this message translates to:
  /// **'Only if they apply'**
  String get chargesConditional;

  /// No description provided for @saveVehicle.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveVehicle;

  /// No description provided for @unsaveVehicle.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get unsaveVehicle;

  /// No description provided for @favoriteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update saved cars.'**
  String get favoriteFailed;

  /// No description provided for @vehicleImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo of {vehicle}'**
  String vehicleImageLabel(String vehicle);

  /// No description provided for @vehiclePhotoCount.
  ///
  /// In en, this message translates to:
  /// **'{index} of {count}'**
  String vehiclePhotoCount(int index, int count);

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @stepTrip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get stepTrip;

  /// No description provided for @stepDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get stepDriver;

  /// No description provided for @stepVerification.
  ///
  /// In en, this message translates to:
  /// **'Licence'**
  String get stepVerification;

  /// No description provided for @stepReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get stepReview;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOf(int current, int total);

  /// No description provided for @tripTitle.
  ///
  /// In en, this message translates to:
  /// **'Your trip'**
  String get tripTitle;

  /// No description provided for @pickupLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get pickupLocationLabel;

  /// No description provided for @deliverToMe.
  ///
  /// In en, this message translates to:
  /// **'Deliver to an address'**
  String get deliverToMe;

  /// No description provided for @deliveryAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get deliveryAddressLabel;

  /// No description provided for @deliveryAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Building, street, area'**
  String get deliveryAddressHint;

  /// No description provided for @deliveryFeeNote.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee: {fee}'**
  String deliveryFeeNote(String fee);

  /// No description provided for @driverTitle.
  ///
  /// In en, this message translates to:
  /// **'Driver details'**
  String get driverTitle;

  /// No description provided for @dateOfBirthLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirthLabel;

  /// No description provided for @dateOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get dateOfBirthHint;

  /// No description provided for @driverAgeNote.
  ///
  /// In en, this message translates to:
  /// **'The driver must be 21 or older and bring their licence and ID to pickup.'**
  String get driverAgeNote;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Licence and ID'**
  String get verificationTitle;

  /// No description provided for @verificationBody.
  ///
  /// In en, this message translates to:
  /// **'The rental company checks these at pickup. Files go securely to Rove and aren\'t kept on your phone.'**
  String get verificationBody;

  /// No description provided for @docMissing.
  ///
  /// In en, this message translates to:
  /// **'Not uploaded'**
  String get docMissing;

  /// No description provided for @docSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get docSubmitted;

  /// No description provided for @docApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get docApproved;

  /// No description provided for @docRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get docRejected;

  /// No description provided for @docExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get docExpired;

  /// No description provided for @docRejectedReason.
  ///
  /// In en, this message translates to:
  /// **'Rejected: {reason}'**
  String docRejectedReason(String reason);

  /// No description provided for @uploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get uploadDocument;

  /// No description provided for @replaceDocument.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replaceDocument;

  /// No description provided for @uploadChoosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose a photo'**
  String get uploadChoosePhoto;

  /// No description provided for @uploadTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get uploadTakePhoto;

  /// No description provided for @uploadChoosePdf.
  ///
  /// In en, this message translates to:
  /// **'Choose a PDF'**
  String get uploadChoosePdf;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading'**
  String get uploading;

  /// No description provided for @verificationReady.
  ///
  /// In en, this message translates to:
  /// **'Documents submitted. You can continue.'**
  String get verificationReady;

  /// No description provided for @reviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review and pay'**
  String get reviewTitle;

  /// No description provided for @priceDetails.
  ///
  /// In en, this message translates to:
  /// **'Price details'**
  String get priceDetails;

  /// No description provided for @priceTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get priceTotal;

  /// No description provided for @priceDepositNote.
  ///
  /// In en, this message translates to:
  /// **'Held at pickup, not charged now'**
  String get priceDepositNote;

  /// No description provided for @priceConditionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Possible extra charges'**
  String get priceConditionalTitle;

  /// No description provided for @perKmUnit.
  ///
  /// In en, this message translates to:
  /// **'per km'**
  String get perKmUnit;

  /// No description provided for @quoteHeldUntil.
  ///
  /// In en, this message translates to:
  /// **'Price held until {time}'**
  String quoteHeldUntil(String time);

  /// No description provided for @quoteExpired.
  ///
  /// In en, this message translates to:
  /// **'This price expired.'**
  String get quoteExpired;

  /// No description provided for @refreshPrice.
  ///
  /// In en, this message translates to:
  /// **'Refresh price'**
  String get refreshPrice;

  /// No description provided for @gettingPrice.
  ///
  /// In en, this message translates to:
  /// **'Getting your price'**
  String get gettingPrice;

  /// No description provided for @termsAccept.
  ///
  /// In en, this message translates to:
  /// **'I accept the rental terms, the cancellation policy and the Rove terms of service.'**
  String get termsAccept;

  /// No description provided for @readTerms.
  ///
  /// In en, this message translates to:
  /// **'Read the terms'**
  String get readTerms;

  /// No description provided for @termsRequired.
  ///
  /// In en, this message translates to:
  /// **'Accept the terms to continue.'**
  String get termsRequired;

  /// No description provided for @bookAndPay.
  ///
  /// In en, this message translates to:
  /// **'Book and pay {amount}'**
  String bookAndPay(String amount);

  /// No description provided for @requestAndAuthorize.
  ///
  /// In en, this message translates to:
  /// **'Request booking · {amount}'**
  String requestAndAuthorize(String amount);

  /// No description provided for @requestModeNote.
  ///
  /// In en, this message translates to:
  /// **'Your payment is authorised now and only charged if the rental company accepts.'**
  String get requestModeNote;

  /// No description provided for @instantModeNote.
  ///
  /// In en, this message translates to:
  /// **'Your booking is confirmed as soon as the payment succeeds.'**
  String get instantModeNote;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentTitle;

  /// No description provided for @paymentAmountDue.
  ///
  /// In en, this message translates to:
  /// **'Amount due'**
  String get paymentAmountDue;

  /// No description provided for @paymentMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethodLabel;

  /// No description provided for @paymentMethodCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get paymentMethodCard;

  /// No description provided for @paymentMethodUpi.
  ///
  /// In en, this message translates to:
  /// **'UPI'**
  String get paymentMethodUpi;

  /// No description provided for @paymentMethodApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get paymentMethodApplePay;

  /// No description provided for @paymentTestMode.
  ///
  /// In en, this message translates to:
  /// **'Test mode: no real payment is taken.'**
  String get paymentTestMode;

  /// No description provided for @paymentSimulateDecline.
  ///
  /// In en, this message translates to:
  /// **'Simulate a declined payment'**
  String get paymentSimulateDecline;

  /// No description provided for @paymentPay.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String paymentPay(String amount);

  /// No description provided for @paymentAuthorize.
  ///
  /// In en, this message translates to:
  /// **'Authorise {amount}'**
  String paymentAuthorize(String amount);

  /// No description provided for @paymentProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing payment'**
  String get paymentProcessing;

  /// No description provided for @resultConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking confirmed'**
  String get resultConfirmedTitle;

  /// No description provided for @resultConfirmedBody.
  ///
  /// In en, this message translates to:
  /// **'{partner} has confirmed your booking.'**
  String resultConfirmedBody(String partner);

  /// No description provided for @resultPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get resultPendingTitle;

  /// No description provided for @resultPendingBody.
  ///
  /// In en, this message translates to:
  /// **'{partner} will respond by {time}. Your payment is authorised, not charged.'**
  String resultPendingBody(String partner, String time);

  /// No description provided for @resultHeldTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment not completed'**
  String get resultHeldTitle;

  /// No description provided for @resultHeldBody.
  ///
  /// In en, this message translates to:
  /// **'The car is held for you until {time}.'**
  String resultHeldBody(String time);

  /// No description provided for @resultDeclinedTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment declined'**
  String get resultDeclinedTitle;

  /// No description provided for @resultDeclinedBody.
  ///
  /// In en, this message translates to:
  /// **'No money was taken. The car is held until {time}.'**
  String resultDeclinedBody(String time);

  /// No description provided for @resultExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Hold expired'**
  String get resultExpiredTitle;

  /// No description provided for @resultExpiredBody.
  ///
  /// In en, this message translates to:
  /// **'The car was released. Start a new booking to try again.'**
  String get resultExpiredBody;

  /// No description provided for @resultRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Request declined'**
  String get resultRejectedTitle;

  /// No description provided for @resultRejectedBody.
  ///
  /// In en, this message translates to:
  /// **'The rental company declined this request. Any authorisation has been released.'**
  String get resultRejectedBody;

  /// No description provided for @resultUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'No longer available'**
  String get resultUnavailableTitle;

  /// No description provided for @resultUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'This car was booked for your dates. Try different dates or another car.'**
  String get resultUnavailableBody;

  /// No description provided for @resultCancelledTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled'**
  String get resultCancelledTitle;

  /// No description provided for @resultUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t confirm the result'**
  String get resultUnknownTitle;

  /// No description provided for @resultUnknownBody.
  ///
  /// In en, this message translates to:
  /// **'Check Bookings for the latest status. You won\'t be charged twice.'**
  String get resultUnknownBody;

  /// No description provided for @referenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get referenceLabel;

  /// No description provided for @viewBooking.
  ///
  /// In en, this message translates to:
  /// **'View booking'**
  String get viewBooking;

  /// No description provided for @backToExplore.
  ///
  /// In en, this message translates to:
  /// **'Back to explore'**
  String get backToExplore;

  /// No description provided for @retryPayment.
  ///
  /// In en, this message translates to:
  /// **'Try payment again'**
  String get retryPayment;

  /// No description provided for @chooseOtherDates.
  ///
  /// In en, this message translates to:
  /// **'Choose other dates'**
  String get chooseOtherDates;

  /// No description provided for @checkStatus.
  ///
  /// In en, this message translates to:
  /// **'Check status'**
  String get checkStatus;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsTitle;

  /// No description provided for @tabUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get tabUpcoming;

  /// No description provided for @tabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get tabPending;

  /// No description provided for @tabActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get tabActive;

  /// No description provided for @tabCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get tabCompleted;

  /// No description provided for @tabCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get tabCancelled;

  /// No description provided for @bookingsEmptyUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming trips.'**
  String get bookingsEmptyUpcoming;

  /// No description provided for @bookingsEmptyPending.
  ///
  /// In en, this message translates to:
  /// **'No pending requests.'**
  String get bookingsEmptyPending;

  /// No description provided for @bookingsEmptyActive.
  ///
  /// In en, this message translates to:
  /// **'No active rentals.'**
  String get bookingsEmptyActive;

  /// No description provided for @bookingsEmptyCompleted.
  ///
  /// In en, this message translates to:
  /// **'No completed rentals yet.'**
  String get bookingsEmptyCompleted;

  /// No description provided for @bookingsEmptyCancelled.
  ///
  /// In en, this message translates to:
  /// **'No cancelled bookings.'**
  String get bookingsEmptyCancelled;

  /// No description provided for @findACar.
  ///
  /// In en, this message translates to:
  /// **'Find a car'**
  String get findACar;

  /// No description provided for @statusHeld.
  ///
  /// In en, this message translates to:
  /// **'Awaiting payment'**
  String get statusHeld;

  /// No description provided for @statusPendingPartner.
  ///
  /// In en, this message translates to:
  /// **'Awaiting confirmation'**
  String get statusPendingPartner;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get statusActive;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get statusRejected;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Updating'**
  String get statusUnknown;

  /// No description provided for @paymentUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Not paid'**
  String get paymentUnpaid;

  /// No description provided for @paymentAuthorized.
  ///
  /// In en, this message translates to:
  /// **'Authorised'**
  String get paymentAuthorized;

  /// No description provided for @paymentCaptured.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paymentCaptured;

  /// No description provided for @paymentPartiallyRefunded.
  ///
  /// In en, this message translates to:
  /// **'Partially refunded'**
  String get paymentPartiallyRefunded;

  /// No description provided for @paymentRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get paymentRefunded;

  /// No description provided for @paymentFailedStatus.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get paymentFailedStatus;

  /// No description provided for @paymentVoided.
  ///
  /// In en, this message translates to:
  /// **'Authorisation released'**
  String get paymentVoided;

  /// No description provided for @depositNotHeld.
  ///
  /// In en, this message translates to:
  /// **'Not held'**
  String get depositNotHeld;

  /// No description provided for @depositHeld.
  ///
  /// In en, this message translates to:
  /// **'Held'**
  String get depositHeld;

  /// No description provided for @depositReleased.
  ///
  /// In en, this message translates to:
  /// **'Released'**
  String get depositReleased;

  /// No description provided for @depositPartiallyReleased.
  ///
  /// In en, this message translates to:
  /// **'Partially released'**
  String get depositPartiallyReleased;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get bookingTitle;

  /// No description provided for @bookingWhen.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get bookingWhen;

  /// No description provided for @bookingWhere.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get bookingWhere;

  /// No description provided for @bookingDeliveryTo.
  ///
  /// In en, this message translates to:
  /// **'Delivered to {address}'**
  String bookingDeliveryTo(String address);

  /// No description provided for @bookingPaymentSection.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get bookingPaymentSection;

  /// No description provided for @bookingPaymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get bookingPaymentStatus;

  /// No description provided for @bookingDepositStatus.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get bookingDepositStatus;

  /// No description provided for @bookingCancellationFee.
  ///
  /// In en, this message translates to:
  /// **'Cancellation fee'**
  String get bookingCancellationFee;

  /// No description provided for @bookingRefundAmount.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get bookingRefundAmount;

  /// No description provided for @bookingRefundPending.
  ///
  /// In en, this message translates to:
  /// **'Refunds show as completed once the payment provider confirms them.'**
  String get bookingRefundPending;

  /// No description provided for @bookingConditions.
  ///
  /// In en, this message translates to:
  /// **'Rental conditions'**
  String get bookingConditions;

  /// No description provided for @bookingDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get bookingDriver;

  /// No description provided for @bookingPickupReturn.
  ///
  /// In en, this message translates to:
  /// **'Pickup and return'**
  String get bookingPickupReturn;

  /// No description provided for @bookingPickupGuide.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get bookingPickupGuide;

  /// No description provided for @bookingReturnGuide.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get bookingReturnGuide;

  /// No description provided for @bookingReceipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get bookingReceipt;

  /// No description provided for @bookingGetHelp.
  ///
  /// In en, this message translates to:
  /// **'Get help'**
  String get bookingGetHelp;

  /// No description provided for @bookingCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get bookingCancel;

  /// No description provided for @bookingCompletePayment.
  ///
  /// In en, this message translates to:
  /// **'Complete payment'**
  String get bookingCompletePayment;

  /// No description provided for @bookingPayBy.
  ///
  /// In en, this message translates to:
  /// **'Complete payment by {time} to keep this booking.'**
  String bookingPayBy(String time);

  /// No description provided for @bookingPartnerDue.
  ///
  /// In en, this message translates to:
  /// **'{partner} responds by {time}.'**
  String bookingPartnerDue(String partner, String time);

  /// No description provided for @bookingHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get bookingHistory;

  /// No description provided for @bookingPartner.
  ///
  /// In en, this message translates to:
  /// **'Rental company'**
  String get bookingPartner;

  /// No description provided for @cancelDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this booking?'**
  String get cancelDialogTitle;

  /// No description provided for @cancelFreePaid.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation. {refund} will be refunded.'**
  String cancelFreePaid(String refund);

  /// No description provided for @cancelFreeUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation. You haven\'t been charged.'**
  String get cancelFreeUnpaid;

  /// No description provided for @cancelWithFee.
  ///
  /// In en, this message translates to:
  /// **'A cancellation fee of {fee} applies. {refund} will be refunded.'**
  String cancelWithFee(String fee, String refund);

  /// No description provided for @cancelReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get cancelReasonLabel;

  /// No description provided for @cancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get cancelConfirm;

  /// No description provided for @cancelKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep booking'**
  String get cancelKeep;

  /// No description provided for @cancelDone.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled.'**
  String get cancelDone;

  /// No description provided for @cancelChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking cancellation terms'**
  String get cancelChecking;

  /// No description provided for @pickupTitle.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickupTitle;

  /// No description provided for @returnTitle.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnTitle;

  /// No description provided for @receiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receiptTitle;

  /// No description provided for @instructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructionsTitle;

  /// No description provided for @bringDocuments.
  ///
  /// In en, this message translates to:
  /// **'Bring with you'**
  String get bringDocuments;

  /// No description provided for @inspectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle inspection'**
  String get inspectionTitle;

  /// No description provided for @inspectionPendingPickup.
  ///
  /// In en, this message translates to:
  /// **'The rental company records the car’s condition with you at pickup.'**
  String get inspectionPendingPickup;

  /// No description provided for @inspectionPendingReturn.
  ///
  /// In en, this message translates to:
  /// **'The rental company records the car’s condition with you at return.'**
  String get inspectionPendingReturn;

  /// No description provided for @inspectionRecorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded {time}'**
  String inspectionRecorded(String time);

  /// No description provided for @odometerLabel.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get odometerLabel;

  /// No description provided for @odometerValue.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String odometerValue(int km);

  /// No description provided for @fuelLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Fuel level'**
  String get fuelLevelLabel;

  /// No description provided for @fuelLevelValue.
  ///
  /// In en, this message translates to:
  /// **'{pct}%'**
  String fuelLevelValue(int pct);

  /// No description provided for @damagesNone.
  ///
  /// In en, this message translates to:
  /// **'No damage noted'**
  String get damagesNone;

  /// No description provided for @damagesNoted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 mark noted} other{{count} marks noted}}'**
  String damagesNoted(int count);

  /// No description provided for @photosRecorded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No photos} =1{1 photo} other{{count} photos}}'**
  String photosRecorded(int count);

  /// No description provided for @photosLabel.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photosLabel;

  /// No description provided for @pickupConfirmedAt.
  ///
  /// In en, this message translates to:
  /// **'Picked up {time}'**
  String pickupConfirmedAt(String time);

  /// No description provided for @returnConfirmedAt.
  ///
  /// In en, this message translates to:
  /// **'Returned {time}'**
  String returnConfirmedAt(String time);

  /// No description provided for @pickupNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not picked up yet'**
  String get pickupNotYet;

  /// No description provided for @returnNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not returned yet'**
  String get returnNotYet;

  /// No description provided for @receiptCharged.
  ///
  /// In en, this message translates to:
  /// **'Total charged'**
  String get receiptCharged;

  /// No description provided for @receiptAuthorized.
  ///
  /// In en, this message translates to:
  /// **'Total authorised'**
  String get receiptAuthorized;

  /// No description provided for @receiptOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding charges'**
  String get receiptOutstanding;

  /// No description provided for @receiptNoOutstanding.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get receiptNoOutstanding;

  /// No description provided for @receiptOutstandingSupport.
  ///
  /// In en, this message translates to:
  /// **'Questions about extra charges? Contact support.'**
  String get receiptOutstandingSupport;

  /// No description provided for @savedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedTitle;

  /// No description provided for @savedEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cars you save appear here.'**
  String get savedEmpty;

  /// No description provided for @browseCars.
  ///
  /// In en, this message translates to:
  /// **'Browse cars'**
  String get browseCars;

  /// No description provided for @savedRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from saved'**
  String get savedRemoved;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @showProfile.
  ///
  /// In en, this message translates to:
  /// **'Show profile'**
  String get showProfile;

  /// No description provided for @settingsGroup.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsGroup;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personalInformation;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get paymentMethods;

  /// No description provided for @paymentMethodsBody.
  ///
  /// In en, this message translates to:
  /// **'You choose how to pay at checkout. Rove never stores your card details.'**
  String get paymentMethodsBody;

  /// No description provided for @paymentMethodsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available in {country}'**
  String paymentMethodsAvailable(String country);

  /// No description provided for @countryAndCity.
  ///
  /// In en, this message translates to:
  /// **'Country and city'**
  String get countryAndCity;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @partnersGroup.
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get partnersGroup;

  /// No description provided for @listYourFleet.
  ///
  /// In en, this message translates to:
  /// **'List your fleet on Rove'**
  String get listYourFleet;

  /// No description provided for @supportGroup.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportGroup;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEdit;

  /// No description provided for @profileVerification.
  ///
  /// In en, this message translates to:
  /// **'Licence and ID'**
  String get profileVerification;

  /// No description provided for @profileBookingHistory.
  ///
  /// In en, this message translates to:
  /// **'Booking history'**
  String get profileBookingHistory;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileSupport.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get profileSupport;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get profilePrivacy;

  /// No description provided for @profileTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get profileTerms;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOut;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign out of Rove?'**
  String get signOutConfirm;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Request account deletion'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll delete your account and personal data once any open bookings are settled. Records we must keep by law are retained.'**
  String get deleteAccountBody;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Request deletion'**
  String get deleteAccountConfirm;

  /// No description provided for @deletionRequestedOn.
  ///
  /// In en, this message translates to:
  /// **'Deletion requested on {date}'**
  String deletionRequestedOn(String date);

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileSaved;

  /// No description provided for @verificationNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get verificationNotStarted;

  /// No description provided for @verificationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get verificationSubmitted;

  /// No description provided for @verificationVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verificationVerified;

  /// No description provided for @verificationRejected.
  ///
  /// In en, this message translates to:
  /// **'Action needed'**
  String get verificationRejected;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get settingsRegion;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @notifEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get notifEmail;

  /// No description provided for @notifEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Confirmations and receipts'**
  String get notifEmailBody;

  /// No description provided for @notifPush.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get notifPush;

  /// No description provided for @notifPushBody.
  ///
  /// In en, this message translates to:
  /// **'Pickup reminders and status changes'**
  String get notifPushBody;

  /// No description provided for @notifMarketing.
  ///
  /// In en, this message translates to:
  /// **'Offers and news'**
  String get notifMarketing;

  /// No description provided for @notifMarketingBody.
  ///
  /// In en, this message translates to:
  /// **'Occasional offers from Rove'**
  String get notifMarketingBody;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get languageHindi;

  /// No description provided for @languageComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get languageComingSoon;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get supportTitle;

  /// No description provided for @supportNewRequest.
  ///
  /// In en, this message translates to:
  /// **'New request'**
  String get supportNewRequest;

  /// No description provided for @supportSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get supportSubject;

  /// No description provided for @supportMessage.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get supportMessage;

  /// No description provided for @supportSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get supportSend;

  /// No description provided for @supportSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent. We\'ll reply by email.'**
  String get supportSent;

  /// No description provided for @supportEmpty.
  ///
  /// In en, this message translates to:
  /// **'No support requests yet.'**
  String get supportEmpty;

  /// No description provided for @supportAboutBooking.
  ///
  /// In en, this message translates to:
  /// **'About booking {reference}'**
  String supportAboutBooking(String reference);

  /// No description provided for @supportStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get supportStatusOpen;

  /// No description provided for @supportStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get supportStatusInProgress;

  /// No description provided for @supportStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get supportStatusResolved;

  /// No description provided for @supportYourRequests.
  ///
  /// In en, this message translates to:
  /// **'Your requests'**
  String get supportYourRequests;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyTitle;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get termsTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'Rove collects only what is needed to run your rentals: your name, email, phone number, country, booking history and the driving licence and ID documents you upload.\n\nDocuments are stored privately and shared only with the rental company handling your booking, through short-lived secure links. Rental companies never see your email address or date of birth.\n\nPayments are handled by our payment provider; Rove never stores your card details.\n\nYou can request deletion of your account from your profile at any time. Some booking records are kept where the law requires it.'**
  String get privacyBody;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'Rove is a marketplace. Your rental agreement is with the rental company shown on your booking.\n\nPrices shown at checkout are calculated by Rove and include taxes and service fees. The refundable deposit is held at pickup and released after the return inspection.\n\nCancellation fees follow the policy shown on the car and on your booking. Refunds are complete only when the payment provider confirms them.\n\nThe driver must be at least 21, hold a valid driving licence and bring the documents uploaded to Rove to pickup.'**
  String get termsBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
