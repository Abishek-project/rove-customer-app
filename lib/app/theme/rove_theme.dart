import 'package:flutter/material.dart';

import 'rove_tokens.dart';

/// Material 3 theme built from the Rove v2 tokens: dark by default, one
/// sky-blue accent, pill controls, flat surfaces (shadows only on overlays).
abstract final class RoveTheme {
  /// Bundled family declared in pubspec.yaml.
  static const fontFamily = 'PlusJakartaSans';

  /// [fontFamily] is null in tests (default test font).
  static ThemeData dark({String? fontFamily}) =>
      build(RovePalette.dark, Brightness.dark, fontFamily: fontFamily);

  static ThemeData light({String? fontFamily}) =>
      build(RovePalette.light, Brightness.light, fontFamily: fontFamily);

  static ThemeData build(
    RovePalette c,
    Brightness brightness, {
    String? fontFamily,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      primaryContainer: c.primaryTint,
      onPrimaryContainer: c.primary,
      secondary: c.textSecondary,
      onSecondary: c.background,
      secondaryContainer: c.inputFill,
      onSecondaryContainer: c.textPrimary,
      error: c.danger,
      onError: Colors.white,
      errorContainer: c.dangerTint,
      onErrorContainer: c.danger,
      surface: c.surface,
      onSurface: c.textPrimary,
      onSurfaceVariant: c.textSecondary,
      surfaceContainerLowest: c.background,
      surfaceContainerLow: c.surface,
      surfaceContainer: c.surface,
      surfaceContainerHigh: c.inputFill,
      surfaceContainerHighest: c.surface3,
      outline: c.border,
      outlineVariant: c.border,
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: c.textPrimary,
      onInverseSurface: c.background,
      inversePrimary: c.primaryTint,
      surfaceTint: Colors.transparent,
    );

    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final text = _textTheme(
      fontFamily == null ? base : base.apply(fontFamily: fontFamily),
      c,
    );
    const pill = StadiumBorder();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      textTheme: text,
      extensions: [c],
      splashFactory: InkSparkle.splashFactory,
      dividerTheme: DividerThemeData(color: c.border, thickness: 1, space: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: text.titleSmall,
      ),
      iconTheme: IconThemeData(color: c.textSecondary, size: 22),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: RoveRadius.cardAll),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.accentFill,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.inputFill,
          disabledForegroundColor: c.textTertiary,
          minimumSize: const Size(64, 52),
          shape: pill,
          textStyle: text.labelLarge,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.textPrimary,
          minimumSize: const Size(64, 52),
          side: BorderSide(color: c.textTertiary),
          shape: pill,
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.primary,
          minimumSize: const Size(48, 44),
          textStyle: text.labelMedium,
          shape: pill,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: c.textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.inputFill,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        hintStyle: text.bodyLarge?.copyWith(color: c.textTertiary),
        helperStyle: text.bodySmall,
        errorStyle: text.bodySmall?.copyWith(color: c.danger),
        border: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: BorderSide(color: c.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: BorderSide(color: c.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: BorderSide(color: c.danger, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.inputFill,
        selectedColor: c.accentFill,
        side: BorderSide.none,
        shape: pill,
        labelStyle: text.bodyMedium,
        secondaryLabelStyle: text.bodyMedium?.copyWith(color: c.onPrimary),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: c.surface,
        showDragHandle: true,
        dragHandleColor: c.textTertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RoveRadius.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RoveRadius.sheet),
        ),
        titleTextStyle: text.titleMedium,
        contentTextStyle: text.bodyMedium,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: c.surface,
        headerForegroundColor: c.textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RoveRadius.sheet),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RoveRadius.sheet),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.surface3,
        contentTextStyle: text.bodyMedium?.copyWith(color: c.textPrimary),
        actionTextColor: c.primary,
        shape: RoundedRectangleBorder(borderRadius: RoveRadius.smallAll),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accentFill : c.surface3,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accentFill : null,
        ),
        checkColor: WidgetStateProperty.all(c.onPrimary),
        side: BorderSide(color: c.textTertiary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.primary : c.textTertiary,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.primary,
        linearTrackColor: c.inputFill,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        iconColor: c.textSecondary,
        titleTextStyle: text.bodyLarge,
        subtitleTextStyle: text.bodyMedium?.copyWith(color: c.textSecondary),
        minVerticalPadding: 12,
      ),
      tabBarTheme: TabBarThemeData(
        labelStyle: text.labelMedium,
        unselectedLabelStyle: text.labelMedium,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          backgroundColor: c.inputFill,
          foregroundColor: c.textSecondary,
          selectedBackgroundColor: c.accentFill,
          selectedForegroundColor: c.onPrimary,
          side: BorderSide.none,
          shape: pill,
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(c.inputFill),
        ),
      ),
    );
  }

  /// Plus Jakarta Sans scale: 12 / 14 / 16 / 18 / 22 / 28 / 34, weights
  /// 400–700, tight tracking on large sizes.
  static TextTheme _textTheme(TextTheme base, RovePalette c) {
    TextStyle? s(
      TextStyle? style,
      double size,
      FontWeight weight, {
      Color? color,
      double? height,
    }) => style?.copyWith(
      fontSize: size,
      fontWeight: weight,
      color: color ?? c.textPrimary,
      height: height,
      letterSpacing: size >= 22 ? -0.2 : 0,
    );
    return base.copyWith(
      displaySmall: s(base.displaySmall, 34, FontWeight.w700, height: 1.15),
      headlineMedium: s(base.headlineMedium, 28, FontWeight.w700, height: 1.2),
      headlineSmall: s(base.headlineSmall, 22, FontWeight.w600, height: 1.25),
      titleLarge: s(base.titleLarge, 22, FontWeight.w600, height: 1.25),
      titleMedium: s(base.titleMedium, 18, FontWeight.w600, height: 1.3),
      titleSmall: s(base.titleSmall, 16, FontWeight.w600, height: 1.35),
      bodyLarge: s(base.bodyLarge, 16, FontWeight.w400, height: 1.45),
      bodyMedium: s(base.bodyMedium, 14, FontWeight.w400, height: 1.45),
      bodySmall: s(
        base.bodySmall,
        12,
        FontWeight.w400,
        color: c.textSecondary,
        height: 1.4,
      ),
      labelLarge: s(base.labelLarge, 16, FontWeight.w600),
      labelMedium: s(base.labelMedium, 14, FontWeight.w500),
      labelSmall: s(base.labelSmall, 12, FontWeight.w500),
    );
  }
}

extension RoveTextX on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
}
