import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/about/components/about_hero_section.dart';
import 'package:portfolio/view/screens/home/components/profile_image_frame.dart';
import 'package:animations/animations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: WebColors.bgPrimary,
          child: child,
        );
      },
      child: Scaffold(
        key: const ValueKey('AboutScreen'),
        backgroundColor: WebColors.bgPrimary,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 32.h,
            vertical: 64.v,
          ),
          child: Obx(() {
            final isMobile = Get.find<ResponsiveController>().isMobile;

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileImageFrame(),
                  SizedBox(height: 48.v),
                  const AboutHeroSection(),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 6,
                  child: AboutHeroSection(),
                ),
                SizedBox(width: 64.h),
                const Expanded(
                  flex: 4,
                  child: Center(
                    child: ProfileImageFrame(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
