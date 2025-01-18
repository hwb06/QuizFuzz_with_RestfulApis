import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../services/api_service.dart';

class QuizProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  QuizModel? quizData;
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = false;
  List<int> selectedAnswers = [];

  Future<void> fetchQuiz() async {
    isLoading = true;
    notifyListeners();
    try {
      quizData = await _apiService.fetchQuizData();
      selectedAnswers = List.filled(quizData?.questions?.length ?? 0, -1);
    } catch (e) {
      print('Error fetching quiz: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
    notifyListeners();
  }

  void calculateScore() {
    score = 0;
    for (int i = 0; i < (quizData?.questions?.length ?? 0); i++) {
      final question = quizData?.questions?[i];
      if (question != null && selectedAnswers[i] != -1) {
        if (question.options?[selectedAnswers[i]].isCorrect ?? false) {
          score++;
        }
      }
    }
    notifyListeners();
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    selectedAnswers = List.filled(quizData?.questions?.length ?? 0, -1);
    notifyListeners();
  }
}
