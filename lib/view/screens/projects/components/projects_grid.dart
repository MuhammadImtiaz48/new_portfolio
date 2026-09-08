import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/projects_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/projects/components/pagination_arrow_button.dart';
import 'package:portfolio/view/screens/projects/components/project_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectsController>();

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              // Left Arrow
              Obx(() => PaginationArrowButton(
                icon: Icons.chevron_left_rounded,
                onPressed: controller.previousPage,
                visible: controller.currentPage.value > 0,
              )),
              SizedBox(width: 24.h),

              // Grid Pages
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(), // Only tap navigation
                  onPageChanged: controller.setPage,
                  itemCount: controller.totalPages,
                  itemBuilder: (context, pageIndex) {
                    final startIndex = pageIndex * 3;
                    final itemsInPage = controller.projects.skip(startIndex).take(3).toList();

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = constraints.maxWidth > 860 ? 3 : 2;
                        final crossAxisSpacing = 20.h;
                        final mainAxisSpacing = 20.v;
                        const rows = 1;

                        final cellWidth = (constraints.maxWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;
                        final cellHeight = (constraints.maxHeight - (mainAxisSpacing * (rows - 1))) / rows;
                        final calculatedRatio = cellWidth / cellHeight;
                        final aspectRatio = calculatedRatio.clamp(0.60, 0.92);

                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: aspectRatio,
                            crossAxisSpacing: crossAxisSpacing,
                            mainAxisSpacing: mainAxisSpacing,
                          ),
                          itemCount: itemsInPage.length,
                          itemBuilder: (context, index) {
                            final project = itemsInPage[index];
                            final globalIndex = startIndex + index;
                            return ProjectCard(
                              project: project,
                              index: globalIndex,
                            ).animate().fade(duration: 400.ms, delay: (100 * index).ms).slideY(begin: 0.1, end: 0);
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(width: 24.h),
              // Right Arrow
              Obx(() => PaginationArrowButton(
                icon: Icons.chevron_right_rounded,
                onPressed: controller.nextPage,
                visible: controller.currentPage.value < controller.totalPages - 1,
              )),
            ],
          ),
        ),
        SizedBox(height: 32.v),
        // Dot Indicators
        Obx(() => SmoothPageIndicator(
          controller: controller.pageController,
          count: controller.totalPages,
          effect: ExpandingDotsEffect(
            dotHeight: 6.adaptSize,
            dotWidth: 6.adaptSize,
            activeDotColor: WebColors.greenPrimary,
            dotColor: WebColors.borderLight,
            expansionFactor: 3,
            spacing: 8.h,
          ),
        )),
      ],
    );
  }
}
