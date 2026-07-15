import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/view/screens/projects/project_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

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
            color: WebColors.bgCard,
            borderRadius: BorderRadius.circular(24.adaptSize),
            border: Border.all(
              color: _isHovered ? WebColors.borderGreen : WebColors.borderLight,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: WebColors.greenGlow.withValues(alpha: 0.1),
                blurRadius: 30,
                spreadRadius: -5,
                offset: const Offset(0, 10),
              )
            ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Hero(
                  tag: 'project_image_${widget.project.id}',
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (widget.project.mediaUrls.isNotEmpty) ...[
                        // Blurred backdrop fills the card so portrait
                        // screenshots aren't cropped by a hard cover fit
                        Positioned.fill(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: CachedNetworkImage(
                              imageUrl: widget.project.mediaUrls.first,
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
                                  imageUrl: widget.project.mediaUrls.first,
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
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.adaptSize, vertical: 16.adaptSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.project.category.toUpperCase(),
                            style: AppTextStyles.statLabel(),
                          ),
                          Text(
                            '0${widget.index + 1}',
                            style: AppTextStyles.statLabel().copyWith(
                              color: WebColors.greenPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.v),
                      Text(
                        widget.project.title,
                        style: AppTextStyles.heading(fontSize: 22),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.v),
                      Expanded(
                        child: Text(
                          widget.project.shortDescription,
                          style: AppTextStyles.body(fontSize: 13),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8.v),
                      Row(
                        children: [
                          Text(
                            'View Details',
                            style: AppTextStyles.body(
                              fontSize: 14,
                              color: _isHovered ? WebColors.greenPrimary : WebColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          AnimatedSlide(
                            offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 16.adaptSize,
                              color: _isHovered ? WebColors.greenPrimary : WebColors.textPrimary,
                            ),
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
