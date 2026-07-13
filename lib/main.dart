import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      title: 'SHAHROOZ SHAFIQUE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
      builder: (context, child) => CursorGlowBackground(child: child ?? const SizedBox()),
    );
  }
}
