import 'package:get/get.dart';
import 'package:portfolio/controllers/projects_controller.dart';
import 'package:portfolio/models/project_model.dart';

class ProjectDetailController extends GetxController {
  final ProjectModel initialProject;
  final Rx<ProjectModel?> currentProject = Rx<ProjectModel?>(null);

  ProjectDetailController({required this.initialProject});

  @override
  void onInit() {
    super.onInit();
    currentProject.value = initialProject;
  }

  ProjectModel? getNextProject() {
    if (currentProject.value == null) return null;
    try {
      final projectsController = Get.find<ProjectsController>();
      final projects = projectsController.projects;
      final currentIndex = projects.indexWhere((p) => p.id == currentProject.value!.id);
      if (currentIndex != -1 && currentIndex < projects.length - 1) {
        return projects[currentIndex + 1];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  ProjectModel? getPreviousProject() {
    if (currentProject.value == null) return null;
    try {
      final projectsController = Get.find<ProjectsController>();
      final projects = projectsController.projects;
      final currentIndex = projects.indexWhere((p) => p.id == currentProject.value!.id);
      if (currentIndex > 0) {
        return projects[currentIndex - 1];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
