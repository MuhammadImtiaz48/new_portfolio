import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/contact_controller.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/widgets/sidebar_nav_item.dart';
import 'package:portfolio/core/utils/download_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class SidebarRail extends StatelessWidget {
  final bool collapsed;

  const SidebarRail({super.key, required this.collapsed});

  static const double _itemSpacing = 4;

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email.isNotEmpty ? email : 'developerhouseapl@gmail.com',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarController>();
    final contactController = Get.put(ContactController(), permanent: true);
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
                ? Text('I.', style: AppTextStyles.heading(fontSize: 22))
                : RichText(
                    text: TextSpan(
                      style: AppTextStyles.heading(fontSize: 26),
                      children: [
                        const TextSpan(text: 'Imtiaz'),
                        TextSpan(
                          text: '.',
                          style:
                              const TextStyle(color: WebColors.greenBright),
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
              child: Obx(() {
                final email = contactController.email;
                final githubUrl = contactController.githubUrl.isNotEmpty
                    ? contactController.githubUrl
                    : 'https://github.com/${contactController.githubUsername}';
                final cleanWa = contactController.whatsapp.replaceAll(RegExp(r'[^\d]'), '');
                final waUrl = 'https://wa.me/$cleanWa';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: WebColors.borderLight, height: 1),
                    SizedBox(height: 16.v),

                    // Download CV Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => downloadFile('resume/M_Imtiaz_Resume.pdf', 'M_Imtiaz_Resume.pdf'),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 8.v),
                          decoration: BoxDecoration(
                            color: WebColors.greenPrimary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.adaptSize),
                            border: Border.all(
                              color: WebColors.greenPrimary.withValues(alpha: 0.35),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.download_rounded, size: 14.adaptSize, color: WebColors.greenBright),
                              SizedBox(width: 8.h),
                              Text(
                                'Download CV',
                                style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 12.fSize,
                                  fontWeight: FontWeight.w600,
                                  color: WebColors.greenBright,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 14.v),

                    // Clickable email
                    _EmailButton(
                      email: email,
                      onTap: () => _launchEmail(email),
                    ),

                    SizedBox(height: 16.v),

                    // Social icons — perfectly centered row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _SocialIconWidget(
                          icon: FontAwesomeIcons.github,
                          url: githubUrl,
                        ),
                        SizedBox(width: 10.h),
                        _SocialIconWidget(
                          icon: FontAwesomeIcons.whatsapp,
                          url: waUrl,
                        ),
                        SizedBox(width: 10.h),
                        _SocialIconWidget(
                          icon: FontAwesomeIcons.envelope,
                          url: 'mailto:$email',
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),

          // ── Bottom Section (collapsed sidebar) ───────────────────
          if (collapsed)
            Padding(
              padding: EdgeInsets.only(bottom: 28.v),
              child: Obx(() {
                final email = contactController.email;
                final githubUrl = contactController.githubUrl.isNotEmpty
                    ? contactController.githubUrl
                    : 'https://github.com/${contactController.githubUsername}';
                final cleanWa = contactController.whatsapp.replaceAll(RegExp(r'[^\d]'), '');
                final waUrl = 'https://wa.me/$cleanWa';

                return Column(
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
                      url: githubUrl,
                      small: true,
                    ),
                    SizedBox(height: 10.v),
                    _SocialIconWidget(
                      icon: FontAwesomeIcons.whatsapp,
                      url: waUrl,
                      small: true,
                    ),
                    SizedBox(height: 10.v),
                    _SocialIconWidget(
                      icon: FontAwesomeIcons.envelope,
                      url: 'mailto:$email',
                      small: true,
                    ),
                  ],
                );
              }),
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
  final String email;
  final VoidCallback onTap;
  const _EmailButton({required this.email, required this.onTap});

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
            color: _hovered ? WebColors.greenBright : WebColors.textMuted,
            decoration: _hovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: WebColors.greenBright,
            height: 1.4,
          ),
          child: Text(
            widget.email.contains('@')
                ? widget.email.replaceAll('@', '\n@')
                : widget.email,
          ),
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
        onTap: () async {
          final uri = Uri.tryParse(widget.url);
          if (uri != null && await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
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
