import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFF0F0E17),
    colorScheme: const ColorScheme.dark(
      primary: Colors.deepPurple,
      secondary: Colors.pinkAccent,
      surface: Color(0xFF1B1B2F),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFFF5F5F7),
    colorScheme: const ColorScheme.light(
      primary: Colors.deepPurple,
      secondary: Colors.pinkAccent,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    useMaterial3: true,
  );
}
