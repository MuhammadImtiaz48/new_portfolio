import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/project_detail_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/view/screens/projects/project_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NextProjectCard extends StatefulWidget {
  final ProjectModel nextProject;
  final String currentProjectId;

  const NextProjectCard({super.key, required this.nextProject, required this.currentProjectId});

  @override
  State<NextProjectCard> createState() => _NextProjectCardState();
}

class _NextProjectCardState extends State<NextProjectCard> {
  bool _isHovered = false;

  Widget _buildPlaceholder() {
    return Container(
      color: WebColors.bgCardHover,
      child: Center(
        child: Icon(Icons.image_outlined, color: WebColors.textSecondary.withValues(alpha: 0.5), size: 24.adaptSize),
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
          Get.delete<ProjectDetailController>(tag: widget.currentProjectId, force: true);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ProjectDetailScreen(project: widget.nextProject),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          height: 120.v,
          decoration: BoxDecoration(
            color: WebColors.bgCard,
            borderRadius: BorderRadius.circular(16.adaptSize),
            border: Border.all(
              color: _isHovered ? WebColors.borderGreen : WebColors.borderLight,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: WebColors.greenGlow.withValues(alpha: 0.1),
                      blurRadius: 20,
                    )
                  ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: widget.nextProject.mediaUrls.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.nextProject.mediaUrls.first,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NEXT PROJECT',
                            style: AppTextStyles.statLabel(),
                          ),
                          SizedBox(height: 8.v),
                          Text(
                            widget.nextProject.title,
                            style: AppTextStyles.heading(fontSize: 20),
                          ),
                        ],
                      ),
                      AnimatedSlide(
                        offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: _isHovered ? WebColors.greenPrimary : WebColors.textPrimary,
                          size: 24.adaptSize,
                        ),
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
