import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/about_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/about/components/about_info_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutHeroSection extends StatelessWidget {
  const AboutHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutController = Get.find<AboutController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT ME',
          style: AppTextStyles.eyebrow(),
        ).animate().fade(duration: 400.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 14.v),

        // Dynamic Main Heading
        Obx(() {
          final heading = aboutController.aboutHeading;
          return RichText(
            text: TextSpan(
              style: AppTextStyles.heading(fontSize: 38, height: 1.2),
              children: [
                TextSpan(text: '$heading\n'),
                const TextSpan(
                  text: 'Engineering Scalable Flutter Solutions.',
                  style: TextStyle(
                    color: WebColors.greenBright,
                    shadows: [
                      Shadow(
                        color: WebColors.greenGlow,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).animate().fade(duration: 400.ms, delay: 100.ms).slideX(begin: -0.1, end: 0),

        SizedBox(height: 20.v),

        // Bios
        Obx(
          () => Text(
            aboutController.bioParagraph1,
            style: AppTextStyles.body(fontSize: 15, height: 1.65),
          ),
        ).animate().fade(duration: 400.ms, delay: 180.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 14.v),
        Obx(
          () => Text(
            aboutController.bioParagraph2,
            style: AppTextStyles.body(fontSize: 15, height: 1.65),
          ),
        ).animate().fade(duration: 400.ms, delay: 240.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: 28.v),

        // Info overview card (Location, Experience, Education, Speciality)
        const AboutInfoCard().animate().fade(duration: 400.ms, delay: 300.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 36.v),

        // Value Pillars ("What I Deliver")
        _buildSectionHeader('CORE FOCUS & STRENGTHS'),
        SizedBox(height: 16.v),
        _buildPillarsGrid().animate().fade(duration: 400.ms, delay: 360.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 36.v),

        // Career & Education Milestones Timeline
        _buildSectionHeader('CAREER & EDUCATION ROADMAP'),
        SizedBox(height: 16.v),
        _buildTimeline().animate().fade(duration: 400.ms, delay: 420.ms).slideY(begin: 0.1, end: 0),

        SizedBox(height: 36.v),

        // Technical Skills Matrix
        _buildSectionHeader('TECHNICAL COMPETENCIES'),
        SizedBox(height: 16.v),
        _buildSkillsMatrix(aboutController).animate().fade(duration: 400.ms, delay: 480.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4.adaptSize,
          height: 18.adaptSize,
          decoration: BoxDecoration(
            color: WebColors.greenBright,
            borderRadius: BorderRadius.circular(2),
            boxShadow: const [
              BoxShadow(
                color: WebColors.greenBright,
                blurRadius: 8,
              ),
            ],
          ),
        ),
        SizedBox(width: 10.h),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 13.fSize,
            fontWeight: FontWeight.w700,
            color: WebColors.textPrimary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPillarsGrid() {
    final pillars = [
      {
        'icon': Icons.bolt_rounded,
        'title': '60 FPS Performance',
        'desc': 'Optimized widget trees, smooth transitions, and leak-free memory architecture.',
      },
      {
        'icon': Icons.architecture_rounded,
        'title': 'Clean Architecture',
        'desc': 'Modular MVVM, decoupled layers, testable state management with GetX & Provider.',
      },
      {
        'icon': Icons.payments_outlined,
        'title': 'Payment Gateways',
        'desc': 'Production integrations with Stripe, Mollie, and secure backend Cloud Functions.',
      },
      {
        'icon': Icons.cloud_done_rounded,
        'title': 'Realtime & Media',
        'desc': 'Live ZegoCloud video/audio calling, FCM push notifications, and Cloudinary pipelines.',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 14.h,
            mainAxisSpacing: 14.v,
            mainAxisExtent: 110.adaptSize,
          ),
          itemCount: pillars.length,
          itemBuilder: (context, index) {
            final p = pillars[index];
            return Container(
              padding: EdgeInsets.all(14.adaptSize),
              decoration: BoxDecoration(
                gradient: WebColors.cardSurfaceGradient,
                borderRadius: BorderRadius.circular(14.adaptSize),
                border: Border.all(
                  color: WebColors.borderLight,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.adaptSize),
                    decoration: BoxDecoration(
                      color: WebColors.greenPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.adaptSize),
                      border: Border.all(color: WebColors.borderGreen),
                    ),
                    child: Icon(
                      p['icon'] as IconData,
                      color: WebColors.greenBright,
                      size: 20.adaptSize,
                    ),
                  ),
                  SizedBox(width: 12.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          p['title'] as String,
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 13.fSize,
                            fontWeight: FontWeight.w700,
                            color: WebColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Text(
                          p['desc'] as String,
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 11.fSize,
                            color: WebColors.textSecondary,
                            height: 1.35,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimeline() {
    final events = [
      {
        'role': 'Flutter App Developer',
        'organization': 'VertualSoft',
        'period': '2022 — Present · 2+ Years',
        'desc': 'Architecting and deploying production mobile applications across healthcare, social messaging, real estate, and fitness with Firebase and Stripe.',
        'highlight': true,
      },
      {
        'role': 'BS in Computer Science',
        'organization': 'KFUEIT (Khwaja Fareed UEIT)',
        'period': '2022 — 2026',
        'desc': 'Specializing in Mobile Systems, Algorithms, Data Structures, and Software Engineering Principles.',
        'highlight': false,
      },
    ];

    return Column(
      children: events.map((event) {
        final isHighlight = event['highlight'] as bool;
        return Padding(
          padding: EdgeInsets.only(bottom: 14.v),
          child: Container(
            padding: EdgeInsets.all(16.adaptSize),
            decoration: BoxDecoration(
              gradient: WebColors.cardSurfaceGradient,
              borderRadius: BorderRadius.circular(14.adaptSize),
              border: Border.all(
                color: isHighlight
                    ? WebColors.greenBright.withValues(alpha: 0.4)
                    : WebColors.borderLight,
                width: 1.2,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.v),
                  width: 10.adaptSize,
                  height: 10.adaptSize,
                  decoration: BoxDecoration(
                    color: isHighlight ? WebColors.greenBright : WebColors.cyanAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isHighlight ? WebColors.greenBright : WebColors.cyanAccent,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event['role'] as String,
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 14.fSize,
                              fontWeight: FontWeight.w700,
                              color: WebColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
                            decoration: BoxDecoration(
                              color: WebColors.bgCard,
                              borderRadius: BorderRadius.circular(6.adaptSize),
                              border: Border.all(color: WebColors.borderLight),
                            ),
                            child: Text(
                              event['period'] as String,
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 10.fSize,
                                fontWeight: FontWeight.w600,
                                color: isHighlight ? WebColors.greenBright : WebColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.v),
                      Text(
                        event['organization'] as String,
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600,
                          color: WebColors.greenPrimary,
                        ),
                      ),
                      SizedBox(height: 6.v),
                      Text(
                        event['desc'] as String,
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 12.fSize,
                          color: WebColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsMatrix(AboutController aboutController) {
    return Obx(() {
      final skillsList = aboutController.skills;
      if (skillsList.isEmpty) return const SizedBox.shrink();

      return Wrap(
        spacing: 10.h,
        runSpacing: 10.v,
        children: skillsList.map((skill) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 8.v),
            decoration: BoxDecoration(
              gradient: WebColors.cardSurfaceGradient,
              borderRadius: BorderRadius.circular(10.adaptSize),
              border: Border.all(
                color: WebColors.borderLight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.adaptSize,
                  height: 6.adaptSize,
                  decoration: const BoxDecoration(
                    color: WebColors.greenBright,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.h),
                Text(
                  skill,
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 13.fSize,
                    fontWeight: FontWeight.w600,
                    color: WebColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}
