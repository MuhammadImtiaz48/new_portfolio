import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/constants/app_text_styles.dart';

class ProjectDetailHeroGallery extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailHeroGallery({super.key, required this.project});

  @override
  State<ProjectDetailHeroGallery> createState() => _ProjectDetailHeroGalleryState();
}

class _ProjectDetailHeroGalleryState extends State<ProjectDetailHeroGallery> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: WebColors.bgCardHover,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, color: WebColors.textSecondary.withValues(alpha: 0.5), size: 48.adaptSize),
            SizedBox(height: 8.v),
            Text("No Image Available", style: AppTextStyles.body(color: WebColors.textSecondary.withValues(alpha: 0.5), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildBlurredBackdrop(String imageUrl) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        color: Colors.black.withValues(alpha: 0.35),
        colorBlendMode: BlendMode.darken,
        placeholder: (context, url) => Container(color: WebColors.bgCard),
        errorWidget: (context, url, error) => Container(color: WebColors.bgCard),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'project_image_${widget.project.id}',
      child: Container(
        color: WebColors.bgPrimary,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.project.mediaUrls.isEmpty)
              Positioned.fill(child: _buildPlaceholder())
            else
              PageView.builder(
                controller: _pageController,
                itemCount: widget.project.mediaUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = widget.project.mediaUrls[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Blurred backdrop fills the wide banner area
                      Positioned.fill(child: _buildBlurredBackdrop(imageUrl)),
                      // Screenshot shown in its natural portrait shape,
                      // floating as a card instead of being cropped wide
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.v),
                          child: AspectRatio(
                            aspectRatio: 9 / 17,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.adaptSize),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.45),
                                    blurRadius: 40,
                                    spreadRadius: -5,
                                    offset: const Offset(0, 20),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: WebColors.bgCard,
                                  highlightColor: WebColors.bgCardHover,
                                  child: Container(color: WebColors.bgCard),
                                ),
                                errorWidget: (context, url, error) => _buildPlaceholder(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    WebColors.bgPrimary,
                  ],
                  stops: const [0.55, 1.0],
                ),
              ),
            ),
            // Left Arrow
            if (widget.project.mediaUrls.length > 1)
              Positioned(
                left: 24.h,
                top: 0,
                bottom: 0,
                child: Center(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.adaptSize),
                        decoration: BoxDecoration(
                          color: WebColors.bgCard.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                          border: Border.all(color: WebColors.borderLight),
                        ),
                        child: Icon(Icons.chevron_left_rounded, color: WebColors.textPrimary, size: 24.adaptSize),
                      ),
                    ),
                  ),
                ),
              ),
            // Right Arrow
            if (widget.project.mediaUrls.length > 1)
              Positioned(
                right: 24.h,
                top: 0,
                bottom: 0,
                child: Center(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.adaptSize),
                        decoration: BoxDecoration(
                          color: WebColors.bgCard.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                          border: Border.all(color: WebColors.borderLight),
                        ),
                        child: Icon(Icons.chevron_right_rounded, color: WebColors.textPrimary, size: 24.adaptSize),
                      ),
                    ),
                  ),
                ),
              ),
            // Dots indicator
            if (widget.project.mediaUrls.length > 1)
              Positioned(
                bottom: 40.v,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.project.mediaUrls.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 6.adaptSize,
                      dotWidth: 6.adaptSize,
                      activeDotColor: WebColors.greenPrimary,
                      dotColor: WebColors.borderLight,
                      expansionFactor: 3,
                      spacing: 8.h,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
