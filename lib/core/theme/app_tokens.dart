import 'package:flutter/material.dart';

/// Theme-variant surface/text tokens, named to match the design handoff's
/// own token names (`--bg`, `--surface`, `--card`, `--elev`, `--line`,
/// `--tx`, `--mut`, `--chip`) so screen code reads the same vocabulary as
/// the spec. Look these up via `Theme.of(context).extension<AppTokens>()!`.
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.bg,
    required this.surface,
    required this.card,
    required this.elev,
    required this.line,
    required this.tx,
    required this.mut,
    required this.chip,
  });

  final Color bg;
  final Color surface;
  final Color card;
  final Color elev;
  final Color line;
  final Color tx;
  final Color mut;
  final Color chip;

  static const dark = AppTokens(
    bg: Color(0xFF070C1A),
    surface: Color(0xFF0B132B),
    card: Color(0xFF131D33),
    elev: Color(0xFF1A2742),
    line: Color(0x17FFFFFF),
    tx: Color(0xFFE8EDF6),
    mut: Color(0xFF8493AD),
    chip: Color(0xFF1B2742),
  );

  static const light = AppTokens(
    bg: Color(0xFFE9EEF6),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    elev: Color(0xFFEEF2F8),
    line: Color(0x1A0B132B),
    tx: Color(0xFF0B132B),
    mut: Color(0xFF5E6E8A),
    chip: Color(0xFFEEF2F8),
  );

  @override
  AppTokens copyWith({
    Color? bg,
    Color? surface,
    Color? card,
    Color? elev,
    Color? line,
    Color? tx,
    Color? mut,
    Color? chip,
  }) {
    return AppTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      elev: elev ?? this.elev,
      line: line ?? this.line,
      tx: tx ?? this.tx,
      mut: mut ?? this.mut,
      chip: chip ?? this.chip,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      elev: Color.lerp(elev, other.elev, t)!,
      line: Color.lerp(line, other.line, t)!,
      tx: Color.lerp(tx, other.tx, t)!,
      mut: Color.lerp(mut, other.mut, t)!,
      chip: Color.lerp(chip, other.chip, t)!,
    );
  }
}

extension AppTokensContext on BuildContext {
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
}
