import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:shimmer/shimmer.dart';

class ProfileImageFrame extends StatelessWidget {
  const ProfileImageFrame({
    super.key,
    this.imageUrl = _defaultImageUrl,
    this.badges = const [],
  });

  static const String _defaultImageUrl = 'https://i.pravatar.cc/400?img=13';
  final String imageUrl;
  final List<Widget> badges;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.adaptSize,
      height: 280.adaptSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 280.adaptSize,
            height: 280.adaptSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [WebColors.greenGlow, Colors.transparent],
              ),
            ),
          ),
          Container(
            width: 220.adaptSize,
            height: 220.adaptSize,
            padding: EdgeInsets.all(4.adaptSize),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: WebColors.greenPrimary,
                width: 2.adaptSize,
              ),
              boxShadow: [
                BoxShadow(
                  color: WebColors.greenGlow,
                  blurRadius: 30.adaptSize,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: WebColors.bgCard,
                  highlightColor: WebColors.bgCardHover,
                  child: Container(color: WebColors.bgCard),
                ),
                errorWidget: (context, url, error) => Container(
                  color: WebColors.bgCard,
                  child: Icon(
                    Icons.person_rounded,
                    color: WebColors.textMuted,
                    size: 64.adaptSize,
                  ),
                ),
              ),
            ),
          ),
          ...badges,
        ],
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: -8, end: 8, duration: 2400.ms, curve: Curves.easeInOut);
  }
}
