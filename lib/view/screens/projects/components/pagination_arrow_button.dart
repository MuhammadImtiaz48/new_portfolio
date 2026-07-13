import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';


class PaginationArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool visible;

  const PaginationArrowButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.visible = true,
  });

  @override
  State<PaginationArrowButton> createState() => _PaginationArrowButtonState();
}

class _PaginationArrowButtonState extends State<PaginationArrowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedScale(
        scale: widget.visible ? 1.0 : 0.8,
        duration: const Duration(milliseconds: 300),
        child: IgnorePointer(
          ignoring: !widget.visible,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onPressed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56.adaptSize,
                height: 56.adaptSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHovered ? WebColors.bgCardHover : WebColors.bgCard,
                  border: Border.all(
                    color: _isHovered ? WebColors.greenPrimary : WebColors.borderLight,
                    width: 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: WebColors.greenGlow,
                            blurRadius: 16,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                child: Icon(
                  widget.icon,
                  color: _isHovered ? WebColors.greenPrimary : WebColors.textSecondary,
                  size: 24.adaptSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
