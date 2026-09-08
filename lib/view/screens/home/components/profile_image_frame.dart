import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/home_controller.dart';
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
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController(), permanent: true);

    final width = responsive.isMobile ? 250.adaptSize : 300.adaptSize;
    final height = responsive.isMobile ? 320.adaptSize : 385.adaptSize;

    final innerWidth = width - 20.adaptSize;
    final innerHeight = height - 20.adaptSize;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Ambient Background Glow effect
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                width: width + 20.adaptSize,
                height: height + 20.adaptSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.adaptSize),
                  gradient: RadialGradient(
                    colors: [
                      _isHovered
                          ? WebColors.greenBright.withValues(alpha: 0.45)
                          : WebColors.greenPrimary.withValues(alpha: 0.25),
                      WebColors.cyanAccent.withValues(alpha: _isHovered ? 0.2 : 0.08),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                    radius: _isHovered ? 0.95 : 0.85,
                  ),
                ),
              ),

              // Decorative outer gradient border ring
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: innerWidth + 8.adaptSize,
                height: innerHeight + 8.adaptSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.adaptSize),
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [WebColors.greenBright, WebColors.cyanAccent, WebColors.greenPrimary]
                        : [WebColors.greenPrimary.withValues(alpha: 0.6), WebColors.borderLight, WebColors.cyanAccent.withValues(alpha: 0.3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Inner card containing image
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: innerWidth,
                height: innerHeight,
                padding: EdgeInsets.all(4.adaptSize),
                decoration: BoxDecoration(
                  color: WebColors.bgSecondary,
                  borderRadius: BorderRadius.circular(24.adaptSize),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? WebColors.greenBright.withValues(alpha: 0.35)
                          : WebColors.greenGlow.withValues(alpha: 0.2),
                      blurRadius: _isHovered ? 35.adaptSize : 25.adaptSize,
                      spreadRadius: _isHovered ? 3.adaptSize : 1.adaptSize,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.adaptSize),
                  child: Obx(() {
                    final avatarUrl = homeController.profile.value.profileImageUrl.trim();
                    if (avatarUrl.isNotEmpty) {
                      return Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/profile_image.jpeg',
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            color: WebColors.bgCard,
                            child: Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: WebColors.greenPrimary,
                                size: 64.adaptSize,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return Image.asset(
                      'assets/images/profile_image.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: WebColors.bgCard,
                        child: Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: WebColors.greenPrimary,
                            size: 64.adaptSize,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Floating Availability Badge (Bottom Right)
              Positioned(
                bottom: -10.adaptSize,
                right: -6.adaptSize,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.adaptSize,
                    vertical: 8.adaptSize,
                  ),
                  decoration: BoxDecoration(
                    color: WebColors.bgCard.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(30.adaptSize),
                    border: Border.all(
                      color: WebColors.greenPrimary.withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: WebColors.greenGlow.withValues(alpha: 0.3),
                        blurRadius: 12,
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
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.25, 1.25), duration: 1200.ms),
                      SizedBox(width: 8.adaptSize),
                      Obx(() {
                        final statusText = homeController.profile.value.availabilityStatus.isNotEmpty
                            ? homeController.profile.value.availabilityStatus.toUpperCase()
                            : 'AVAILABLE FOR WORK';
                        return Text(
                          statusText,
                          style: AppTextStyles.eyebrow(
                            fontSize: 10,
                            color: WebColors.textPrimary,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Floating Flutter Tech Badge (Top Left)
              Positioned(
                top: 16.adaptSize,
                left: -16.adaptSize,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 6.adaptSize),
                  decoration: BoxDecoration(
                    color: WebColors.bgCard.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(20.adaptSize),
                    border: Border.all(
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.25),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.flutter_dash,
                        color: const Color(0xFF38BDF8),
                        size: 16.adaptSize,
                      ),
                      SizedBox(width: 6.adaptSize),
                      Text(
                        'Flutter Pro',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 11.fSize,
                          fontWeight: FontWeight.w700,
                          color: WebColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Floating Firebase Tech Badge (Middle Left)
              Positioned(
                bottom: 50.adaptSize,
                left: -20.adaptSize,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.adaptSize, vertical: 6.adaptSize),
                  decoration: BoxDecoration(
                    color: WebColors.bgCard.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(20.adaptSize),
                    border: Border.all(
                      color: WebColors.warning.withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: WebColors.warning.withValues(alpha: 0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department_rounded,
                        color: WebColors.warning,
                        size: 16.adaptSize,
                      ),
                      SizedBox(width: 6.adaptSize),
                      Text(
                        'Firebase Suite',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 11.fSize,
                          fontWeight: FontWeight.w700,
                          color: WebColors.textPrimary,
                        ),
                      ),
                    ],
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
        .moveY(begin: -6, end: 6, duration: 2600.ms, curve: Curves.easeInOut);
  }
}
