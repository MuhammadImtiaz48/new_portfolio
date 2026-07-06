import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/view/widgets/sidebar_bottom_nav.dart';
import 'package:portfolio/view/widgets/sidebar_rail.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();

    return Obx(() {
      if (responsive.isMobile) {
        return const SidebarBottomNav();
      }
      return SidebarRail(collapsed: responsive.isTablet);
    });
  }
}
