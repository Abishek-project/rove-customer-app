import 'package:flutter/material.dart';

import 'rove_tokens.dart';

/// Builds the Material 3 theme from the Rove tokens: one accent colour,
/// flat surfaces, hairline borders, Inter at 400/500/600.
abstract final class RoveTheme {
  /// [textTheme] lets the app inject Inter (google_fonts) while tests use
  /// the default font.
  static ThemeData light({TextTheme Function(TextTheme)? textTheme}) {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: RoveColors.primary,
      onPrimary: Colors.white,
      primaryContainer: RoveColors.primaryTint,
      onPrimaryContainer: RoveColors.primaryPressed,
      secondary: RoveColors.textSecondary,
      onSecondary: Colors.white,
      secondaryContainer: RoveColors.inputFill,
      onSecondaryContainer: RoveColors.textPrimary,
      error: RoveColors.danger,
      onError: Colors.white,
      errorContainer: RoveColors.dangerTint,
      onErrorContainer: RoveColors.danger,
      surface: RoveColors.surface,
      onSurface: RoveColors.textPrimary,
      onSurfaceVariant: RoveColors.textSecondary,
      surfaceContainerLowest: RoveColors.surface,
      surfaceContainerLow: RoveColors.background,
      surfaceContainer: RoveColors.background,
      surfaceContainerHigh: RoveColors.inputFill,
      surfaceContainerHighest: RoveColors.inputFill,
      outline: RoveColors.border,
      outlineVariant: RoveColors.border,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: RoveColors.textPrimary,
      onInverseSurface: Colors.white,
      inversePrimary: RoveColors.primaryTint,
      surfaceTint: Colors.transparent,
    );

    final base = _textTheme(ThemeData.light().textTheme);
    final text = textTheme == null ? base : _textTheme(textTheme(base));

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: RoveColors.background,
      textTheme: text,
      splashFactory: InkSparkle.splashFactory,
      dividerTheme: const DividerThemeData(
        color: RoveColors.border,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: RoveColors.background,
        foregroundColor: RoveColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleMedium,
      ),
      iconTheme: const IconThemeData(color: RoveColors.textSecondary, size: 22),
      cardTheme: CardThemeData(
        color: RoveColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: RoveRadius.cardAll,
          side: const BorderSide(color: RoveColors.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: RoveColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: RoveColors.border,
          disabledForegroundColor: RoveColors.textTertiary,
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(borderRadius: RoveRadius.cardAll),
          textStyle: text.labelLarge,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: RoveColors.textPrimary,
          minimumSize: const Size(64, 48),
          side: const BorderSide(color: RoveColors.border),
          shape: RoundedRectangleBorder(borderRadius: RoveRadius.cardAll),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: RoveColors.primary,
          minimumSize: const Size(48, 44),
          textStyle: text.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: RoveRadius.smallAll),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: RoveColors.inputFill,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintStyle: text.bodyLarge?.copyWith(color: RoveColors.textTertiary),
        helperStyle: text.bodySmall,
        errorStyle: text.bodySmall?.copyWith(color: RoveColors.danger),
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
          borderSide: const BorderSide(color: RoveColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: const BorderSide(color: RoveColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: RoveRadius.smallAll,
          borderSide: const BorderSide(color: RoveColors.danger, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: RoveColors.surface,
        selectedColor: RoveColors.primaryTint,
        side: const BorderSide(color: RoveColors.border),
        shape: const StadiumBorder(),
        labelStyle: text.bodyMedium,
        secondaryLabelStyle: text.bodyMedium?.copyWith(
          color: RoveColors.primary,
        ),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: RoveColors.surface,
        elevation: 0,
        height: 64,
        indicatorColor: RoveColors.primaryTint,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelSmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? RoveColors.primary
                : RoveColors.textSecondary,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 22,
            color: states.contains(WidgetState.selected)
                ? RoveColors.primary
                : RoveColors.textSecondary,
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: RoveColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RoveRadius.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: RoveColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RoveRadius.sheet),
        ),
        titleTextStyle: text.titleMedium,
        contentTextStyle: text.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: RoveColors.textPrimary,
        contentTextStyle: text.bodyMedium?.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: RoveRadius.smallAll),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? RoveColors.primary
              : RoveColors.border,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? RoveColors.primary : null,
        ),
        side: const BorderSide(color: RoveColors.textTertiary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? RoveColors.primary
              : RoveColors.textTertiary,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: RoveColors.primary,
        linearTrackColor: RoveColors.border,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        iconColor: RoveColors.textSecondary,
        titleTextStyle: text.bodyLarge,
        subtitleTextStyle: text.bodyMedium?.copyWith(
          color: RoveColors.textSecondary,
        ),
        minVerticalPadding: 12,
      ),
    );
  }

  /// Type scale 12 / 14 / 16 / 18 / 22 / 28, weights 400 / 500 / 600.
  static TextTheme _textTheme(TextTheme base) {
    TextStyle? s(
      TextStyle? style,
      double size,
      FontWeight weight, {
      Color color = RoveColors.textPrimary,
      double? height,
    }) => style?.copyWith(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: 0,
    );
    return base.copyWith(
      displaySmall: s(base.displaySmall, 28, FontWeight.w600, height: 1.2),
      headlineMedium: s(base.headlineMedium, 28, FontWeight.w600, height: 1.2),
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
        color: RoveColors.textSecondary,
        height: 1.4,
      ),
      labelLarge: s(base.labelLarge, 16, FontWeight.w500),
      labelMedium: s(base.labelMedium, 14, FontWeight.w500),
      labelSmall: s(base.labelSmall, 12, FontWeight.w500),
    );
  }
}

extension RoveTextX on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
}
