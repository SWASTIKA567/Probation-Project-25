import 'package:flutter/material.dart';

import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _easyController;
  late final AnimationController _mediumController;
  late final AnimationController _hardController;

  late final Animation<double> _easyGlow;
  late final Animation<double> _mediumGlow;
  late final Animation<double> _hardGlow;

  @override
  void initState() {
    super.initState();

    _easyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _mediumController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _hardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _easyGlow = Tween<double>(begin: 2, end: 18).animate(
      CurvedAnimation(parent: _easyController, curve: Curves.easeInOut),
    );
    _mediumGlow = Tween<double>(begin: 2, end: 14).animate(
      CurvedAnimation(parent: _mediumController, curve: Curves.easeInOut),
    );
    _hardGlow = Tween<double>(begin: 2, end: 16).animate(
      CurvedAnimation(parent: _hardController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _easyController.dispose();
    _mediumController.dispose();
    _hardController.dispose();
    super.dispose();
  }

  void navigate(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildQuizBox({
    required String title,
    required String imagePath,
    required Color baseColor,
    required Color glowColor,
    required Animation<double> animation,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: baseColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.5),
                  blurRadius: animation.value,
                  spreadRadius: animation.value / 2,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(imagePath, fit: BoxFit.cover),
                  Container(
                    color: baseColor.withOpacity(
                      0.1,
                    ), // optional overlay for glow feel
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 3, 12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Ready to test your Gaming IQ?",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 246, 245, 249),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Choose your level",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(251, 255, 252, 252),
                  ),
                ),
                const SizedBox(height: 30),

                // Easy
                _buildQuizBox(
                  title: "Easy Level",
                  imagePath: 'assets/bg1.jpg',
                  baseColor: Colors.green[100]!,
                  glowColor: Colors.green,
                  animation: _easyGlow,
                  onTap: () => navigate(
                    context,
                    QuizScreen(
                      difficulty: "easy",
                      levelName: "Easy",
                      themeColor: const Color.fromARGB(255, 61, 230, 213),
                    ),
                  ),
                ),

                // Medium
                _buildQuizBox(
                  title: "Medium Level",
                  imagePath: 'assets/medium.jpg',
                  baseColor: Colors.amber[100]!,
                  glowColor: const Color.fromARGB(255, 84, 62, 207),
                  animation: _mediumGlow,
                  onTap: () => navigate(
                    context,
                    QuizScreen(
                      difficulty: "medium",
                      levelName: "Medium",
                      themeColor: const Color.fromARGB(255, 123, 114, 207),
                    ),
                  ),
                ),

                // Hard
                _buildQuizBox(
                  title: "Hard Level",
                  imagePath: 'assets/bg3.jpg',
                  baseColor: Colors.pink[100]!,
                  glowColor: const Color.fromARGB(255, 156, 51, 226),
                  animation: _hardGlow,
                  onTap: () => navigate(
                    context,
                    QuizScreen(
                      difficulty: "hard",
                      levelName: "Hard",
                      themeColor: const Color.fromARGB(255, 174, 56, 203),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
