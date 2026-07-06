import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/projects_controller.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/projects/components/project_card.dart';
import 'package:portfolio/view/screens/projects/components/projects_grid.dart';
import 'package:animations/animations.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(ProjectsController());

    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: WebColors.bgPrimary,
          child: child,
        );
      },
      child: Scaffold(
        key: const ValueKey('ProjectsScreen'),
        backgroundColor: WebColors.bgPrimary,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.h,
            vertical: 24.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FEATURED WORK',
                style: AppTextStyles.eyebrow(),
              ),
              SizedBox(height: 8.v),
              Text(
                'Projects.',
                style: AppTextStyles.heading(fontSize: 48),
              ),
              SizedBox(height: 24.v),
              Expanded(
                child: Obx(() {
                  final isMobile = Get.find<ResponsiveController>().isMobile;
                  final controller = Get.find<ProjectsController>();

                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: WebColors.greenPrimary),
                    );
                  }

                  if (controller.isError.value) {
                    return Center(
                      child: Text(
                        'Failed to load projects. Please try again later.',
                        style: AppTextStyles.body(color: WebColors.error),
                      ),
                    );
                  }

                  if (controller.projects.isEmpty) {
                    return Center(
                      child: Text(
                        'No projects available right now.',
                        style: AppTextStyles.body(),
                      ),
                    );
                  }

                  if (isMobile) {
                    return ListView.separated(
                      itemCount: controller.projects.length,
                      separatorBuilder: (context, index) => SizedBox(height: 32.v),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 400.v, // Fixed height for mobile cards
                          child: ProjectCard(
                            project: controller.projects[index],
                            index: index,
                          ),
                        );
                      },
                    );
                  }

                  return const ProjectsGrid();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
