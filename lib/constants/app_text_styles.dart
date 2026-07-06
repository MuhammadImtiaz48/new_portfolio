import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading({
    required double fontSize,
    Color color = WebColors.textPrimary,
    FontWeight weight = FontWeight.w700,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: fontSize.fSize,
      fontWeight: weight,
      color: color,
      height: height ?? 1.2,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle eyebrow({
    Color color = WebColors.greenPrimary,
    double fontSize = 13,
  }) {
    return TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: fontSize.fSize,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 2.5.h,
    );
  }

  static TextStyle body({
    double fontSize = 15,
    Color color = WebColors.textSecondary,
    FontWeight weight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: fontSize.fSize,
      fontWeight: weight,
      color: color,
      height: height ?? 1.6,
    );
  }

  static TextStyle statLabel() {
    return TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: 11.fSize,
      fontWeight: FontWeight.w600,
      color: WebColors.textMuted,
      letterSpacing: 1.2.h,
    );
  }

  static TextStyle statValue() {
    return TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: 17.fSize,
      fontWeight: FontWeight.w700,
      color: WebColors.textPrimary,
    );
  }
}
