class QuizQuestion {
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;

  QuizQuestion({
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final List<String> answers = List<String>.from(json['incorrect_answers']);
    answers.add(json['correct_answer']);
    answers.shuffle(); // mix the options randomly

    return QuizQuestion(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      allAnswers: answers,
    );
  }
}
