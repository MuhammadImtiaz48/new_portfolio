import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/widgets/sidebar_nav_item.dart';
import 'package:url_launcher/url_launcher.dart';

class SidebarRail extends StatelessWidget {
  final bool collapsed;

  const SidebarRail({super.key, required this.collapsed});

  static const double _itemSpacing = 4;

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'shahroozshafique6@gmail.com',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarController>();
    final width = collapsed ? 84.h : 220.h;

    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: WebColors.bgSecondary,
        border: Border(
          right: BorderSide(color: WebColors.borderLight, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            collapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.v),

          // ── Logo / Brand ──────────────────────────────────────────
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: collapsed ? 0 : 24.h),
            child: collapsed
                ? Text('S.', style: AppTextStyles.heading(fontSize: 22))
                : RichText(
                    text: TextSpan(
                      style: AppTextStyles.heading(fontSize: 26),
                      children: [
                        const TextSpan(text: 'Shahrooz'),
                        TextSpan(
                          text: '.',
                          style:
                              TextStyle(color: WebColors.greenPrimary),
                        ),
                      ],
                    ),
                  ),
          ),

          SizedBox(height: 48.v),

          // ── Nav Items ─────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: collapsed ? 10.h : 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(controller.items.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: _itemSpacing.v),
                    child: Obx(
                      () => SidebarNavItem(
                        data: controller.items[index],
                        index: index,
                        collapsed: collapsed,
                        active: controller.activeIndex.value == index,
                        onTap: () => controller.setActive(index),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // ── Bottom Section (expanded sidebar) ─────────────────────
          if (!collapsed)
            Padding(
              padding: EdgeInsets.fromLTRB(20.h, 0, 20.h, 28.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: WebColors.borderLight, height: 1),
                  SizedBox(height: 20.v),

                  // Clickable email
                  _EmailButton(onTap: _launchEmail),

                  SizedBox(height: 18.v),

                  // Social icons — perfectly centered row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _SocialIconWidget(
                        icon: FontAwesomeIcons.github,
                        url: 'https://github.com/Shahrooz791',
                      ),
                      SizedBox(width: 10.h),
                      _SocialIconWidget(
                        icon: FontAwesomeIcons.linkedinIn,
                        url: 'https://www.linkedin.com/in/shahroozshafique791',
                      ),
                      SizedBox(width: 10.h),
                      _SocialIconWidget(
                        icon: FontAwesomeIcons.instagram,
                        url: 'https://www.instagram.com/shahroozshafique6/',
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // ── Bottom Section (collapsed sidebar) ───────────────────
          if (collapsed)
            Padding(
              padding: EdgeInsets.only(bottom: 28.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    color: WebColors.borderLight,
                    height: 1,
                    indent: 12.h,
                    endIndent: 12.h,
                  ),
                  SizedBox(height: 16.v),
                  _SocialIconWidget(
                    icon: FontAwesomeIcons.github,
                    url: 'https://github.com/Shahrooz791',
                    small: true,
                  ),
                  SizedBox(height: 10.v),
                  _SocialIconWidget(
                    icon: FontAwesomeIcons.linkedinIn,
                    url: 'https://www.linkedin.com/in/shahroozshafique791',
                    small: true,
                  ),
                  SizedBox(height: 10.v),
                  _SocialIconWidget(
                    icon: FontAwesomeIcons.instagram,
                    url: 'https://www.instagram.com/shahroozshafique6/',
                    small: true,
                  ),
                ],
              ),
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Clickable email button
// ─────────────────────────────────────────────────────────────────────────────
class _EmailButton extends StatefulWidget {
  final VoidCallback onTap;
  const _EmailButton({required this.onTap});

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 12.fSize,
            fontWeight: FontWeight.w500,
            color: _hovered ? WebColors.greenPrimary : WebColors.textMuted,
            decoration: _hovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: WebColors.greenPrimary,
            height: 1.5,
          ),
          child: const Text('shahroozshafique6\n@gmail.com'),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Social icon button
// ─────────────────────────────────────────────────────────────────────────────
class _SocialIconWidget extends StatefulWidget {
  final dynamic icon;
  final String url;
  final bool small;

  const _SocialIconWidget({
    required this.icon,
    required this.url,
    this.small = false,
  });

  @override
  State<_SocialIconWidget> createState() => _SocialIconWidgetState();
}

class _SocialIconWidgetState extends State<_SocialIconWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.small ? 34.adaptSize : 38.adaptSize;
    final iconSize = widget.small ? 15.adaptSize : 16.adaptSize;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _isHovered
                ? WebColors.greenPrimary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.adaptSize),
            border: Border.all(
              color: _isHovered
                  ? WebColors.greenPrimary.withValues(alpha: 0.4)
                  : WebColors.borderLight,
              width: 1,
            ),
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              size: iconSize,
              color: _isHovered ? WebColors.greenPrimary : WebColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
