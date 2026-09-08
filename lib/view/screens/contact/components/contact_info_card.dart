import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoCard extends StatefulWidget {
  final Widget iconWidget;
  final String label;
  final String value;
  final String urlScheme;
  final bool showCopyButton;

  const ContactInfoCard({
    super.key,
    required this.iconWidget,
    required this.label,
    required this.value,
    required this.urlScheme,
    this.showCopyButton = false,
  });

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.urlScheme);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.value));
    Get.rawSnackbar(
      messageText: Text(
        '${widget.label} copied to clipboard!',
        style: const TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w600,
          color: WebColors.textPrimary,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: WebColors.bgCard,
      borderColor: WebColors.greenBright,
      borderWidth: 1,
      margin: const EdgeInsets.all(20),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle_rounded, color: WebColors.greenBright),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          padding: EdgeInsets.all(18.adaptSize),
          decoration: BoxDecoration(
            gradient: WebColors.cardSurfaceGradient,
            borderRadius: BorderRadius.circular(16.adaptSize),
            border: Border.all(
              color: _isHovered ? WebColors.greenBright.withValues(alpha: 0.7) : WebColors.borderLight,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? WebColors.greenGlow.withValues(alpha: 0.22) : Colors.black.withValues(alpha: 0.2),
                blurRadius: _isHovered ? 24 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.adaptSize),
                decoration: BoxDecoration(
                  color: WebColors.greenPrimary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isHovered ? WebColors.greenBright.withValues(alpha: 0.5) : WebColors.borderLight,
                    width: 1,
                  ),
                ),
                child: widget.iconWidget,
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label.toUpperCase(),
                      style: AppTextStyles.statLabel().copyWith(
                        color: _isHovered ? WebColors.greenBright : WebColors.textMuted,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      widget.value,
                      style: AppTextStyles.statValue().copyWith(
                        fontSize: 16.fSize,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (widget.showCopyButton) ...[
                Tooltip(
                  message: 'Copy to Clipboard',
                  child: IconButton(
                    icon: Icon(
                      Icons.copy_rounded,
                      size: 18.adaptSize,
                      color: _isHovered ? WebColors.greenBright : WebColors.textMuted,
                    ),
                    onPressed: _copyToClipboard,
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 18.adaptSize,
                  color: _isHovered ? WebColors.greenBright : WebColors.textMuted,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
