import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mavy_exam/controllers/login.dart';
import 'package:mavy_exam/utils/dialog.dart';

import '../controllers/questions.dart';
import '../network/request.dart';
import '../widget/question.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = Get.find<QuestionController>();
    final login = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(questions.questionID.value <= 0 ? "Fetching questions..." : "Question ${questions.questionID.value}"))
      ),
      body: FutureBuilder(
        future: APIServer.fetchQuestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          questions.questions.value = snapshot.data!;

          Timer(const Duration(milliseconds: 0), () {
            questions.questionID.value = snapshot.data![0]["QUESTIONID"];
            questions.answers.value = List.filled(questions.questions.length, -1);
          });

          return Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: questions.pageController,
                children: questions.questions.map((e) => QuestionCard(
                  question: e["QUESTION"],
                  qid: e["QUESTIONID"],
                  choices: e["OPTION"].split("\r\n"),
                )).toList(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.tonal(
                        onPressed: () async {
                          showLoader("Submitting answer!");
                          String message = await APIServer.passAnswer(login.studentID.value, questions.questionID.value, getLetter(questions.answers[questions.questionID.value - 1]));
                          Get.back();

                          if (message == "-1") {
                            return showAppDialog("Empty answer", "Please select your answer!");
                          }

                          showAppDialog(message.indexOf("Sent") > 0 || message.indexOf("Updated") > 0 ? 'Success' : 'Error', message);
                        },
                        child: const Text("Submit answer")
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          if (questions.currentIndex.value > 0) {
                            questions.currentIndex.value--;
                          }

                          questions.questionID.value = questions.questions[questions.currentIndex.value]["QUESTIONID"];
                          questions.answer.value = 0;
                          
                          questions.pageController.animateToPage(
                            questions.currentIndex.value,
                            duration: const Duration(milliseconds: 210),
                            curve: Curves.easeInOut
                          );
                        },
                        child: const Text("Prev")
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          if (questions.currentIndex.value < questions.questions.length - 1) {
                            questions.currentIndex.value++;
                          }

                          questions.questionID.value = questions.questions[questions.currentIndex.value]["QUESTIONID"];
                          questions.answer.value = 0;

                          questions.pageController.animateToPage(
                            questions.currentIndex.value,
                            duration: const Duration(milliseconds: 210),
                            curve: Curves.easeInOut
                          );
                        },
                        child: const Text("Next")
                      ),                      
                    ],
                  ),
                ),
              )
            ],
          );
        }
      )
    );
  }

  String getLetter(int index) {
    if (index == 0) return "A";
    if (index == 1) return "B";
    if (index == 2) return "C";
    if (index == 3) return "D";
    return "";
  }
}