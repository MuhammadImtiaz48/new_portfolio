import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/core/size_utils.dart';

class SidebarBottomNav extends StatelessWidget {
  const SidebarBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarController>();

    return Container(
      height: 64.v,
      decoration: BoxDecoration(
        color: WebColors.bgSecondary,
        border: Border(top: BorderSide(color: WebColors.borderLight)),
      ),
      child: Obx(
            () => Row(
          children: List.generate(controller.items.length, (index) {
            final active = controller.activeIndex.value == index;
            final item = controller.items[index];
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.setActive(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.v),
                  decoration: BoxDecoration(
                    color: active
                        ? WebColors.greenPrimary.withValues(alpha: 0.14)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14.adaptSize),
                    boxShadow: active
                        ? [
                      BoxShadow(
                        color: WebColors.greenGlow,
                        blurRadius: 14.adaptSize,
                      ),
                    ]
                        : [],
                  ),
                  child: Icon(
                    item.icon,
                    color: active ? WebColors.greenBright : WebColors.textSecondary,
                    size: 22.adaptSize,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
