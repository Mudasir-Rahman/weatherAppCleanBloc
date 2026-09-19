import 'package:flutter/material.dart';

class AppTheme {
  // ============ LIGHT THEME ============
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black87),
      headlineMedium: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B4F8A),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  // ============ DARK THEME ============
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    cardTheme: CardThemeData(
      color: Colors.white.withOpacity(0.05),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B4F8A),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  // ============ GRADIENTS ============
  static const LinearGradient lightCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A90D9), Color(0xFF6BB5FF)],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B4F8A), Color(0xFF2E6DB4)],
  );

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), Color(0xFF1E3A5F)],
  );

  // Get gradient based on brightness
  static LinearGradient getCardGradient(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkCardGradient
        : lightCardGradient;
  }

  static LinearGradient getBackgroundGradient(Brightness brightness) {
    return brightness == Brightness.dark
        ? darkBackgroundGradient
        : lightBackgroundGradient;
  }

  // Weather-specific dynamic gradients
  static LinearGradient getWeatherBackgroundGradient(String iconCode, Brightness brightness) {
    bool isDark = brightness == Brightness.dark;
    if (iconCode.startsWith('01')) {
      // Clear / Sunny
      return isDark
          ? const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1A2A6C), Color(0xFFB21F1F)])
          : const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)]);
    } else if (iconCode.startsWith('02') || iconCode.startsWith('03') || iconCode.startsWith('04')) {
      // Cloudy
      return isDark
          ? const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF232526), Color(0xFF414345)])
          : const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF617C58), Color(0xFF93B874)]);
    } else if (iconCode.startsWith('09') || iconCode.startsWith('10')) {
      // Rainy
      return isDark
          ? const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0F2027), Color(0xFF203A43)])
          : const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF3A7BD5), Color(0xFF3A6073)]);
    } else if (iconCode.startsWith('11')) {
      // Thunderstorm
      return const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF141E30), Color(0xFF243B55)]);
    } else if (iconCode.startsWith('13')) {
      // Snowy
      return const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF83A4D4), Color(0xFFB6FBFF)]);
    }
    return getBackgroundGradient(brightness);
  }

  // Get colors based on brightness
  static Color getTextColor(Brightness brightness) {
    return brightness == Brightness.dark ? Colors.white : Colors.black87;
  }

  static Color getSubtitleColor(Brightness brightness) {
    return brightness == Brightness.dark ? Colors.white70 : Colors.black54;
  }

  static Color getCardColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? Colors.white.withOpacity(0.05)
        : Colors.white;
  }

  static Color getSearchBarColor(Brightness brightness) {
    return brightness == Brightness.dark
        ? Colors.white.withOpacity(0.1)
        : Colors.white;
  }
}