import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/widgets/custom_text.dart';

class OutlinedGlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const OutlinedGlowButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  State<OutlinedGlowButton> createState() => _OutlinedGlowButtonState();
}

class _OutlinedGlowButtonState extends State<OutlinedGlowButton> {
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
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.adaptSize),
              border: Border.all(
                color: _hovered ? WebColors.greenBright : WebColors.borderGreen,
                width: 1.5.adaptSize,
              ),
              boxShadow: _hovered
                  ? [
                BoxShadow(
                  color: WebColors.greenGlow,
                  blurRadius: 18.adaptSize,
                  spreadRadius: 0,
                ),
              ]
                  : [],
            ),
            child: CustomText(
              text: widget.label,
              fontSize: 14.fSize,
              fontWeight: FontWeight.w600,
              color: _hovered ? WebColors.greenBright : WebColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
