import 'package:flutter/material.dart';

/// Rove design tokens (shared/DESIGN.md). Same values as the dashboard.
abstract final class RoveColors {
  static const primary = Color(0xFF1F4D3A);
  static const primaryPressed = Color(0xFF173B2C);
  static const primaryTint = Color(0xFFE8F0EC);

  static const background = Color(0xFFFAFAF7);
  static const surface = Color(0xFFFFFFFF);
  static const inputFill = Color(0xFFF4F3EF);
  static const border = Color(0xFFE7E5E0);

  static const textPrimary = Color(0xFF1C1C1E);
  static const textSecondary = Color(0xFF6B6B70);
  static const textTertiary = Color(0xFFA1A1A6);

  static const success = Color(0xFF2E7D4F);
  static const successTint = Color(0xFFE9F5EE);
  static const warning = Color(0xFFB26B00);
  static const warningTint = Color(0xFFFFF4E0);
  static const danger = Color(0xFFC0362C);
  static const dangerTint = Color(0xFFFCECEA);
  static const info = Color(0xFF2F5D8A);
  static const infoTint = Color(0xFFEAF1F8);
}

abstract final class RoveSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;

  /// Horizontal page padding.
  static const page = EdgeInsetsDirectional.symmetric(horizontal: md);
}

abstract final class RoveRadius {
  static const small = 8.0;
  static const card = 12.0;
  static const sheet = 16.0;
  static const pill = 999.0;

  static final smallAll = BorderRadius.circular(small);
  static final cardAll = BorderRadius.circular(card);
}

abstract final class RoveMotion {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 200);
}
