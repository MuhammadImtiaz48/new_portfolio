import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/view/screens/projects/project_detail_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:portfolio/core/utils/media_helper.dart';
import 'package:portfolio/view/screens/projects/components/project_mockup_graphic.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Widget _buildPlaceholder() {
    return ProjectMockupGraphic(project: widget.project);
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    String label;

    switch (status.trim().toLowerCase()) {
      case 'staging':
      case 'coming soon':
        badgeColor = const Color(0xFFF59E0B);
        label = 'Coming Soon';
        break;
      case 'maintenance':
      case 'under maintenance':
        badgeColor = const Color(0xFFEF4444);
        label = 'Maintenance';
        break;
      case 'completed':
        badgeColor = WebColors.greenBright;
        label = 'Completed';
        break;
      default:
        badgeColor = const Color(0xFF8B5CF6);
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.v),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4.adaptSize),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.adaptSize,
            height: 5.adaptSize,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.h),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 9.fSize,
              fontWeight: FontWeight.w600,
              color: badgeColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProjectDetailScreen(project: widget.project),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
          decoration: BoxDecoration(
            gradient: WebColors.cardSurfaceGradient,
            borderRadius: BorderRadius.circular(24.adaptSize),
            border: Border.all(
              color: _isHovered ? WebColors.greenBright.withValues(alpha: 0.6) : WebColors.borderLight,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: WebColors.greenGlow.withValues(alpha: 0.25),
                blurRadius: 32,
                spreadRadius: -2,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: WebColors.cyanAccent.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Hero(
                  tag: 'project_image_${widget.project.id}',
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (widget.project.mediaUrls.isNotEmpty) ...[
                        Builder(
                          builder: (context) {
                            final firstMedia = widget.project.mediaUrls.first;
                            final mediaType = MediaHelper.getMediaType(firstMedia);

                            if (mediaType == AppMediaType.image) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Positioned.fill(
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                      child: CachedNetworkImage(
                                        imageUrl: firstMedia,
                                        fit: BoxFit.cover,
                                        color: Colors.black.withValues(alpha: 0.25),
                                        colorBlendMode: BlendMode.darken,
                                        placeholder: (context, url) => Container(color: WebColors.bgCardHover),
                                        errorWidget: (context, url, error) => Container(color: WebColors.bgCardHover),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: AnimatedScale(
                                      scale: _isHovered ? 1.05 : 1.0,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeOutCubic,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.adaptSize),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.adaptSize),
                                          child: CachedNetworkImage(
                                            imageUrl: firstMedia,
                                            fit: BoxFit.contain,
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
                              final thumbnail = MediaHelper.getVideoThumbnail(firstMedia);
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (thumbnail != null)
                                    Positioned.fill(
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                        child: CachedNetworkImage(
                                          imageUrl: thumbnail,
                                          fit: BoxFit.cover,
                                          color: Colors.black.withValues(alpha: 0.4),
                                          colorBlendMode: BlendMode.darken,
                                          placeholder: (context, url) => Container(color: WebColors.bgCardHover),
                                          errorWidget: (context, url, error) => Container(color: WebColors.bgCardHover),
                                        ),
                                      ),
                                    ),
                                  Center(
                                    child: AnimatedScale(
                                      scale: _isHovered ? 1.05 : 1.0,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeOutCubic,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.adaptSize),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.adaptSize),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              if (thumbnail != null)
                                                CachedNetworkImage(
                                                  imageUrl: thumbnail,
                                                  fit: BoxFit.contain,
                                                  placeholder: (context, url) => Container(color: WebColors.bgCard),
                                                  errorWidget: (context, url, error) => Container(color: WebColors.bgCard),
                                                )
                                              else
                                                Container(color: const Color(0xFF0F172A)),
                                              Container(
                                                padding: EdgeInsets.all(12.adaptSize),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withValues(alpha: 0.5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: WebColors.greenBright,
                                                  size: 32.adaptSize,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              final ext = MediaHelper.getFileExtension(firstMedia);
                              final docColor = MediaHelper.getDocumentColor(ext);
                              return Container(
                                color: WebColors.bgCardHover,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        MediaHelper.getDocumentIcon(ext),
                                        color: docColor,
                                        size: 48.adaptSize,
                                      ),
                                      SizedBox(height: 8.v),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
                                        decoration: BoxDecoration(
                                          color: docColor.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(6.adaptSize),
                                        ),
                                        child: Text(
                                          ext.toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 12.fSize,
                                            color: docColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                        ),
                      ] else
                        _buildPlaceholder(),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              WebColors.bgCard.withValues(alpha: 0.8),
                            ],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(18.adaptSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.project.category.toUpperCase(),
                                        style: AppTextStyles.statLabel().copyWith(
                                          color: WebColors.greenPrimary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (widget.project.status.isNotEmpty &&
                                        widget.project.status.trim().toLowerCase() != 'live') ...[
                                      SizedBox(width: 8.h),
                                      _buildStatusBadge(widget.project.status),
                                    ],
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
                                decoration: BoxDecoration(
                                  color: WebColors.greenPrimary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10.adaptSize),
                                ),
                                child: Text(
                                  '0${widget.index + 1}',
                                  style: AppTextStyles.statLabel().copyWith(
                                    color: WebColors.greenBright,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.v),
                          Text(
                            widget.project.title,
                            style: AppTextStyles.heading(fontSize: 21),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.v),
                          Text(
                            widget.project.shortDescription,
                            style: AppTextStyles.body(fontSize: 13, height: 1.4),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.project.techStack.isNotEmpty) ...[
                            Wrap(
                              spacing: 6.h,
                              runSpacing: 4.v,
                              children: widget.project.techStack.take(3).map((tech) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 3.v),
                                  decoration: BoxDecoration(
                                    color: WebColors.bgPrimary.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(6.adaptSize),
                                    border: Border.all(
                                      color: WebColors.borderLight,
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: TextStyle(
                                      fontFamily: 'SpaceGrotesk',
                                      fontSize: 10.fSize,
                                      color: WebColors.greenBright,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10.v),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Explore Project',
                                    style: AppTextStyles.body(
                                      fontSize: 13,
                                      color: _isHovered ? WebColors.greenBright : WebColors.textPrimary,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6.h),
                                  AnimatedSlide(
                                    offset: _isHovered ? const Offset(0.3, 0) : Offset.zero,
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 15.adaptSize,
                                      color: _isHovered ? WebColors.greenBright : WebColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.open_in_new_rounded,
                                size: 14.adaptSize,
                                color: _isHovered ? WebColors.greenBright : WebColors.textMuted,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
