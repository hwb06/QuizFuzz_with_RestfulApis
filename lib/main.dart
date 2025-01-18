// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/onboarding_provider.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuizProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(), // Changed from HomeScreen to OnboardingScreen
      ),
    );
  }
}
