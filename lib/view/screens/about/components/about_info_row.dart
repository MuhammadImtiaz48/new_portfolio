import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDot;

  const AboutInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.showDot = false,
  });

  IconData _getIcon() {
    switch (label.toLowerCase()) {
      case 'location':
        return Icons.location_on_outlined;
      case 'experience':
        return Icons.work_outline_rounded;
      case 'speciality':
        return Icons.code_rounded;
      case 'status':
        return Icons.bolt_rounded;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.adaptSize),
          decoration: BoxDecoration(
            color: WebColors.greenDark.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: WebColors.borderGreen,
              width: 1,
            ),
          ),
          child: Icon(
            _getIcon(),
            color: WebColors.greenBright,
            size: 18.adaptSize,
          ),
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.toUpperCase(),
                style: AppTextStyles.statLabel().copyWith(
                  color: WebColors.textMuted,
                  fontSize: 10.fSize,
                  letterSpacing: 1.5.h,
                ),
              ),
              SizedBox(height: 2.v),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showDot) ...[
                    Container(
                      width: 8.adaptSize,
                      height: 8.adaptSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: WebColors.greenPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: WebColors.greenGlow,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 1000.ms)
                    .fade(begin: 0.7, end: 1.0, duration: 1000.ms),
                    SizedBox(width: 8.h),
                  ],
                  Flexible(
                    child: Text(
                      value,
                      style: AppTextStyles.statValue().copyWith(
                        fontSize: 15.fSize,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
