import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  final currentIndex = 0.obs;
  final questionID = 0.obs;
  final answer = 0.obs;
  final answers = [].obs;
  final questions = [].obs;
  final pageController = PageController();
}