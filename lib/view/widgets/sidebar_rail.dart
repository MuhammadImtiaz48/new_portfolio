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

  static const double _itemSpacing = 8;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarController>();
    final width = collapsed ? 84.h : 280.h;

    return Container(
      width: width,
      height: double.infinity,
      color: WebColors.bgSecondary,
      child: Column(
        crossAxisAlignment: collapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 64.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: collapsed ? 0 : 32.h),
            child: collapsed 
              ? Text('S.', style: AppTextStyles.heading(fontSize: 24))
              : RichText(
                  text: TextSpan(
                    style: AppTextStyles.heading(fontSize: 32),
                    children: [
                      const TextSpan(text: 'Shahrooz'),
                      TextSpan(
                        text: '.',
                        style: TextStyle(color: WebColors.greenPrimary),
                      ),
                    ],
                  ),
                ),
          ),
          SizedBox(height: 64.v),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: collapsed ? 12.h : 16.h),
              child: Column(
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
          if (!collapsed)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: WebColors.borderLight, height: 1),
                  SizedBox(height: 24.v),
                  Text(
                    'shahroozshafique6\n@gmail.com',
                    style: AppTextStyles.body(fontSize: 13, color: WebColors.textMuted),
                  ),
                  SizedBox(height: 24.v),
                  Row(
                    children: [
                      _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/Shahrooz791'),
                      SizedBox(width: 12.h),
                      _buildSocialIcon(FontAwesomeIcons.linkedinIn, 'https://www.linkedin.com/in/shahroozshafique791'),
                      SizedBox(width: 12.h),
                      _buildSocialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/shahroozshafique6/'),
                    ],
                  ),
                  SizedBox(height: 32.v),
                ],
              ),
            ),
          if (collapsed)
            Padding(
              padding: EdgeInsets.only(bottom: 32.v),
              child: Column(
                children: [
                  _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/Shahrooz791', small: true),
                  SizedBox(height: 12.v),
                  _buildSocialIcon(FontAwesomeIcons.linkedinIn, 'https://www.linkedin.com/in/shahroozshafique791', small: true),
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

  Widget _buildSocialIcon(dynamic icon, String url, {bool small = false}) {
    return _SocialIconWidget(icon: icon, url: url, small: small);
  }
}

class _SocialIconWidget extends StatefulWidget {
  final dynamic icon;
  final String url;
  final bool small;

  const _SocialIconWidget({required this.icon, required this.url, this.small = false});

  @override
  State<_SocialIconWidget> createState() => _SocialIconWidgetState();
}

class _SocialIconWidgetState extends State<_SocialIconWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.small ? 36.adaptSize : 40.adaptSize,
          height: widget.small ? 36.adaptSize : 40.adaptSize,
          decoration: BoxDecoration(
            color: _isHovered ? WebColors.bgCardHover : Colors.transparent,
            borderRadius: BorderRadius.circular(12.adaptSize),
            border: Border.all(
              color: _isHovered ? WebColors.borderGreen : WebColors.borderLight,
            ),
          ),
          child: FaIcon(
            widget.icon,
            size: widget.small ? 16.adaptSize : 18.adaptSize,
            color: _isHovered ? WebColors.greenPrimary : WebColors.textMuted,
          ),
        ),
      ),
    );
  }
}
