import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/home/components/home_stat_card.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final responsive = Get.find<ResponsiveController>();

    return Obx(() {
      final stats = homeController.stats;

      if (responsive.isMobile) {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.h,
          runSpacing: 12.v,
          children: stats
              .map((stat) => SizedBox(width: 150.h, child: HomeStatCard(stat: stat)))
              .toList(),
        );
      }

      return Row(
        children: stats
            .map(
              (stat) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16.h),
              child: HomeStatCard(stat: stat),
            ),
          ),
        )
            .toList(),
      );
    });
  }
}
