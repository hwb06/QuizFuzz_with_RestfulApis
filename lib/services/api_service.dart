import 'dart:convert';
import 'package:flutter_quiz_app/models/quiz_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<QuizModel> fetchQuizData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return QuizModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}