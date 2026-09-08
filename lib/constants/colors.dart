import 'package:flutter/material.dart';

class WebColors {
  WebColors._();

  // Backgrounds - Deep cosmic luxury tones
  static const Color bgPrimary = Color(0xFF080B10);
  static const Color bgSecondary = Color(0xFF0D121B);
  static const Color bgCard = Color(0xFF111827);
  static const Color bgCardHover = Color(0xFF162032);
  static const Color bgGlass = Color(0x0DFFFFFF);
  static const Color bgGlassHover = Color(0x18FFFFFF);

  // Emerald & Mint Accents
  static const Color greenDark = Color(0xFF064E3B);
  static const Color greenPrimary = Color(0xFF10B981);
  static const Color greenBright = Color(0xFF00F59B);
  static const Color greenGlow = Color(0x5500F59B);
  static const Color cyanAccent = Color(0xFF06B6D4);

  // Text
  static const Color textPrimary = Color(0xFFF9FAFB);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF64748B);

  // Borders & Dividers
  static const Color borderLight = Color(0x1AFFFFFF);
  static const Color borderGreen = Color(0x4D10B981);
  static const Color borderGreenGlow = Color(0x8000F59B);

  // Status / Utility
  static const Color success = Color(0xFF00F59B);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);
  static const Color violetAccent = Color(0xFF8B5CF6);
  static const Color amberAccent = Color(0xFFF59E0B);
  static const Color blueAccent = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF059669), Color(0xFF00F59B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [Color(0xFF00F59B), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Color(0x1F00F59B), Color(0x00000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient glassBorderGradient = LinearGradient(
    colors: [Color(0x4000F59B), Color(0x10FFFFFF), Color(0x3006B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardSurfaceGradient = LinearGradient(
    colors: [Color(0xFF131B2A), Color(0xFF0E1522)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient violetGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealCyanGradient = LinearGradient(
    colors: [Color(0xFF0D9488), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}