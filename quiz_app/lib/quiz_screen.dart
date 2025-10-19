import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {
  final String difficulty;
  final String levelName;
  final Color themeColor;

  const QuizScreen({
    super.key,
    required this.difficulty,
    required this.levelName,
    required this.themeColor,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final url = Uri.parse(
      'https://opentdb.com/api.php?amount=10&category=15&difficulty=${widget.difficulty}&type=multiple',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _questions = data['results'];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void checkAnswer(String selectedAnswer) {
    final correctAnswer = _questions[_currentIndex]['correct_answer'];

    setState(() {
      _selectedOption = selectedAnswer;
      if (selectedAnswer == correctAnswer) _score++;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedOption = null;
        });
      } else {
        saveScoreToFirestore();
        showResultDialog();
      }
    });
  }

  Future<void> saveScoreToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('leaderboard').add({
      'userId': user.uid,
      'name': user.displayName ?? user.email,
      'score': _score,
      'difficulty': widget.difficulty,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: widget.themeColor.withOpacity(0.2),
        title: Text('${widget.levelName} Quiz Completed 🎉'),
        content: Text('Your score is $_score / 10'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // back to HomeScreen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeColor.withOpacity(0.2),
      appBar: AppBar(
        title: Text("${widget.levelName} Quiz - Video Games"),
        backgroundColor: widget.themeColor,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Question ${_currentIndex + 1} of ${_questions.length}",
                    style: TextStyle(
                      fontSize: 18,
                      color: widget.themeColor.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentIndex]['question']
                        .toString()
                        .replaceAll('&quot;', '"')
                        .replaceAll('&#039;', "'"),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ..._buildOptions(), // fixed
                ],
              ),
            ),
    );
  }

  List<Widget> _buildOptions() {
    List<String> options = [
      ..._questions[_currentIndex]['incorrect_answers'].cast<String>(),
      _questions[_currentIndex]['correct_answer'],
    ];
    options.shuffle();

    return options.map((option) {
      final isSelected = _selectedOption == option;
      final isCorrect =
          isSelected && option == _questions[_currentIndex]['correct_answer'];
      final isWrong =
          isSelected && option != _questions[_currentIndex]['correct_answer'];

      return GestureDetector(
        onTap: _selectedOption == null ? () => checkAnswer(option) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCorrect
                ? Colors.green.shade300
                : isWrong
                ? Colors.red.shade300
                : widget.themeColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: isCorrect
                          ? Colors.greenAccent
                          : isWrong
                          ? Colors.redAccent
                          : widget.themeColor,
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ]
                : [],
          ),
          child: Text(
            option.replaceAll('&quot;', '"').replaceAll('&#039;', "'"),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }).toList();
  }
}
