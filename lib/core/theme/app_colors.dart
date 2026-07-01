import 'package:flutter/material.dart';

/// Brand accent colors — per the design handoff these are **identical in
/// light and dark mode**. Theme-variant tokens (background/surface/card/
/// border/text) live in [AppTheme]'s light/dark [ColorScheme]s instead,
/// since those genuinely differ by brightness.
abstract final class AppColors {
  static const Color primary = Color(0xFF2E7DFF);
  static const Color accent = Color(0xFFFFC107);
  static const Color accentOnAccent = Color(0xFF0B132B);
  static const Color success = Color(0xFF2ECC71);
  static const Color danger = Color(0xFFFF4D67);
  static const Color purple = Color(0xFF9B59B6);

  static const Color textOnPrimary = Color(0xFFFFFFFF);
}
