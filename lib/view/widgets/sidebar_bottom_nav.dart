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
        border: Border(
          top: BorderSide(color: WebColors.borderLight, width: 1),
        ),
      ),
      child: Obx(
        () => Row(
          children: List.generate(controller.items.length, (index) {
            final active = controller.activeIndex.value == index;
            final item = controller.items[index];

            return Expanded(
              child: _BottomNavItem(
                item: item,
                active: active,
                onTap: () => controller.setActive(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatefulWidget {
  final dynamic item;
  final bool active;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.item,
    required this.active,
    required this.onTap,
  });

  @override
  State<_BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<_BottomNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: 44.adaptSize,
              height: 44.adaptSize,
              decoration: BoxDecoration(
                color: widget.active
                    ? WebColors.greenPrimary.withValues(alpha: 0.12)
                    : (_hovered
                        ? WebColors.textPrimary.withValues(alpha: 0.05)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(12.adaptSize),
                border: Border.all(
                  color: widget.active
                      ? WebColors.greenPrimary.withValues(alpha: 0.30)
                      : Colors.transparent,
                  width: 1,
                ),
                boxShadow: widget.active
                    ? [
                        BoxShadow(
                          color: WebColors.greenGlow.withValues(alpha: 0.35),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  widget.item.icon,
                  color: widget.active
                      ? WebColors.greenBright
                      : (_hovered
                          ? WebColors.textPrimary
                          : WebColors.textSecondary),
                  size: 20.adaptSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
