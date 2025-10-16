import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quiz_model.dart';

class ApiService {
  Future<List<QuizQuestion>> fetchQuestions() async {
    // ✅ Open Trivia API link for Video Games (easy difficulty, 10 questions)
    final url =
        "https://opentdb.com/api.php?amount=10&category=15&difficulty=easy&type=multiple";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List results = data['results'];

      // Convert JSON data into list of QuizQuestion objects
      return results.map((q) => QuizQuestion.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load quiz');
    }
  }
}
