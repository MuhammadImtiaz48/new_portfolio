import 'package:get/get.dart';
import 'package:portfolio/controllers/about_controller.dart';
import 'package:portfolio/controllers/contact_controller.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/controllers/projects_controller.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';
import 'package:portfolio/services/project_service.dart';
import 'package:portfolio/services/site_profile_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SiteProfileService(), permanent: true);
    Get.put(ProjectService(), permanent: true);
    Get.put(ResponsiveController(), permanent: true);
    Get.put(SidebarController(), permanent: true);
    Get.put(ProjectsController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(AboutController(), permanent: true);
    Get.put(ContactController(), permanent: true);
  }
}
