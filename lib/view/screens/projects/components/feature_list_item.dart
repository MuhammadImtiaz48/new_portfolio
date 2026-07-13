import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';

class FeatureListItem extends StatelessWidget {
  final String feature;

  const FeatureListItem({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.v),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4.v),
            padding: EdgeInsets.all(4.adaptSize),
            decoration: BoxDecoration(
              color: WebColors.greenPrimary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 14.adaptSize,
              color: WebColors.greenPrimary,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Text(
              feature,
              style: AppTextStyles.body(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
