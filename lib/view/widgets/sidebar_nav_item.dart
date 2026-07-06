import 'package:flutter/material.dart';

import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/models/sidebar_item_model.dart';
import 'package:portfolio/view/widgets/custom_text.dart';

class SidebarNavItem extends StatefulWidget {
  final SidebarItemModel data;
  final int index;
  final bool active;
  final bool collapsed;
  final VoidCallback onTap;

  const SidebarNavItem({
    super.key,
    required this.data,
    required this.index,
    required this.active,
    required this.collapsed,
    required this.onTap,
  });

  @override
  State<SidebarNavItem> createState() => _SidebarNavItemState();
}

class _SidebarNavItemState extends State<SidebarNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.active
        ? WebColors.textPrimary
        : (_hovered ? WebColors.textPrimary : WebColors.textSecondary);
    
    final numberString = '0${widget.index + 1}';

    final content = AnimatedScale(
      scale: _hovered ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: Row(
        mainAxisAlignment:
        widget.collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          CustomText(
            text: numberString,
            fontSize: 13.fSize,
            fontWeight: FontWeight.w600,
            color: widget.active ? WebColors.textPrimary : WebColors.textMuted,
          ),
          if (!widget.collapsed) ...[
            SizedBox(width: 16.h),
            CustomText(
              text: widget.data.label,
              fontSize: 16.fSize,
              fontWeight: widget.active ? FontWeight.w600 : FontWeight.w500,
              color: color,
            ),
          ],
        ],
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56.v,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: widget.collapsed ? 0 : 20.h),
          decoration: BoxDecoration(
            color: widget.active ? WebColors.bgCardHover : Colors.transparent,
            borderRadius: BorderRadius.circular(12.adaptSize),
          ),
          child: widget.collapsed
              ? Tooltip(message: widget.data.label, child: content)
              : content,
        ),
      ),
    );
  }
}
