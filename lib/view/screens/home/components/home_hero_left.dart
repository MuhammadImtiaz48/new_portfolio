import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/home/components/home_stats_row.dart';
import 'package:portfolio/view/widgets/custom_text.dart';
import 'package:portfolio/view/widgets/outlined_glow_button.dart';
import 'package:portfolio/view/widgets/primary_button.dart';
import 'package:portfolio/core/utils/download_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeHeroLeft extends StatelessWidget {
  const HomeHeroLeft({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();
    final homeController = Get.find<HomeController>();

    return Obx(() {
      final profile = homeController.profile.value;
      final crossAlign =
          responsive.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
      final textAlign = responsive.isMobile ? TextAlign.center : TextAlign.start;
      final headingSize = responsive.isMobile ? 32.0 : 48.0;

      return Column(
        crossAxisAlignment: crossAlign,
        children: [
          // Live Availability Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.adaptSize, vertical: 6.adaptSize),
            decoration: BoxDecoration(
              color: WebColors.greenDark.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20.adaptSize),
              border: Border.all(
                color: WebColors.greenBright.withValues(alpha: 0.45),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: WebColors.greenGlow.withValues(alpha: 0.15),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.adaptSize,
                  height: 8.adaptSize,
                  decoration: const BoxDecoration(
                    color: WebColors.greenBright,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: WebColors.greenBright,
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.3, 1.3), duration: 1100.ms),
                SizedBox(width: 8.adaptSize),
                CustomText(
                  text: profile.heroEyebrow.isNotEmpty
                      ? profile.heroEyebrow.toUpperCase()
                      : 'AVAILABLE FOR FULL-TIME & FREELANCE',
                  fontSize: 11.fSize,
                  fontWeight: FontWeight.w700,
                  color: WebColors.greenBright,
                  letterSpacing: 1.5,
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

          SizedBox(height: 18.v),

          // Main Heading
          RichText(
            textAlign: textAlign,
            text: TextSpan(
              style: AppTextStyles.heading(fontSize: headingSize, height: 1.15),
              children: [
                const TextSpan(text: 'Hi, I\'m '),
                TextSpan(
                  text: profile.heroTitle.isNotEmpty
                      ? profile.heroTitle
                      : 'Muhammad Imtiaz',
                  style: const TextStyle(
                    color: WebColors.greenBright,
                    shadows: [
                      Shadow(
                        color: WebColors.greenGlow,
                        blurRadius: 24,
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: profile.heroSubtitle.isNotEmpty
                      ? '.\n${profile.heroSubtitle}'
                      : '.\nCrafting High-Performance Mobile Apps.',
                  style: const TextStyle(
                    color: WebColors.textPrimary,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 100.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),

          SizedBox(height: 18.v),

          // Bio description
          CustomText(
            text: profile.heroBio.isNotEmpty
                ? profile.heroBio
                : 'Flutter Developer with 2+ years of hands-on experience building and shipping cross-platform mobile apps end to end — from real-time chat and video calling to secure payment integrations and clean architecture.',
            fontSize: 15.fSize,
            color: WebColors.textSecondary,
            height: 1.6,
            textAlign: textAlign,
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),

          SizedBox(height: 22.v),

          // Tech pills row
          Wrap(
            alignment: responsive.isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 8.h,
            runSpacing: 8.v,
            children: profile.heroTechTags.map((tech) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.v),
                decoration: BoxDecoration(
                  color: WebColors.bgCard,
                  borderRadius: BorderRadius.circular(10.adaptSize),
                  border: Border.all(
                    color: WebColors.borderLight,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5.adaptSize,
                      height: 5.adaptSize,
                      decoration: const BoxDecoration(
                        color: WebColors.greenBright,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.h),
                    Text(
                      tech,
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 12.fSize,
                        fontWeight: FontWeight.w600,
                        color: WebColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 250.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),

          SizedBox(height: 28.v),

          // CTA Action Buttons & Social Links Row
          Wrap(
            alignment: responsive.isMobile ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 14.h,
            runSpacing: 14.v,
            children: [
              PrimaryButton(
                label: 'Explore Work',
                onTap: () => Get.find<SidebarController>().setActive(2),
              ),
              OutlinedGlowButton(
                label: 'Get in Touch',
                onTap: () => Get.find<SidebarController>().setActive(3),
              ),
              OutlinedGlowButton(
                label: 'Download CV',
                onTap: () {
                  final resumePath = profile.resumeUrl.trim().isNotEmpty
                      ? profile.resumeUrl.trim()
                      : 'resume/M_Imtiaz_Resume.pdf';
                  downloadFile(
                    resumePath,
                    'M_Imtiaz_Resume.pdf',
                  );
                },
              ),
              // Social icons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _socialIcon(
                    child: const FaIcon(
                      FontAwesomeIcons.github,
                      size: 16,
                      color: WebColors.greenBright,
                    ),
                    tooltip: 'GitHub',
                    onTap: () => _openUrl(
                      profile.githubUrl.isNotEmpty
                          ? profile.githubUrl
                          : 'https://github.com/MuhammadImtiaz48',
                    ),
                  ),
                  SizedBox(width: 8.h),
                  _socialIcon(
                    child: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 16,
                      color: WebColors.greenBright,
                    ),
                    tooltip: 'WhatsApp',
                    onTap: () {
                      final cleanWa = profile.whatsapp.replaceAll(RegExp(r'[^\d]'), '');
                      _openUrl('https://wa.me/$cleanWa?text=Hi%20Imtiaz,%20I%20saw%20your%20portfolio...');
                    },
                  ),
                  SizedBox(width: 8.h),
                  _socialIcon(
                    child: const Icon(
                      Icons.email_outlined,
                      size: 16,
                      color: WebColors.greenBright,
                    ),
                    tooltip: 'Email',
                    onTap: () => _openUrl(
                      'mailto:${profile.email.isNotEmpty ? profile.email : "developerhouseapl@gmail.com"}',
                    ),
                  ),
                ],
              ),
            ],
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),

          SizedBox(height: 36.v),

          // Stats counter section
          const HomeStatsRow()
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      );
    });
  }

  Widget _socialIcon({
    required Widget child,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: WebColors.bgCard,
              shape: BoxShape.circle,
              border: Border.all(
                color: WebColors.borderLight,
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
