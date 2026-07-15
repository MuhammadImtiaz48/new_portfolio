import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/services/project_service.dart';

class ProjectsController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  
  final ProjectService _projectService = ProjectService();
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      isLoading.value = true;
      isError.value = false;
      final fetchedProjects = await _projectService.fetchProjects();
      projects.assignAll(fetchedProjects);
    } catch (e) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  int get totalPages => projects.isEmpty ? 1 : (projects.length / 3).ceil();

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void setPage(int page) {
    currentPage.value = page;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
