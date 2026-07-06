import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/widgets/custom_text.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.96 : (_hovered ? 1.03 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 16.v),
            decoration: BoxDecoration(
              gradient: WebColors.greenGradient,
              borderRadius: BorderRadius.circular(10.adaptSize),
              boxShadow: _hovered
                  ? [
                BoxShadow(
                  color: WebColors.greenGlow,
                  blurRadius: 24.adaptSize,
                  spreadRadius: 1,
                ),
              ]
                  : [],
            ),
            child: CustomText(
              text: widget.label,
              fontSize: 14.fSize,
              fontWeight: FontWeight.w600,
              color: WebColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
