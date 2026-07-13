import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 24.v,
        ),
        decoration: BoxDecoration(
          color: _isHovered ? WebColors.bgCardHover : WebColors.bgCard,
          borderRadius: BorderRadius.circular(20.adaptSize),
          border: Border.all(
            color: _isHovered ? WebColors.borderGreen : WebColors.borderLight,
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: WebColors.greenGlow.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: -2,
              ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 450;

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AboutInfoRow(
                    label: 'Location',
                    value: 'Lahore, PK',
                  ).animate().fade(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1, end: 0),
                  SizedBox(height: 16.v),
                  const AboutInfoRow(
                    label: 'Experience',
                    value: '2+ Years',
                  ).animate().fade(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1, end: 0),
                  SizedBox(height: 16.v),
                  const AboutInfoRow(
                    label: 'Speciality',
                    value: 'Flutter · Firebase',
                  ).animate().fade(duration: 400.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),
                  SizedBox(height: 16.v),
                  const AboutInfoRow(
                    label: 'Status',
                    value: 'Available',
                    showDot: true,
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
                    const Expanded(
                      child: AboutInfoRow(
                        label: 'Location',
                        value: 'Lahore, PK',
                      ),
                    ),
                    SizedBox(width: 24.h),
                    const Expanded(
                      child: AboutInfoRow(
                        label: 'Experience',
                        value: '2+ Years',
                      ),
                    ),
                  ],
                ).animate().fade(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1, end: 0),
                SizedBox(height: 20.v),
                Row(
                  children: [
                    const Expanded(
                      child: AboutInfoRow(
                        label: 'Speciality',
                        value: 'Flutter · Firebase',
                      ),
                    ),
                    SizedBox(width: 24.h),
                    const Expanded(
                      child: AboutInfoRow(
                        label: 'Status',
                        value: 'Available',
                        showDot: true,
                      ),
                    ),
                  ],
                ).animate().fade(duration: 400.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),
              ],
            );
          },
        ),
      ),
    );
  }
}
