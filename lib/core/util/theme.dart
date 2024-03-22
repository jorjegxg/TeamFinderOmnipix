import 'package:flutter/material.dart';

ThemeData createLightTheme() {
  return ThemeData(
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF6750A4),
      contentTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFD9D9D9),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xFF000000),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFF6750A4),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelSmall: TextStyle(
        color: Color.fromARGB(255, 115, 115, 115),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 0,
      ),
      titleMedium: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      titleSmall: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    ),
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6750A4),
      surface: Color(0xFFFEF7FF),
      surfaceContainer: Color(0xFFF3EDF7),
      outlineVariant: Color(0xFFCAC4D0),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      onPrimary: Color(0xFFFFFFFF),
      onSurface: Color(0xFFE6E0E9),
      surfaceContainerHigh: Color(0xFFECE6F0),
      secondaryContainer: Color(0xFFE8DEF8),
      secondary: Color(0xFF625B71),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
      shadow: Color(0x3F000000),
      primaryContainer: Color(0xFFF7F2FA),
      onPrimaryContainer: Color(0xFFEBE4EF),
    ),
  );
}

ThemeData createDarkTheme() {
  return ThemeData(
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF6750A4),
      contentTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1A1A1A),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFF6750A4),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelSmall: TextStyle(
        color: Color.fromARGB(255, 115, 115, 115),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 0,
      ),
      titleMedium: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      titleSmall: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    ),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF6750A4),
      surface: Color(0xFF1A1A1A),
      surfaceContainer: Color(0xFF2A2A2A),
      outlineVariant: Color(0xFFCAC4D0),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      onPrimary: Color(0xFFFFFFFF),
      onSurface: Color(0xFFE6E0E9),
      surfaceContainerHigh: Color(0xFFECE6F0),
      secondaryContainer: Color(0xFFE8DEF8),
      secondary: Color(0xFF625B71),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
      shadow: Color(0x3F000000),
      primaryContainer: Color(0xFFF7F2FA),
      onPrimaryContainer: Color(0xFFEBE4EF),
    ),
  );
}
