import 'package:flutter/material.dart';

class EasyQuizScreen extends StatefulWidget {
  final String difficulty;
  final int questionIndex;

  const EasyQuizScreen({
    super.key,
    required this.difficulty,
    this.questionIndex = 1,
  });

  @override
  State<EasyQuizScreen> createState() => _EasyQuizScreenState();
}

class _EasyQuizScreenState extends State<EasyQuizScreen> {
  int selectedOption = -1;
  int timeLeft = 20;
  int totalQuestions = 10;
  late int currentQuestion;

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.questionIndex;
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
        startTimer();
      } else {
        goToNextQuestion();

        // Time's up, handle accordingly
      }
    });
  }

  void goToNextQuestion() {
    if (currentQuestion < totalQuestions) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => EasyQuizScreen(
            difficulty: widget.difficulty,
            questionIndex: currentQuestion + 1,
          ),
        ),
      );
    } else {
      //  After last question → show finish screen or message
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Quiz Finished!"),
          content: const Text(
            "You’ve completed all 10 questions in Easy level.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🟩 EASY LEVEL TITLE
                Text(
                  "${widget.difficulty.toUpperCase()} ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // 🟩 QUIZ PROGRESS + TIMER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circle showing quiz number
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 45, 4, 60),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              181,
                              32,
                              235,
                            ).withOpacity(0.6),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        color: const Color.fromARGB(
                          255,
                          52,
                          34,
                          123,
                        ).withOpacity(0.4),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "1/10",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 30),

                    // ⏱ TIMER
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white),
                        const SizedBox(width: 5),
                        Text(
                          "$timeLeft sec",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // 🟩 QUESTION BOX
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(
                        255,
                        19,
                        1,
                        26,
                      ).withOpacity(0.7),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          162,
                          33,
                          201,
                        ).withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                    color: const Color.fromARGB(
                      255,
                      82,
                      11,
                      121,
                    ).withOpacity(0.3),
                  ),
                  child: Text(
                    "Question $currentQuestion:"
                    "This is where the question will appear .",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                const SizedBox(height: 30),

                // 🟩 OPTIONS
                Column(
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedOption == index
                                ? const Color.fromARGB(255, 135, 22, 184)
                                : Colors.white30,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: selectedOption == index
                                  ? const Color.fromARGB(
                                      255,
                                      104,
                                      13,
                                      119,
                                    ).withOpacity(0.6)
                                  : const Color.fromARGB(0, 98, 15, 136),
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
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // 🟩 SUBMIT BUTTON
                ElevatedButton(
                  onPressed: selectedOption == -1
                      ? null
                      : () {
                          goToNextQuestion();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 5, 46),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
