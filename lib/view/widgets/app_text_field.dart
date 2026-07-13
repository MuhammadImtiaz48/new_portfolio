import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/core/size_utils.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines = 1,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: WebColors.bgCard,
        borderRadius: BorderRadius.circular(12.adaptSize),
        border: Border.all(
          color: _isFocused ? WebColors.greenPrimary : WebColors.borderLight,
          width: 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: WebColors.greenGlow,
                  blurRadius: 12,
                  spreadRadius: -2,
                )
              ]
            : [],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        style: AppTextStyles.body(color: WebColors.textPrimary),
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: AppTextStyles.body(
            color: _isFocused ? WebColors.greenPrimary : WebColors.textMuted,
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 16.v,
          ),
          errorStyle: AppTextStyles.body(
            color: WebColors.error,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
