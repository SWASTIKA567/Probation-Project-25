import 'package:flutter/material.dart';

class MediumQuizScreen extends StatelessWidget {
  final String difficulty;

  const MediumQuizScreen({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$difficulty Quiz")),
      body: Center(
        child: Text(
          "This is the $difficulty",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
