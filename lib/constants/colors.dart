import 'package:flutter/material.dart';

class WebColors {
  WebColors._();

  // Backgrounds
  static const Color bgPrimary = Color(0xFF0A0A0A);
  static const Color bgSecondary = Color(0xFF0D0F0D);
  static const Color bgCard = Color(0xFF111413);
  static const Color bgCardHover = Color(0xFF161B19);

  // Green Accents
  static const Color greenDark = Color(0xFF0F4D3A);
  static const Color greenPrimary = Color(0xFF1DB87C);
  static const Color greenBright = Color(0xFF2EE6A6);
  static const Color greenGlow = Color(0x552EE6A6);

  // Text
  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFF9A9A9A);
  static const Color textMuted = Color(0xFF6B6B6B);

  // Borders & Dividers
  static const Color borderLight = Color(0x14FFFFFF);
  static const Color borderGreen = Color(0x401DB87C);

  // Status / Utility
  static const Color success = Color(0xFF2EE6A6);
  static const Color warning = Color(0xFFE6C02E);
  static const Color error = Color(0xFFE64C4C);

  // Gradients
  static const LinearGradient greenGradient = LinearGradient(
    colors: [greenDark, greenPrimary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Color(0x1A2EE6A6), Color(0x00000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}