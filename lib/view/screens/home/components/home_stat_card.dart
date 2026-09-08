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
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.v),
        decoration: BoxDecoration(
          gradient: WebColors.cardSurfaceGradient,
          borderRadius: BorderRadius.circular(16.adaptSize),
          border: Border.all(
            color: _hovered ? WebColors.greenBright.withValues(alpha: 0.7) : WebColors.borderLight,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? WebColors.greenGlow.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.2),
              blurRadius: _hovered ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: widget.stat.label.toUpperCase(),
              style: AppTextStyles.statLabel().copyWith(
                color: _hovered ? WebColors.greenBright : WebColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 6.v),
            CustomText(
              text: widget.stat.value,
              style: AppTextStyles.statValue().copyWith(
                fontSize: 22.fSize,
                color: _hovered ? WebColors.greenBright : WebColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

