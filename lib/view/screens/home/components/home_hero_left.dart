import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/home/components/home_stats_row.dart';
import 'package:portfolio/view/widgets/custom_text.dart';
import 'package:portfolio/view/widgets/outlined_glow_button.dart';
import 'package:portfolio/view/widgets/primary_button.dart';
import 'package:portfolio/core/utils/download_helper.dart';

class HomeHeroLeft extends StatelessWidget {
  const HomeHeroLeft({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();

    return Obx(() {
      final crossAlign =
      responsive.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
      final textAlign = responsive.isMobile ? TextAlign.center : TextAlign.start;
      final headingSize = responsive.isMobile ? 36.0 : 54.0;

      return Column(
        crossAxisAlignment: crossAlign,
        children: [
          CustomText(
            text: 'FLUTTER DEVELOPER',
            fontSize: 14.fSize,
            fontWeight: FontWeight.w600,
            color: WebColors.greenPrimary,
            letterSpacing: 2.5.h,
            textAlign: textAlign,
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3, end: 0),
          SizedBox(height: 18.v),
          RichText(
            textAlign: textAlign,
            text: TextSpan(
              style: AppTextStyles.heading(fontSize: headingSize),
              children: [
                const TextSpan(text: 'I build '),
                TextSpan(
                  text: 'high-performance',
                  style: TextStyle(color: WebColors.greenBright),
                ),
                const TextSpan(text: ' mobile architectures.'),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 100.ms, duration: 400.ms)
              .slideY(begin: 0.3, end: 0),
          SizedBox(height: 24.v),
          CustomText(
            text:
            'I design and build scalable, high-performing Flutter applications with clean architecture, smooth animations, and a strong focus on user experience across web and mobile.',
            fontSize: 16.fSize,
            color: WebColors.textSecondary,
            height: 1.6,
            textAlign: textAlign,
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.3, end: 0),
          SizedBox(height: 32.v),
          Wrap(
            alignment: responsive.isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 16.h,
            runSpacing: 16.v,
            children: [
              PrimaryButton(
                label: 'View My Work',
                onTap: () => Get.find<SidebarController>().setActive(2),
              ),
              OutlinedGlowButton(
                label: 'Contact Me',
                onTap: () => Get.find<SidebarController>().setActive(3),
              ),
              OutlinedGlowButton(
                label: 'Resume',
                onTap: () => downloadFile(
                    'assets/assets/resume/shahrooz_resume.pdf', 'shahrooz_resume.pdf'),
              ),
            ],
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.3, end: 0),
          SizedBox(height: 44.v),
          const HomeStatsRow()
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.3, end: 0),
        ],
      );
    });
  }
}
