import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mavy_exam/controllers/questions.dart';

import 'theme/colors.dart';
import 'controllers/login.dart';
import 'views/login.dart';
import 'views/questions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    Get.put(QuestionController());

    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      // themeMode: ThemeMode.dark,
      // home: const LoginPage()
      home: const LoginPage()
    );
  }
}
