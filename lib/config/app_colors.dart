import 'package:flutter/material.dart';

class AppColors {
  // Primary palette — modern teal-indigo blend
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryLight = Color(0xFF4A9AF5);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryContainer = Color(0xFFD6E4FF);

  // Secondary palette — warm coral accent
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color secondaryLight = Color(0xFFFF9E9E);
  static const Color secondaryContainer = Color(0xFFFFE0E0);

  // Tertiary — amber for highlights
  static const Color tertiary = Color(0xFFFFB74D);
  static const Color tertiaryContainer = Color(0xFFFFF3E0);

  // Semantic colors
  static const Color success = Color(0xFF2ECC71);
  static const Color successLight = Color(0xFFE8F8F0);
  static const Color warning = Color(0xFFF39C12);
  static const Color warningLight = Color(0xFFFEF5E7);
  static const Color error = Color(0xFFE74C3C);
  static const Color errorLight = Color(0xFFFDECEA);
  static const Color info = Color(0xFF3498DB);

  // Neutral palette — light mode
  static const Color backgroundLight = Color(0xFFF8F9FD);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFE8ECF4);
  static const Color textPrimaryLight = Color(0xFF1A1D26);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);
  static const Color iconLight = Color(0xFF6B7280);

  // Neutral palette — dark mode
  static const Color backgroundDark = Color(0xFF0F1117);
  static const Color surfaceDark = Color(0xFF1A1D28);
  static const Color cardDark = Color(0xFF222636);
  static const Color dividerDark = Color(0xFF2D3142);
  static const Color textPrimaryDark = Color(0xFFF1F3F8);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textTertiaryDark = Color(0xFF6B7280);
  static const Color iconDark = Color(0xFF9CA3AF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A73E8), Color(0xFF6C63FF)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
  );

  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1D28), Color(0xFF2D3142)],
  );

  // Seat colors
  static const Color seatAvailable = Color(0xFF2ECC71);
  static const Color seatBooked = Color(0xFFE0E0E0);
  static const Color seatSelected = Color(0xFF1A73E8);
  static const Color seatAvailableDark = Color(0xFF27AE60);
  static const Color seatBookedDark = Color(0xFF3D3D3D);
  static const Color seatSelectedDark = Color(0xFF4A9AF5);

  // Rating star
  static const Color ratingStar = Color(0xFFFFB74D);
}
