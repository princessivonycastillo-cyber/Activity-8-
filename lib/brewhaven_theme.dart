import 'package:flutter/material.dart';

/// BrewHaven brand colors (matched to the Activity 1 login/registration design).
class BrewColors {
  static const background = Color(0xFF1E1410); // page background
  static const surface = Color(0xFF2B1D16); // cards, panels
  static const field = Color(0xFF38271E); // input fill
  static const border = Color(0xFF5A4232); // input / card outline
  static const copper = Color(0xFFD9853F); // buttons, accents
  static const copperDark = Color(0xFFB86A2B); // pressed / hover
  static const cream = Color(0xFFF3E9DC); // main text
  static const muted = Color(0xFFB9A28E); // hints, labels
  static const error = Color(0xFFE57A6B);
}

final ThemeData brewHavenTheme = _buildTheme();

ThemeData _buildTheme() {
  const scheme = ColorScheme.dark(
    primary: BrewColors.copper,
    onPrimary: Color(0xFF1E1410),
    secondary: BrewColors.copperDark,
    onSecondary: BrewColors.cream,
    surface: BrewColors.surface,
    onSurface: BrewColors.cream,
    error: BrewColors.error,
    onError: Color(0xFF1E1410),
  );

  OutlineInputBorder outline(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: width),
      );

  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: BrewColors.background,
    canvasColor: BrewColors.surface, // dropdown menu background
  );

  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: BrewColors.cream,
      displayColor: BrewColors.cream,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: BrewColors.surface,
      foregroundColor: BrewColors.cream,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),

    cardTheme: CardThemeData(
      color: BrewColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: BrewColors.border),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: BrewColors.field,
      labelStyle: const TextStyle(color: BrewColors.muted),
      floatingLabelStyle: const TextStyle(color: BrewColors.copper),
      hintStyle: const TextStyle(color: BrewColors.muted),
      errorStyle: const TextStyle(color: BrewColors.error),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: outline(BrewColors.border),
      enabledBorder: outline(BrewColors.border),
      focusedBorder: outline(BrewColors.copper, 2),
      errorBorder: outline(BrewColors.error),
      focusedErrorBorder: outline(BrewColors.error, 2),
      disabledBorder: outline(BrewColors.border.withValues(alpha: 0.5)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: BrewColors.copper,
        foregroundColor: const Color(0xFF1E1410),
        disabledBackgroundColor: BrewColors.copper.withValues(alpha: 0.35),
        disabledForegroundColor: BrewColors.cream.withValues(alpha: 0.5),
        minimumSize: const Size.fromHeight(48),
        elevation: 0,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: BrewColors.copper,
        foregroundColor: const Color(0xFF1E1410),
        disabledBackgroundColor: BrewColors.copper.withValues(alpha: 0.35),
        disabledForegroundColor: BrewColors.cream.withValues(alpha: 0.5),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: BrewColors.copper,
        side: const BorderSide(color: BrewColors.copper),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: BrewColors.copper),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? BrewColors.copper
            : BrewColors.muted,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? BrewColors.copper.withValues(alpha: 0.4)
            : BrewColors.field,
      ),
    ),

    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: BrewColors.copper),

    dividerTheme: const DividerThemeData(color: BrewColors.border),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: BrewColors.surface,
      contentTextStyle: const TextStyle(color: BrewColors.cream),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
