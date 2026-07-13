import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoCard extends StatefulWidget {
  final Widget iconWidget;
  final String label;
  final String value;
  final String urlScheme;

  const ContactInfoCard({
    super.key,
    required this.iconWidget,
    required this.label,
    required this.value,
    required this.urlScheme,
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
          padding: EdgeInsets.all(20.adaptSize),
          decoration: BoxDecoration(
            color: _isHovered ? WebColors.bgCardHover : WebColors.bgCard,
            borderRadius: BorderRadius.circular(16.adaptSize),
            border: Border.all(
              color: _isHovered ? WebColors.borderGreen : WebColors.borderLight,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: WebColors.greenGlow,
                      blurRadius: 20,
                      spreadRadius: -5,
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.adaptSize),
                decoration: BoxDecoration(
                  color: WebColors.bgPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: WebColors.borderLight,
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
                      style: AppTextStyles.statLabel(),
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      widget.value,
                      style: AppTextStyles.statValue(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
