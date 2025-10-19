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

    _easyGlow = Tween<double>(begin: 2, end: 12).animate(
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
              color: baseColor.withOpacity(0.7),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.6),
                  blurRadius: animation.value,
                  spreadRadius: animation.value / 2,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            height: 140,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: glowColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Image.asset(imagePath, width: 130, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Game Quiz",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Choose your level and test your gaming knowledge!",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
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
                      themeColor: Colors.green,
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
                      themeColor: Colors.amber,
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
                      themeColor: Colors.pink,
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
