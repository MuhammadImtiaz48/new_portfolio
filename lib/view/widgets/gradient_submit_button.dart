import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GradientSubmitButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isSuccess;

  const GradientSubmitButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.isSuccess = false,
  });

  @override
  State<GradientSubmitButton> createState() => _GradientSubmitButtonState();
}

class _GradientSubmitButtonState extends State<GradientSubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.isLoading || widget.isSuccess
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (widget.isLoading || widget.isSuccess) ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 56.adaptSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.adaptSize),
            gradient: WebColors.greenGradient,
            boxShadow: _isHovered && !widget.isLoading && !widget.isSuccess
                ? [
                    BoxShadow(
                      color: WebColors.greenGlow,
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: widget.isSuccess
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: WebColors.bgPrimary, size: 20.adaptSize),
                      SizedBox(width: 8.h),
                      Text(
                        'Sent!',
                        style: AppTextStyles.heading(
                          fontSize: 16,
                          color: WebColors.bgPrimary,
                        ),
                      ),
                    ],
                  ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack)
                : widget.isLoading
                    ? SizedBox(
                        width: 24.adaptSize,
                        height: 24.adaptSize,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(WebColors.bgPrimary),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send Message',
                            style: AppTextStyles.heading(
                              fontSize: 16,
                              color: WebColors.bgPrimary,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Icon(
                            Icons.arrow_forward,
                            color: WebColors.bgPrimary,
                            size: 18.adaptSize,
                          ),
                        ],
                      ),
          ),
        )
        .animate(
          target: _isHovered && !widget.isLoading && !widget.isSuccess ? 1 : 0,
        )
        .shimmer(
          duration: 1000.ms,
          color: Colors.white24,
        ),
      ),
    );
  }
}
