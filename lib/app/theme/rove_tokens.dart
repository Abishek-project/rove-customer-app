import 'package:flutter/material.dart';

/// Rove design tokens v2 (shared/DESIGN.md): dark by default, one sky-blue
/// accent, soft dark surfaces. Identical values to the partner dashboard.
@immutable
class RovePalette extends ThemeExtension<RovePalette> {
  const RovePalette({
    required this.background,
    required this.surface,
    required this.inputFill,
    required this.surface3,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.primary,
    required this.primaryPressed,
    required this.primaryTint,
    required this.onPrimary,
    required this.success,
    required this.successTint,
    required this.warning,
    required this.warningTint,
    required this.danger,
    required this.dangerTint,
    required this.info,
    required this.infoTint,
    required this.overlayShadow,
  });

  /// `bg` — app canvas.
  final Color background;

  /// `surface` — cards, list groups.
  final Color surface;

  /// `surface-2` — inputs, chips, icon circles, raised surfaces.
  final Color inputFill;

  /// `surface-3` — pressed / selected rows.
  final Color surface3;
  final Color border;

  /// `text`, `text-2`, `text-3`.
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  /// `accent`, `accent-hover`, `accent-tint`, `on-accent`.
  final Color primary;
  final Color primaryPressed;
  final Color primaryTint;
  final Color onPrimary;

  final Color success;
  final Color successTint;
  final Color warning;
  final Color warningTint;
  final Color danger;
  final Color dangerTint;
  final Color info;
  final Color infoTint;
  final Color overlayShadow;

  static const _accent = Color(0xFF4BA3F2);

  static const dark = RovePalette(
    background: Color(0xFF0B0B0D),
    surface: Color(0xFF16161A),
    inputFill: Color(0xFF1E1E23),
    surface3: Color(0xFF26262C),
    border: Color(0xFF2A2A31),
    textPrimary: Color(0xFFF5F5F7),
    textSecondary: Color(0xFFA1A1AA),
    textTertiary: Color(0xFF6E6E78),
    primary: _accent,
    primaryPressed: Color(0xFF3A91E0),
    primaryTint: Color(0x244BA3F2),
    onPrimary: Colors.white,
    success: Color(0xFF34C77B),
    successTint: Color(0x2434C77B),
    warning: Color(0xFFF5A524),
    warningTint: Color(0x24F5A524),
    danger: Color(0xFFF2555A),
    dangerTint: Color(0x24F2555A),
    info: _accent,
    infoTint: Color(0x244BA3F2),
    overlayShadow: Color(0x73000000),
  );

  static const light = RovePalette(
    background: Color(0xFFF5F6F8),
    surface: Color(0xFFFFFFFF),
    inputFill: Color(0xFFF0F1F4),
    surface3: Color(0xFFE7E9ED),
    border: Color(0xFFE3E5EA),
    textPrimary: Color(0xFF0B0B0D),
    textSecondary: Color(0xFF5B5B66),
    textTertiary: Color(0xFF9A9AA5),
    primary: Color(0xFF1F7FD6),
    primaryPressed: Color(0xFF1A6FBC),
    primaryTint: Color(0x244BA3F2),
    onPrimary: Colors.white,
    success: Color(0xFF1E9E5A),
    successTint: Color(0x2434C77B),
    warning: Color(0xFFB26B00),
    warningTint: Color(0x24F5A524),
    danger: Color(0xFFD63B40),
    dangerTint: Color(0x24F2555A),
    info: Color(0xFF1F7FD6),
    infoTint: Color(0x244BA3F2),
    overlayShadow: Color(0x26000000),
  );

  @override
  RovePalette copyWith() => this;

  @override
  RovePalette lerp(covariant RovePalette? other, double t) =>
      t < 0.5 ? this : (other ?? this);
}

extension RovePaletteX on BuildContext {
  RovePalette get colors =>
      Theme.of(this).extension<RovePalette>() ?? RovePalette.dark;
}

abstract final class RoveSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const ml = 20.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;

  /// Horizontal screen padding (20 on mobile).
  static const page = EdgeInsetsDirectional.symmetric(horizontal: ml);
}

abstract final class RoveRadius {
  static const small = 12.0;
  static const tile = 16.0;
  static const card = 20.0;
  static const sheet = 24.0;
  static const pill = 999.0;

  static final smallAll = BorderRadius.circular(small);
  static final cardAll = BorderRadius.circular(card);
  static final pillAll = BorderRadius.circular(pill);
}

abstract final class RoveMotion {
  static const fast = Duration(milliseconds: 180);
  static const normal = Duration(milliseconds: 220);
}
