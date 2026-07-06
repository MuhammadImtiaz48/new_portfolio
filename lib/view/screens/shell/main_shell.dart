import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/about/about.dart';
import 'package:portfolio/view/screens/contact/contact.dart';
import 'package:portfolio/view/screens/home/home.dart';
import 'package:portfolio/view/screens/projects/projects.dart';
import 'package:portfolio/view/widgets/sidebar.dart';
import 'package:portfolio/view/widgets/sidebar_bottom_nav.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Get.find<ResponsiveController>();
    final sidebarController = Get.find<SidebarController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeUtils.setScreenSize(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          responsive.updateDeviceType(SizeUtils.deviceType);
        });

        return Obx(() {
          final content = IndexedStack(
            index: sidebarController.activeIndex.value,
            children: const [
              HomeScreen(),
              AboutScreen(),
              ProjectsScreen(),
              ContactScreen(),
            ],
          );

          if (responsive.isMobile) {
            return Scaffold(
              backgroundColor: WebColors.bgPrimary,
              body: SafeArea(child: content),
              bottomNavigationBar: const SidebarBottomNav(),
            );
          }

          return Scaffold(
            backgroundColor: WebColors.bgPrimary,
            body: Row(
              children: [
                SidebarWidget(key: ValueKey(responsive.deviceType)),
                Expanded(child: content),
              ],
            ),
          );
        });
      },
    );
  }
}
