import 'package:flutter/material.dart';

class EasyQuizScreen extends StatefulWidget {
  final String difficulty;
  const EasyQuizScreen({super.key, required this.difficulty});

  @override
  State<EasyQuizScreen> createState() => _EasyQuizScreenState();
}

class _EasyQuizScreenState extends State<EasyQuizScreen> {
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg4.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ALL THE BEST",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                //  Question number
                const Text(
                  "1/10",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                //  Question Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blueAccent.withOpacity(0.7),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: const Text(
                    "This is where the question will appear.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                const SizedBox(height: 30),

                // 🟦 Option Boxes
                Column(
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 15),
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOption == index
                                  ? const Color.fromARGB(255, 43, 110, 78)
                                  : const Color.fromARGB(77, 174, 67, 67),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: selectedOption == index
                                    ? Colors.greenAccent.withOpacity(0.6)
                                    : Colors.transparent,
                                blurRadius: 16,
                                spreadRadius: 5,
                              ),
                            ],
                            color: Colors.grey[900],
                          ),
                          child: Text(
                            "Option ${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
