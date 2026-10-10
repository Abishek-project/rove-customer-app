import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/models/vehicle.dart';

/// Device-local preferences: chosen country/city, language and recently
/// viewed cars. Nothing sensitive is stored here.
class PreferencesState extends Equatable {
  const PreferencesState({
    this.countryCode,
    this.cityId,
    this.languageCode = 'en',
    this.recentlyViewed = const [],
    this.themeMode = ThemeMode.dark,
  });

  final String? countryCode;
  final String? cityId;
  final String languageCode;
  final List<VehicleSummary> recentlyViewed;

  /// Appearance: dark by default (DESIGN v2), or system / light.
  final ThemeMode themeMode;

  bool get hasCountry => countryCode != null;

  PreferencesState copyWith({
    String? Function()? countryCode,
    String? Function()? cityId,
    String? languageCode,
    List<VehicleSummary>? recentlyViewed,
    ThemeMode? themeMode,
  }) => PreferencesState(
    countryCode: countryCode != null ? countryCode() : this.countryCode,
    cityId: cityId != null ? cityId() : this.cityId,
    languageCode: languageCode ?? this.languageCode,
    recentlyViewed: recentlyViewed ?? this.recentlyViewed,
    themeMode: themeMode ?? this.themeMode,
  );

  @override
  List<Object?> get props => [
    countryCode,
    cityId,
    languageCode,
    recentlyViewed,
    themeMode,
  ];
}

class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit(this._prefs) : super(_read(_prefs));

  static const _countryKey = 'prefs.country';
  static const _cityKey = 'prefs.city';
  static const _languageKey = 'prefs.language';
  static const _recentKey = 'prefs.recent';
  static const _themeKey = 'prefs.theme';
  static const maxRecent = 10;

  final SharedPreferences _prefs;

  static PreferencesState _read(SharedPreferences prefs) {
    var recent = <VehicleSummary>[];
    try {
      final raw = prefs.getStringList(_recentKey) ?? const [];
      recent = raw
          .map(
            (e) =>
                VehicleSummary.fromJson(jsonDecode(e) as Map<String, dynamic>),
          )
          .toList();
    } on Object {
      recent = [];
    }
    return PreferencesState(
      countryCode: prefs.getString(_countryKey),
      cityId: prefs.getString(_cityKey),
      languageCode: prefs.getString(_languageKey) ?? 'en',
      recentlyViewed: recent,
      themeMode: ThemeMode.values.firstWhere(
        (m) => m.name == prefs.getString(_themeKey),
        orElse: () => ThemeMode.dark,
      ),
    );
  }

  /// Selecting a different country clears the city (cities are per country)
  /// and the recently viewed list (prices are per country).
  Future<void> setCountry(String code, {String? cityId}) async {
    final changed = code != state.countryCode;
    emit(
      state.copyWith(
        countryCode: () => code,
        cityId: () => cityId ?? (changed ? null : state.cityId),
        recentlyViewed: changed ? const [] : null,
      ),
    );
    await _prefs.setString(_countryKey, code);
    if (state.cityId == null) {
      await _prefs.remove(_cityKey);
    } else {
      await _prefs.setString(_cityKey, state.cityId!);
    }
    if (changed) await _prefs.remove(_recentKey);
  }

  Future<void> setCity(String? cityId) async {
    emit(state.copyWith(cityId: () => cityId));
    if (cityId == null) {
      await _prefs.remove(_cityKey);
    } else {
      await _prefs.setString(_cityKey, cityId);
    }
  }

  Future<void> setLanguage(String code) async {
    emit(state.copyWith(languageCode: code));
    await _prefs.setString(_languageKey, code);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _prefs.setString(_themeKey, mode.name);
  }

  Future<void> addRecentlyViewed(VehicleSummary vehicle) async {
    final list = [
      vehicle,
      ...state.recentlyViewed.where((v) => v.id != vehicle.id),
    ].take(maxRecent).toList();
    emit(state.copyWith(recentlyViewed: list));
    await _prefs.setStringList(
      _recentKey,
      list.map((v) => jsonEncode(v.toJson())).toList(),
    );
  }

  /// Called on sign-out: keep the country, forget browsing history.
  Future<void> clearPersonal() async {
    emit(state.copyWith(recentlyViewed: const []));
    await _prefs.remove(_recentKey);
  }
}
