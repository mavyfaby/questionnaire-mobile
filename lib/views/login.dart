import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mavy_exam/network/request.dart';
import 'package:mavy_exam/views/questions.dart';

import '../controllers/login.dart';
import '../utils/dialog.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Student Login", style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 64),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: TextEditingController(text: "20223962"),
                    decoration: const InputDecoration(
                      labelText: "ID Number",
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      filled: true,
                      // border: OutlineInputBorder()
                    ),
                    onChanged: (value) {
                      loginController.studentID.value = value;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Obx(() => FilledButton(
                    onPressed: loginController.studentID.value.isNotEmpty ? () async {
                      // If username or password is empty, show error
                      if (loginController.studentID.value.isEmpty) {
                        showAppDialog("Error", "Please enter your ID number");
                        return;
                      }

                      // Show loader
                      showLoader("Logging in...");
                      bool success = await APIServer.login(loginController.studentID.value);
                      Get.back();

                      if (success) {
                        Get.off(() => const QuestionsPage());
                      } else {
                        showAppDialog("Error", "Invalid credentials");
                      }
                    } : null,
                    child: const Text("Login")
                  )),
                ),
                const SizedBox(height: 64),
              ],
            ),
          )
        ]
      )
    );
  }
}