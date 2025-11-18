import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(Color primary) {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: primary.withOpacity(.9),
        background: const Color(0xFFF6EFE7),
      ),
      scaffoldBackgroundColor: const Color(0xFFF6EFE7),
      textTheme: _textTheme(base.textTheme, false),
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 2,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  static ThemeData dark(Color primary) {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary.withOpacity(.9),
        background: const Color(0xFF121212),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: _textTheme(base.textTheme, true),
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 2,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, bool isDark) {
    final color = isDark ? Colors.white : Colors.black87;
    return TextTheme(
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      bodyLarge: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      bodyMedium: GoogleFonts.cairo(
        fontSize: 14,
        color: color,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
