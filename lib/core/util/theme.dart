import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      onPrimary: Color(0xFFFFFFFF), // Alb
      primaryContainer: Color(0xFFE1BEE7), // Lavandă deschis
      onPrimaryContainer: Color(0xFFB39DDB), // Lavandă mai închis
      secondary: Color(0xFF6A1B9A), // Violet închis
      onSecondary: Color(0xFFFFFFFF), // Alb
      secondaryContainer: Color(0xFFCE93D8), // Mov pal
      onSecondaryContainer: Color(0xFF1D192B),

      tertiary: Color(0xFF7D5260),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD8E4),
      onTertiaryContainer: Color(0xFF31111D),
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFF9DEDC),
      onErrorContainer: Color(0xFF410E0B),
      surface: Color(0xFFFFFBFE),
      onSurface: Color(0xFF1C1B1F),
      outline: Color(0xFF79747E),
      surfaceContainerHighest: Color(0xFFE7E0EC),
      onSurfaceVariant: Color(0xFF49454F),
    ),
  );
}
