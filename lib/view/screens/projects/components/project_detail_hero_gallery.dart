import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/core/utils/media_helper.dart';
import 'package:portfolio/view/screens/projects/components/project_mockup_graphic.dart';

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
    return ProjectMockupGraphic(
      project: widget.project,
      isHero: true,
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

  Widget _buildBlurredFallbackBackdrop({Color? color}) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
      child: Container(
        color: (color ?? WebColors.bgCard).withValues(alpha: 0.3),
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
                  final mediaUrl = widget.project.mediaUrls[index];
                  final mediaType = MediaHelper.getMediaType(mediaUrl);

                  if (mediaType == AppMediaType.image) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        // Blurred backdrop fills the wide banner area
                        Positioned.fill(child: _buildBlurredBackdrop(mediaUrl)),
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
                                  imageUrl: mediaUrl,
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
                  } else if (mediaType == AppMediaType.video) {
                    final thumbnail = MediaHelper.getVideoThumbnail(mediaUrl);
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        if (thumbnail != null)
                          Positioned.fill(child: _buildBlurredBackdrop(thumbnail))
                        else
                          Positioned.fill(child: _buildBlurredFallbackBackdrop(color: const Color(0xFF0F172A))),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.v),
                            child: AspectRatio(
                              aspectRatio: 9 / 17,
                              child: GestureDetector(
                                onTap: () => MediaHelper.openUrl(mediaUrl),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
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
                                    child: Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.expand,
                                      children: [
                                        if (thumbnail != null)
                                          CachedNetworkImage(
                                            imageUrl: thumbnail,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Container(color: WebColors.bgCard),
                                            errorWidget: (context, url, error) => Container(color: WebColors.bgCard),
                                          )
                                        else
                                          Container(color: const Color(0xFF0F172A)),
                                        Container(
                                          color: Colors.black.withValues(alpha: 0.3),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16.adaptSize),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(alpha: 0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: WebColors.greenBright,
                                            size: 48.adaptSize,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 16.v,
                                          child: Text(
                                            'Play Video Demo',
                                            style: AppTextStyles.body(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    final ext = MediaHelper.getFileExtension(mediaUrl);
                    final docColor = MediaHelper.getDocumentColor(ext);
                    final fileName = MediaHelper.getFileName(mediaUrl);

                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(child: _buildBlurredFallbackBackdrop(color: docColor)),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.v),
                            child: AspectRatio(
                              aspectRatio: 9 / 17,
                              child: GestureDetector(
                                onTap: () => MediaHelper.openUrl(mediaUrl),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: WebColors.bgCard,
                                      borderRadius: BorderRadius.circular(20.adaptSize),
                                      border: Border.all(
                                        color: docColor.withValues(alpha: 0.5),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.45),
                                          blurRadius: 40,
                                          spreadRadius: -5,
                                          offset: const Offset(0, 20),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(24.adaptSize),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          MediaHelper.getDocumentIcon(ext),
                                          color: docColor,
                                          size: 80.adaptSize,
                                        ),
                                        SizedBox(height: 16.v),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.v),
                                          decoration: BoxDecoration(
                                            color: docColor.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(8.adaptSize),
                                          ),
                                          child: Text(
                                            ext.isNotEmpty ? ext.toUpperCase() : 'DOC',
                                            style: TextStyle(
                                              fontFamily: 'SpaceGrotesk',
                                              fontSize: 14.fSize,
                                              color: docColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.v),
                                        Text(
                                          fileName,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.body(
                                            color: WebColors.textPrimary,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 24.v),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
                                          decoration: BoxDecoration(
                                            color: docColor,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.download_rounded, color: Colors.white, size: 16.adaptSize),
                                              SizedBox(width: 8.h),
                                              Text(
                                                'Open File',
                                                style: AppTextStyles.body(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ).copyWith(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
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
