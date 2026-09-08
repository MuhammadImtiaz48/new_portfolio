import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/controllers/contact_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PulsingAvailabilityBadge extends StatelessWidget {
  const PulsingAvailabilityBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
      decoration: BoxDecoration(
        color: WebColors.bgCard,
        borderRadius: BorderRadius.circular(24.adaptSize),
        border: Border.all(
          color: WebColors.borderGreen,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.adaptSize,
            height: 8.adaptSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: WebColors.greenPrimary,
              boxShadow: [
                BoxShadow(
                  color: WebColors.greenGlow,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(begin: const Offset(1, 1), end: const Offset(1.3, 1.3), duration: 1000.ms)
          .fade(begin: 0.5, end: 1.0, duration: 1000.ms),
          SizedBox(width: 8.h),
          Obx(
            () => Text(
              contactController.availabilityStatus.isNotEmpty
                  ? contactController.availabilityStatus
                  : 'Available for new projects',
              style: AppTextStyles.body(
                color: WebColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
