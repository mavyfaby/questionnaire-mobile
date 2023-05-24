import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mavy_exam/controllers/questions.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({ required this.question, required this.choices, required this.qid, super.key});

  final String question;
  final List<String> choices;
  final int qid;

  @override
  Widget build(BuildContext context) {
    final questions = Get.find<QuestionController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() => Column(
              children: choices.asMap().entries.map((e) => RadioListTile<int>(
                value: e.key,
                groupValue: questions.answers[qid - 1],
                title: Text(e.value),
                contentPadding: const EdgeInsets.all(0),
                onChanged: (int? value) {
                  questions.answers[qid - 1] = value;
                }
              )).toList()
            )),
          )
        ]
      ),
    );
  }
}