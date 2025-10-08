import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'easy_quiz.dart';
import 'medium_quiz.dart';
import 'hard_quiz.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 5, 1, 16),
              Color.fromARGB(255, 2, 10, 32),
            ],
          ),
        ),

        child: SafeArea(
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
                    color: Color.fromARGB(255, 215, 201, 215),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Select Your Difficulty Level",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 175, 151, 199),
                  ),
                ),

                const SizedBox(height: 30),

                Column(
                  children: [
                    buildRoundedCard(context, "assets/bg1.jpg", "Easy", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const EasyQuizScreen(difficulty: "LEVEL 1"),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                    buildRoundedCard(
                      context,
                      "assets/medium.jpg",
                      "Medium",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MediumQuizScreen(difficulty: "LEVEL 2"),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    buildRoundedCard(context, "assets/bg3.jpg", "Hard", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HardQuizScreen(difficulty: "LEVEL 3"),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRoundedCard(
    BuildContext context,
    String imagePath,
    String level,
    VoidCallback onTap,
  ) {
    Color glowColor;
    switch (level.toLowerCase()) {
      case 'easy':
        glowColor = const Color.fromARGB(255, 103, 187, 103).withOpacity(0.6);
        break;
      case 'medium':
        glowColor = const Color.fromARGB(255, 114, 148, 172).withOpacity(0.6);
        break;
      case 'hard':
        glowColor = const Color.fromARGB(255, 179, 119, 170).withOpacity(0.6);
        break;
      default:
        glowColor = const Color.fromARGB(255, 232, 186, 236).withOpacity(0.6);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // full width
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: glowColor),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.9),
              blurRadius: 20,
              spreadRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
