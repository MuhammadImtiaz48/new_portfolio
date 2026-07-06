import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/controllers/responsive_controller.dart';
import 'package:portfolio/controllers/sidebar_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResponsiveController(), permanent: true);
    Get.put(SidebarController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
