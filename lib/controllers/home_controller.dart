import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/projects_controller.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/models/site_profile_model.dart';
import 'package:portfolio/models/stat_item_model.dart';
import 'package:portfolio/services/site_profile_service.dart';

class HomeController extends GetxController {
  final SiteProfileService _profileService = Get.put(SiteProfileService(), permanent: true);

  final Rx<SiteProfileModel> profile = SiteProfileModel.defaultProfile().obs;
  final RxList<StatItemModel> stats = <StatItemModel>[].obs;

  StreamSubscription<SiteProfileModel>? _profileSubscription;

  @override
  void onInit() {
    super.onInit();
    _initProfileAndProjectsListeners();
  }

  void _initProfileAndProjectsListeners() {
    // 1. Initial local default stats
    _updateStats();

    // 2. Stream Profile safely from Firestore
    try {
      _profileSubscription = _profileService.streamProfile().listen(
        (p) {
          profile.value = p;
          _updateStats();
        },
        onError: (e) {
          debugPrint('Profile stream error: $e');
        },
      );
    } catch (e) {
      debugPrint('Error subscribing to profile: $e');
    }

    // 3. Update stats whenever profile changes
    ever<SiteProfileModel>(profile, (p) {
      _updateStats();
    });

    // 4. Update stats whenever projects list changes
    if (!Get.isRegistered<ProjectsController>()) {
      Get.put(ProjectsController(), permanent: true);
    }
    final projectsController = Get.find<ProjectsController>();
    ever<List<ProjectModel>>(projectsController.projects, (_) {
      _updateStats();
    });
  }

  @override
  void onClose() {
    _profileSubscription?.cancel();
    super.onClose();
  }

  void _updateStats() {
    final currentStats = profile.value.stats;
    int projectCount = 0;
    if (Get.isRegistered<ProjectsController>()) {
      projectCount = Get.find<ProjectsController>().projects.length;
    }

    final List<StatItemModel> computedStats = [];

    for (final s in currentStats) {
      if (s.label.trim().toLowerCase() == 'projects') {
        final dynamicCount = projectCount > 0 ? '$projectCount+' : (s.value.isNotEmpty ? s.value : '0+');
        computedStats.add(StatItemModel(label: s.label, value: dynamicCount));
      } else {
        computedStats.add(StatItemModel(label: s.label, value: s.value));
      }
    }

    if (computedStats.isEmpty) {
      computedStats.addAll(SiteProfileModel.defaultProfile().stats);
    }

    stats.assignAll(computedStats);
  }
}
