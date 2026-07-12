import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/home/components/home_hero_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(
          () => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.isMobile ? 20.h : (responsive.isTablet ? 40.h : 64.h),
                    vertical: 48.v,
                  ),
                  child: const HomeHeroSection(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
