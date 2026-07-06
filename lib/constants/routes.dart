import 'package:get/get.dart';
import 'package:portfolio/bindings/initial_binding.dart';
import 'package:portfolio/view/screens/shell/main_shell.dart';

class AppRoutes {
  AppRoutes._();

  static const String initial = '/';
  static const String home = 'home';
  static const String about = 'about';
  static const String projects = 'projects';
  static const String contact = 'contact';

  static final List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => const MainShell(),
      binding: InitialBinding(),
    ),
  ];
}
