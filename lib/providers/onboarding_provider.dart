// lib/providers/onboarding_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/home_screen.dart';

class OnboardingProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Select a Contest',
      'description':
          'Unlock any event you find exciting and pay entry fee to enter the contest',
      'image': 'assets/images/select_contest.png',
    },
    {
      'title': 'Play Quiz',
      'description':
          'Once you enter pick a topic and Play Quiz and increase your knowledge',
      'image': 'assets/images/play_quiz.png',
    },
    {
      'title': 'Score',
      'description':
          'Your score will be presented to you at the end of the Quiz',
      'image': 'assets/images/score.png',
    },
    {
      'title': 'Leaderboard',
      'description': 'Fastest to answer all Quiz questions Correctly Wins',
      'image': 'assets/images/leaderboard.png',
    },
  ];

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void skipOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
