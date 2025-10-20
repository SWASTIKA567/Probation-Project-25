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
  bool _answered = false;
  List<String> _currentOptions = [];

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
        loadOptions();
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void loadOptions() {
    _currentOptions = [
      ..._questions[_currentIndex]['incorrect_answers'].cast<String>(),
      _questions[_currentIndex]['correct_answer'],
    ];
    _currentOptions.shuffle();
  }

  void selectOption(String option) {
    if (_answered) return; // cannot change selection after submit
    setState(() {
      _selectedOption = option;
    });
  }

  void submitAnswer() {
    if (_selectedOption == null || _answered) return;

    final correctAnswer = _questions[_currentIndex]['correct_answer'];

    if (_selectedOption == correctAnswer) _score++;
    setState(() {
      _answered = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedOption = null;
          _answered = false;
          loadOptions();
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
        backgroundColor: widget.themeColor.withOpacity(0.9),
        title: Text('${widget.levelName} Quiz Completed !'),
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
      backgroundColor: widget.themeColor.withOpacity(0.5),
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
                      color: widget.themeColor.withOpacity(0.9),
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
                  ..._buildOptions(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectedOption != null && !_answered
                        ? submitAnswer
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildOptions() {
    return _currentOptions.map((option) {
      Color optioncolor = widget.themeColor.withOpacity(0.7);
      if (_answered) {
        if (option == _questions[_currentIndex]['correct_answer']) {
          optioncolor = Colors.green.withOpacity(0.7);
        } else if (option == _selectedOption &&
            _selectedOption != _questions[_currentIndex]['correct_answer']) {
          optioncolor = Colors.red.withOpacity(0.7);
        }
      } else if (_selectedOption == option) {
        optioncolor = widget.themeColor.withOpacity(0.9);
      }

      return GestureDetector(
        onTap: () => selectOption(option),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: optioncolor,

            borderRadius: BorderRadius.circular(12),
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
