import 'package:flutter/material.dart';

ThemeData createLightTheme() {
  return ThemeData(
    textTheme: const TextTheme(
      labelSmall: TextStyle(
        color: Color.fromARGB(255, 115, 115, 115),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 0,
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
