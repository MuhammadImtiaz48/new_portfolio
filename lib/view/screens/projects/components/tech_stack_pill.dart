import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';


class TechStackPill extends StatelessWidget {
  final String label;

  const TechStackPill({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
      decoration: BoxDecoration(
        color: WebColors.bgCard,
        borderRadius: BorderRadius.circular(24.adaptSize),
        border: Border.all(
          color: WebColors.borderGreen,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: WebColors.greenGlow.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Text(
        label,
        style: AppTextStyles.body(
          color: WebColors.greenPrimary,
          fontSize: 13,
          weight: FontWeight.w600,
        ),
      ),
    );
  }
}
