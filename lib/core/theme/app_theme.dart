import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5B5BD6);
  static const Color secondaryColor = Color(0xFF12B981);
  static const Color surfaceColor = Color(0xFFF7F7FF);
  static const Color backgroundColor = Color(0xFFF7F7FF);
  static const Color errorColor = Color(0xFFB42318);
  static const Color successColor = Color(0xFF12B981);
  static const Color warningColor = Color(0xFFF79009);

  static const Color _onSurface = Color(0xFF101828);
  static const Color _outline = Color(0xFFD0D5DD);
  static const Color _surfaceContainer = Color(0xFFFFFFFF);

  static const Color _darkSurface = Color(0xFF0B1220);
  static const Color _darkSurfaceContainer = Color(0xFF101B2E);
  static const Color _darkOnSurface = Color(0xFFE6EAF2);
  static const Color _darkOutline = Color(0xFF344054);

  static const double _radius = 14;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      surfaceContainerHighest: _surfaceContainer,
      error: errorColor,
      onSurface: _onSurface,
      outline: _outline,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _onSurface,
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: _surfaceContainer,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: _onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _onSurface,
        side: const BorderSide(color: _outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: _outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: primaryColor, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: errorColor, width: 1.4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: errorColor, width: 1.8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: _onSurface,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _outline,
      thickness: 1,
      space: 1,
    ),
    textTheme: Typography.material2021().black.copyWith(
          headlineLarge: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
          headlineSmall: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
          titleLarge: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
          titleMedium: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: const TextStyle(
            height: 1.25,
          ),
          bodyMedium: const TextStyle(
            height: 1.25,
          ),
        ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFF8B92FF),
      secondary: const Color(0xFF34D3A1),
      surface: _darkSurface,
      background: _darkSurface,
      surfaceContainerHighest: _darkSurfaceContainer,
      error: const Color(0xFFFDA29B),
      onSurface: _darkOnSurface,
      outline: _darkOutline,
    ),
    scaffoldBackgroundColor: _darkSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _darkOnSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _darkOnSurface,
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: _darkSurfaceContainer,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: _darkOnSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8B92FF),
        foregroundColor: const Color(0xFF0B1220),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkOnSurface,
        side: const BorderSide(color: _darkOutline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF8B92FF),
      foregroundColor: const Color(0xFF0B1220),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: _darkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: Color(0xFF8B92FF), width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: Color(0xFFFDA29B), width: 1.4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: const BorderSide(color: Color(0xFFFDA29B), width: 1.8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: _darkSurfaceContainer,
      contentTextStyle: const TextStyle(color: _darkOnSurface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _darkOutline,
      thickness: 1,
      space: 1,
    ),
    textTheme: Typography.material2021().white.copyWith(
          headlineLarge: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
          headlineSmall: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
          titleLarge: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
          titleMedium: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: const TextStyle(
            height: 1.25,
          ),
          bodyMedium: const TextStyle(
            height: 1.25,
          ),
        ),
  );
}
