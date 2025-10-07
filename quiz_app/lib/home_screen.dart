import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Ready to test your Gaming IQ ?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 90, 37, 88),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Select Your Difficulty Level",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  buildRoundedCard("assets/image1.jpg", "Image One"),
                  SizedBox(height: 20),
                  buildRoundedCard("assets/image2.jpg", "Image Two"),
                  SizedBox(height: 20),
                  buildRoundedCard("assets/image3.jpg", "Image Three"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRoundedCard(String imagePath, String text) {
    return Container(
      width: 200, // full width
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(
          color: const Color.fromARGB(255, 142, 18, 163).withOpacity(0.6),
          width: 4,
        ),

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 130, 39, 144).withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
