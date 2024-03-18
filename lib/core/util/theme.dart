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

    //combina-le

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6750A4), // Mov
      surface: Color(0xFFF3E5F5), // Lavandă
      surfaceContainer: Color(0xFFD1C4E9), // Mov deschis
      outlineVariant: Color(0xFFAB47BC), // Lavandă intens
      onSurfaceVariant: Color(0xFF4A148C), // Violet profund
      outline: Color(0xFF9C27B0), // Violet
      onPrimary: Color(0xFFFFFFFF), // Alb
      onSurface: Color(0xFF6A1B9A), // Violet întunecat
      surfaceContainerHigh: Color(0xFFBA68C8), // Violet deschis
      secondaryContainer: Color(0xFFCE93D8), // Mov pal
      secondary: Color(0xFF6A1B9A), // Violet închis
      onSecondary: Color(0xFFFFFFFF), // Alb
      error: Color(0xFFC2185B), // Roz
      onError: Color(0xFFFFFFFF), // Alb
      shadow: Color(0x3F000000), // Negru transparent
      primaryContainer: Color(0xFFE1BEE7), // Lavandă deschis
      onPrimaryContainer: Color(0xFFB39DDB), // Lavandă mai închis
    ),
  );
}
