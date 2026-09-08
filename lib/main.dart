import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/view/widgets/cursor_glow_background.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Muhammad Imtiaz | Flutter App Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: WebColors.bgPrimary,
        canvasColor: WebColors.bgPrimary,
        fontFamily: 'SpaceGrotesk',
        colorScheme: ColorScheme.dark(
          primary: WebColors.greenPrimary,
          secondary: WebColors.cyanAccent,
          surface: WebColors.bgCard,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: WebColors.greenBright,
          selectionColor: WebColors.greenPrimary.withValues(alpha: 0.35),
          selectionHandleColor: WebColors.greenBright,
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(WebColors.borderLight),
          radius: const Radius.circular(8),
          thickness: WidgetStateProperty.all(6),
        ),
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
      builder: (context, child) => CursorGlowBackground(child: child ?? const SizedBox()),
    );
  }
}
