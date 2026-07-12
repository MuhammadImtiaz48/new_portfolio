import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';

class ProfileImageFrame extends StatefulWidget {
  const ProfileImageFrame({
    super.key,
    this.badges = const [],
  });

  final List<Widget> badges;

  @override
  State<ProfileImageFrame> createState() => _ProfileImageFrameState();
}

class _ProfileImageFrameState extends State<ProfileImageFrame> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();
    final width = responsive.isMobile ? 240.adaptSize : 280.adaptSize;
    final height = responsive.isMobile ? 310.adaptSize : 370.adaptSize;

    final innerWidth = width - 16.adaptSize;
    final innerHeight = height - 16.adaptSize;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background Glow effect
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.adaptSize),
                  gradient: RadialGradient(
                    colors: [
                      _isHovered 
                          ? WebColors.greenGlow.withValues(alpha: 0.5) 
                          : WebColors.greenGlow.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                    radius: _isHovered ? 0.95 : 0.8,
                  ),
                ),
              ),
              // Inner card with border and shadow
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: innerWidth,
                height: innerHeight,
                padding: EdgeInsets.all(6.adaptSize),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.adaptSize),
                  border: Border.all(
                    color: _isHovered ? WebColors.greenBright : WebColors.greenPrimary,
                    width: 2.adaptSize,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered 
                          ? WebColors.greenBright.withValues(alpha: 0.35) 
                          : WebColors.greenGlow.withValues(alpha: 0.2),
                      blurRadius: _isHovered ? 40.adaptSize : 30.adaptSize,
                      spreadRadius: _isHovered ? 4.adaptSize : 2.adaptSize,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.adaptSize),
                  child: Image.asset(
                    'assets/images/profile_image.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: WebColors.bgCard,
                      child: Icon(
                        Icons.person_rounded,
                        color: WebColors.textMuted,
                        size: 64.adaptSize,
                      ),
                    ),
                  ),
                ),
              ),
              ...widget.badges,
            ],
          ),
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: -8, end: 8, duration: 2400.ms, curve: Curves.easeInOut);
  }
}
