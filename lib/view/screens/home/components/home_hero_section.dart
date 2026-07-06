import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/home/components/home_hero_left.dart';
import 'package:portfolio/view/screens/home/components/profile_image_frame.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();

    return Obx(() {
      final profileImage = const ProfileImageFrame()
          .animate()
          .fadeIn(delay: 150.ms, duration: 500.ms)
          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));

      if (responsive.isMobile) {
        return Column(
          children: [
            profileImage,
            SizedBox(height: 32.v),
            const HomeHeroLeft(),
          ],
        );
      }

      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(flex: 6, child: HomeHeroLeft()),
            SizedBox(width: 48.h),
            Expanded(flex: 4, child: profileImage),
          ],
        ),
      );
    });
  }
}
