import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradients
  static const Color primaryPurple = Color(0xFF6B46C1);
  static const Color primaryBlue = Color(0xFF2B6CB0);
  
  // Secondary / Accent
  static const Color bioluminescentGreen = Color(0xFF68D391);
  static const Color auroraBlue = Color(0xFF7F9CF5);
  static const Color auroraPurple = Color(0xFF9F7AEA);
  static const Color auroraPink = Color(0xFFF687B3);

  // Backgrounds
  static const Color cosmicDark = Color(0xFF0F172A);
  static const Color glassBase = Color(0x1AFFFFFF);
  
  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<Color> auroraColors = [
    auroraBlue,
    auroraPurple,
    auroraPink,
  ];
}
