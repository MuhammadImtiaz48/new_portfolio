import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      //initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
    );
  }
}
