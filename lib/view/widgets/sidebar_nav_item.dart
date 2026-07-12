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
    final isActive = widget.active;
    final isHovered = _hovered;

    final Color labelColor = isActive
        ? WebColors.textPrimary
        : (isHovered ? WebColors.textPrimary : WebColors.textSecondary);

    final Color numberColor = isActive
        ? WebColors.greenPrimary
        : (isHovered ? WebColors.textSecondary : WebColors.textMuted);

    final numberString = '0${widget.index + 1}';

    final content = Row(
      mainAxisAlignment:
          widget.collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        CustomText(
          text: numberString,
          fontSize: 13.fSize,
          fontWeight: FontWeight.w600,
          color: numberColor,
        ),
        if (!widget.collapsed) ...[
          SizedBox(width: 16.h),
          Flexible(
            child: CustomText(
              text: widget.data.label,
              fontSize: 16.fSize,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: labelColor,
            ),
          ),
        ],
      ],
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          height: 50.v,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: widget.collapsed ? 0 : 20.h),
          decoration: BoxDecoration(
            color: isActive
                ? WebColors.greenPrimary.withValues(alpha: 0.12)
                : (isHovered
                    ? WebColors.textPrimary.withValues(alpha: 0.04)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(12.adaptSize),
            border: Border.all(
              color: isActive
                  ? WebColors.greenPrimary.withValues(alpha: 0.25)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: widget.collapsed
              ? Tooltip(message: widget.data.label, child: content)
              : content,
        ),
      ),
    );
  }
}
