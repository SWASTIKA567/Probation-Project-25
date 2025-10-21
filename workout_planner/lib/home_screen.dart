import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            box("Box 1", Colors.blue),
            box("Box 2", Colors.green),
            box("Box 3", Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget box(String text, Color color) => Container(
    margin: const EdgeInsets.all(8),
    height: 80,
    width: 200,
    decoration: BoxDecoration(
      color: color.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
  );
}
