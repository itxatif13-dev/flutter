import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryColor = Color(0xFF6366F1); // Modern Indigo
  static const Color secondaryColor = Color(0xFFF43F5E); // Rose
  static const Color accentColor = Color(0xFF10B981); // Emerald
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color cardColor = Colors.white;
  
  static const String appName = "UniCGPA Tracker Pro";

  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const Map<String, double> gradePoints = {
    'A+': 4.00,
    'A': 3.70,
    'B+': 3.40,
    'B': 3.00,
    'C+': 2.50,
    'C': 2.00,
    'D': 1.00,
    'F': 0.00,
  };

  static String getGrade(double marks) {
    if (marks >= 90) return 'A+';
    if (marks >= 85) return 'A';
    if (marks >= 80) return 'B+';
    if (marks >= 70) return 'B';
    if (marks >= 60) return 'C+';
    if (marks >= 50) return 'C';
    if (marks >= 40) return 'D';
    return 'F';
  }

  static const List<int> creditHoursOptions = [1, 2, 3, 4, 5, 6];
}
