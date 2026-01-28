import 'package:flutter/material.dart';

/// Skoor App Color Palette
/// Premium football-themed colors with stadium atmosphere
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1B4D3E);
  static const Color primaryLight = Color(0xFF2A6B56);
  static const Color primaryDark = Color(0xFF0D2920);
  
  // Accent Colors
  static const Color gold = Color(0xFFFFD700);
  static const Color goldLight = Color(0xFFFFE44D);
  static const Color goldDark = Color(0xFFB8860B);
  
  // Background Colors
  static const Color background = Color(0xFF0A1612);
  static const Color backgroundLight = Color(0xFF0F1E18);
  static const Color surface = Color(0xFF142821);
  static const Color surfaceLight = Color(0xFF1E3D34);
  static const Color card = Color(0xFF1A332B);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0B5AF);
  static const Color textMuted = Color(0xFF6B8078);
  static const Color textOnGold = Color(0xFF1B4D3E);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Match Status Colors
  static const Color live = Color(0xFFE53935);
  static const Color upcoming = Color(0xFF2196F3);
  static const Color completed = Color(0xFF6B8078);
  
  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary, primaryDark],
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldLight, gold, goldDark],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundLight, background],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceLight, surface],
  );
  
  static const LinearGradient stadiumGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E3D34),
      Color(0xFF142821),
      Color(0xFF0A1612),
    ],
  );
  
  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.15),
      Colors.white.withOpacity(0.05),
    ],
  );
}
