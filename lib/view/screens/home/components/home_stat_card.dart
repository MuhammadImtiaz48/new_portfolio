import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/models/stat_item_model.dart';
import 'package:portfolio/view/widgets/custom_text.dart';

class HomeStatCard extends StatefulWidget {
  final StatItemModel stat;

  const HomeStatCard({super.key, required this.stat});

  @override
  State<HomeStatCard> createState() => _HomeStatCardState();
}

class _HomeStatCardState extends State<HomeStatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.v),
        decoration: BoxDecoration(
          color: WebColors.bgCard,
          borderRadius: BorderRadius.circular(12.adaptSize),
          border: Border.all(
            color: _hovered ? WebColors.borderGreen : WebColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: widget.stat.label.toUpperCase(),
              style: AppTextStyles.statLabel(),
            ),
            SizedBox(height: 6.v),
            CustomText(
              text: widget.stat.value,
              style: AppTextStyles.statValue(),
            ),
          ],
        ),
      ),
    );
  }
}
