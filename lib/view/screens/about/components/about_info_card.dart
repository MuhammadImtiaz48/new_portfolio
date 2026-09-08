import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/about_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/about/components/about_info_row.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutInfoCard extends StatefulWidget {
  const AboutInfoCard({super.key});

  @override
  State<AboutInfoCard> createState() => _AboutInfoCardState();
}

class _AboutInfoCardState extends State<AboutInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final aboutController = Get.find<AboutController>();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: 28.h,
          vertical: 26.v,
        ),
        decoration: BoxDecoration(
          gradient: WebColors.cardSurfaceGradient,
          borderRadius: BorderRadius.circular(20.adaptSize),
          border: Border.all(
            color: _isHovered ? WebColors.greenBright.withValues(alpha: 0.7) : WebColors.borderLight,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? WebColors.greenGlow.withValues(alpha: 0.22) : Colors.black.withValues(alpha: 0.25),
              blurRadius: _isHovered ? 26 : 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 450;

            return Obx(() {
              final location = aboutController.location;
              final experience = aboutController.experience;
              final education = aboutController.education;
              final speciality = aboutController.speciality;

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AboutInfoRow(
                      label: 'Location',
                      value: location,
                    ).animate().fade(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1, end: 0),
                    SizedBox(height: 16.v),
                    AboutInfoRow(
                      label: 'Experience',
                      value: experience,
                    ).animate().fade(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1, end: 0),
                    SizedBox(height: 16.v),
                    AboutInfoRow(
                      label: 'Education',
                      value: education,
                    ).animate().fade(duration: 400.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),
                    SizedBox(height: 16.v),
                    AboutInfoRow(
                      label: 'Speciality',
                      value: speciality,
                    ).animate().fade(duration: 400.ms, delay: 200.ms).slideY(begin: 0.1, end: 0),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AboutInfoRow(
                          label: 'Location',
                          value: location,
                        ),
                      ),
                      SizedBox(width: 24.h),
                      Expanded(
                        child: AboutInfoRow(
                          label: 'Experience',
                          value: experience,
                        ),
                      ),
                    ],
                  ).animate().fade(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1, end: 0),
                  SizedBox(height: 20.v),
                  Row(
                    children: [
                      Expanded(
                        child: AboutInfoRow(
                          label: 'Education',
                          value: education,
                        ),
                      ),
                      SizedBox(width: 24.h),
                      Expanded(
                        child: AboutInfoRow(
                          label: 'Speciality',
                          value: speciality,
                        ),
                      ),
                    ],
                  ).animate().fade(duration: 400.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
