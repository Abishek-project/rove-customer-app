import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/config/app_env.dart';
import '../core/localization/l10n.dart';
import '../core/location/location_service.dart';
import '../core/preferences/preferences_cubit.dart';
import '../features/authentication/bloc/auth_bloc.dart';
import '../features/favorites/bloc/favorites_bloc.dart';
import '../features/onboarding/bloc/countries_cubit.dart';
import '../features/search/bloc/search_bloc.dart';
import '../features/search/bloc/trip_cubit.dart';
import '../shared/repositories/auth_repository.dart';
import '../shared/repositories/booking_repository.dart';
import '../shared/repositories/favorites_repository.dart';
import '../shared/repositories/payment_repository.dart';
import '../shared/repositories/profile_repository.dart';
import '../shared/repositories/reference_repository.dart';
import '../shared/repositories/support_repository.dart';
import '../shared/repositories/vehicle_repository.dart';
import 'di.dart';
import 'router.dart';
import 'theme/rove_theme.dart';

/// Root widget: repository providers (DI), app-wide blocs and the router.
class RoveApp extends StatelessWidget {
  const RoveApp({super.key, required this.deps, this.fontFamily});

  final AppDependencies deps;

  /// The bundled font in the app; tests use the default font.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppEnv>.value(value: deps.env),
        RepositoryProvider<AuthRepository>.value(value: deps.auth),
        RepositoryProvider<ReferenceRepository>.value(value: deps.reference),
        RepositoryProvider<VehicleRepository>.value(value: deps.vehicles),
        RepositoryProvider<FavoritesRepository>.value(value: deps.favorites),
        RepositoryProvider<BookingRepository>.value(value: deps.bookings),
        RepositoryProvider<PaymentRepository>.value(value: deps.payments),
        RepositoryProvider<ProfileRepository>.value(value: deps.profile),
        RepositoryProvider<SupportRepository>.value(value: deps.support),
        RepositoryProvider<LocationService>.value(value: deps.location),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PreferencesCubit(deps.prefs)),
          BlocProvider(create: (_) => CountriesCubit(deps.reference)..load()),
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: deps.auth,
              profileRepository: deps.profile,
            )..add(const AuthStarted()),
          ),
          BlocProvider(create: (_) => TripCubit()),
          BlocProvider(create: (_) => SearchBloc(deps.vehicles)),
          BlocProvider(create: (_) => FavoritesBloc(deps.favorites)),
        ],
        child: _AppView(fontFamily: fontFamily),
      ),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({this.fontFamily});

  final String? fontFamily;

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late final GoRouter _router = buildRouter(
    auth: context.read<AuthBloc>(),
    preferences: context.read<PreferencesCubit>(),
  );
  late final ThemeData _light = RoveTheme.light(fontFamily: widget.fontFamily);
  late final ThemeData _dark = RoveTheme.dark(fontFamily: widget.fontFamily);

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  /// Keeps the trip's country/city in step with preferences and countries.
  void _syncTrip() {
    final prefs = context.read<PreferencesCubit>().state;
    final countries = context.read<CountriesCubit>().state;
    final code = prefs.countryCode;
    if (code == null) return;
    final country = countries.byCode(code);
    final trip = context.read<TripCubit>();
    final city = country?.cityById(prefs.cityId) ?? country?.cities.firstOrNull;
    if (trip.state.countryCode != code || trip.state.city?.id != city?.id) {
      trip.setCountry(code, city: city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (a, b) => a.status != b.status,
          listener: (context, state) async {
            final favorites = context.read<FavoritesBloc>();
            final prefs = context.read<PreferencesCubit>();
            switch (state.status) {
              case AuthStatus.authenticated:
                final profile = state.me?.profile;
                if (profile?.countryCode != null &&
                    prefs.state.countryCode != profile!.countryCode) {
                  await prefs.setCountry(
                    profile.countryCode!,
                    cityId: profile.cityId,
                  );
                } else if (prefs.state.cityId == null &&
                    profile?.cityId != null) {
                  await prefs.setCity(profile!.cityId);
                }
                favorites.add(const FavoritesLoaded());
              case AuthStatus.unauthenticated:
                favorites.add(const FavoritesCleared());
                await prefs.clearPersonal();
              default:
                break;
            }
          },
        ),
        BlocListener<PreferencesCubit, PreferencesState>(
          listenWhen: (a, b) =>
              a.countryCode != b.countryCode || a.cityId != b.cityId,
          listener: (context, _) => _syncTrip(),
        ),
        BlocListener<CountriesCubit, CountriesState>(
          listenWhen: (a, b) => a.countries != b.countries,
          listener: (context, _) => _syncTrip(),
        ),
      ],
      child:
          BlocSelector<PreferencesCubit, PreferencesState, (String, ThemeMode)>(
            selector: (s) => (s.languageCode, s.themeMode),
            builder: (context, prefs) => MaterialApp.router(
              onGenerateTitle: (context) => context.l10n.appName,
              debugShowCheckedModeBanner: false,
              theme: _light,
              darkTheme: _dark,
              themeMode: prefs.$2,
              routerConfig: _router,
              locale: Locale(prefs.$1),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          ),
    );
  }
}
