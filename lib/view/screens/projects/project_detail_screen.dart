import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/app_text_styles.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/controllers/project_detail_controller.dart';
import 'package:portfolio/core/size_utils.dart';
import 'package:portfolio/view/screens/projects/components/feature_list_item.dart';
import 'package:portfolio/view/screens/projects/components/next_project_card.dart';
import 'package:portfolio/view/screens/projects/components/previous_project_card.dart';
import 'package:portfolio/view/screens/projects/components/project_detail_hero_gallery.dart';
import 'package:portfolio/view/screens/projects/components/tech_stack_pill.dart';
import 'package:portfolio/view/widgets/primary_button.dart';
import 'package:portfolio/view/widgets/outlined_glow_button.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;
  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProjectDetailController(initialProject: project),
      tag: project.id,
    );

    return Scaffold(
      backgroundColor: WebColors.bgPrimary,
      body: Obx(() {
        final proj = controller.currentProject.value;
        if (proj == null) return const SizedBox();

        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 600.v,
                floating: false,
                pinned: true,
                backgroundColor: WebColors.bgPrimary,
                elevation: 0,
                leading: IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8.adaptSize),
                    decoration: BoxDecoration(
                      color: WebColors.bgCard.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: WebColors.borderLight),
                    ),
                    child: Icon(Icons.arrow_back_rounded, color: WebColors.textPrimary, size: 20.adaptSize),
                  ),
                  onPressed: () {
                    Get.delete<ProjectDetailController>(tag: proj.id);
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: ProjectDetailHeroGallery(project: proj),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 48.v),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          proj.category.toUpperCase(),
                          style: AppTextStyles.eyebrow(),
                        ),
                        if (proj.status.isNotEmpty &&
                            proj.status.trim().toLowerCase() != 'live') ...[
                          SizedBox(width: 12.h),
                          _buildStatusBadge(proj.status),
                        ],
                      ],
                    ).animate().fade(duration: 400.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 8.v),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.heading(fontSize: 46),
                        children: [
                          TextSpan(text: proj.title),
                          const TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: WebColors.greenBright,
                              shadows: [
                                Shadow(
                                  color: WebColors.greenGlow,
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fade(duration: 400.ms, delay: 100.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 32.v),

                    Text(
                      'Overview',
                      style: AppTextStyles.heading(fontSize: 24),
                    ).animate().fade(duration: 400.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 16.v),
                    Text(
                      proj.fullDescription,
                      style: AppTextStyles.body(fontSize: 16),
                    ).animate().fade(duration: 400.ms, delay: 250.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 48.v),

                    Text(
                      'Tech Stack',
                      style: AppTextStyles.heading(fontSize: 24),
                    ).animate().fade(duration: 400.ms, delay: 300.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 16.v),
                    Wrap(
                      spacing: 12.h,
                      runSpacing: 12.v,
                      children: proj.techStack.map((tech) {
                        return TechStackPill(label: tech);
                      }).toList(),
                    ).animate().fade(duration: 400.ms, delay: 350.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 48.v),

                    if (proj.features.isNotEmpty) ...[
                      Text(
                        'Key Features',
                        style: AppTextStyles.heading(fontSize: 24),
                      ).animate().fade(duration: 400.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
                      SizedBox(height: 16.v),
                      ...proj.features.asMap().entries.map((entry) {
                        return FeatureListItem(feature: entry.value)
                            .animate()
                            .fade(duration: 400.ms, delay: (450 + entry.key * 50).ms)
                            .slideX(begin: 0.1, end: 0);
                      }),
                      SizedBox(height: 48.v),
                    ],

                    // Links
                    Row(
                      children: [
                        if (proj.liveDemoUrl != null && proj.liveDemoUrl!.isNotEmpty) ...[
                          PrimaryButton(
                            label: 'Live Demo',
                            onTap: () => _launch(proj.liveDemoUrl!),
                          ),
                          SizedBox(width: 16.h),
                        ],
                        if (proj.githubUrl != null && proj.githubUrl!.isNotEmpty) ...[
                          OutlinedGlowButton(
                            label: 'GitHub',
                            onTap: () => _launch(proj.githubUrl!),
                          ),
                          SizedBox(width: 16.h),
                        ],
                        if (proj.playStoreUrl != null && proj.playStoreUrl!.isNotEmpty) ...[
                          OutlinedGlowButton(
                            label: 'Play Store',
                            onTap: () => _launch(proj.playStoreUrl!),
                          ),
                          SizedBox(width: 16.h),
                        ],
                        if (proj.appStoreUrl != null && proj.appStoreUrl!.isNotEmpty) ...[
                          OutlinedGlowButton(
                            label: 'App Store',
                            onTap: () => _launch(proj.appStoreUrl!),
                          ),
                        ],
                      ],
                    ).animate().fade(duration: 400.ms, delay: 600.ms).slideY(begin: 0.2, end: 0),
                    SizedBox(height: 64.v),

                    // Navigation
                    Builder(builder: (context) {
                      final prevProject = controller.getPreviousProject();
                      final nextProject = controller.getNextProject();
                      if (prevProject != null || nextProject != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: WebColors.borderLight),
                            SizedBox(height: 32.v),
                            Row(
                              children: [
                                if (prevProject != null)
                                  Expanded(child: PreviousProjectCard(
                                    previousProject: prevProject,
                                    currentProjectId: proj.id,
                                  )),
                                if (prevProject != null && nextProject != null)
                                  SizedBox(width: 32.h),
                                if (nextProject != null)
                                  Expanded(child: NextProjectCard(
                                    nextProject: nextProject,
                                    currentProjectId: proj.id,
                                  ))
                                else if (prevProject != null)
                                  const Expanded(child: SizedBox()),
                              ],
                            ),
                          ],
                        ).animate().fade(duration: 400.ms, delay: 700.ms);
                      }
                      return const SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
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
        label = 'Under Maintenance';
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
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.v),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.adaptSize),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.adaptSize,
            height: 6.adaptSize,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.h),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 11.fSize,
              fontWeight: FontWeight.w600,
              color: badgeColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  void _launch(String url) {
    launchUrl(Uri.parse(url));
  }
}
