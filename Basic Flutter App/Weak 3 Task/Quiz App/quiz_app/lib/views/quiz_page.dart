// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quiz_app/models/category_model.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/services/get_quiz.dart';
import 'package:quiz_app/views/score_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<QuestionModel>? quizData;
  int currentQuestionIndex = 0;
  List<String?> selectedAnswers =
      []; // List to store selected answers for each question
  List<bool> hasAnsweredList =
      []; // List to track if a question has been answered
  bool isAnswerCorrect = false;
  int score = 0; // Variable to keep track of the score
  List<int> scores = []; // List to store score for each question
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuizData(category: widget.category.categoryName);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchQuizData({required String category}) async {
    GetQuizService quizService = GetQuizService();
    List<QuestionModel> data =
        await quizService.getQuizService(category: category);

    setState(() {
      quizData = data;
      selectedAnswers = List<String?>.filled(
          data.length, null); // Initialize with null answers
      hasAnsweredList = List<bool>.filled(
          data.length, false); // Initialize with false (not answered)
      scores =
          List<int>.filled(data.length, 0); // Initialize scores list with zeros
    });
  }

  void checkAnswer(String selectedOption) {
    if (!hasAnsweredList[currentQuestionIndex]) {
      // Allow answering only once per question
      String correctAnswerKey =
          quizData![currentQuestionIndex].correctAnswer.toString();

      setState(() {
        selectedAnswers[currentQuestionIndex] =
            selectedOption; // Store the selected answer
        isAnswerCorrect =
            (selectedOption == getAnswerTextByKey(correctAnswerKey));
        hasAnsweredList[currentQuestionIndex] =
            true; // Mark the question as answered

        // Increment score if the answer is correct
        if (isAnswerCorrect) {
          score++;
          scores[currentQuestionIndex] =
              1; // Assign 1 point to the current question
        } else {
          scores[currentQuestionIndex] = 0; // Assign 0 if the answer is wrong
        }
      });
    }
  }

  String? getAnswerTextByKey(String key) {
    var answers = quizData![currentQuestionIndex].answers;
    switch (key) {
      case 'answer_a':
        return answers.answer_a;
      case 'answer_b':
        return answers.answer_b;
      case 'answer_c':
        return answers.answer_c;
      case 'answer_d':
        return answers.answer_d;
      case 'answer_e':
        return answers.answer_e;
      case 'answer_f':
        return answers.answer_f;
      default:
        return null;
    }
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < quizData!.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswerCorrect = false;
      });
    } else {
      // Navigate to score page when the quiz ends
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ScorePage(score: score, totalQuestions: quizData!.length),
        ),
      );
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        isAnswerCorrect = false;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz for ${widget.category.categoryName}'),
      ),
      body: quizData == null
          ? const Center(child: CircularProgressIndicator())
          : Skeletonizer(
            enabled: isLoading,
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      quizData![currentQuestionIndex].question,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        buildAnswerOption('A',
                            quizData![currentQuestionIndex].answers.answer_a),
                        buildAnswerOption('B',
                            quizData![currentQuestionIndex].answers.answer_b),
                        buildAnswerOption('C',
                            quizData![currentQuestionIndex].answers.answer_c),
                        buildAnswerOption('D',
                            quizData![currentQuestionIndex].answers.answer_d),
                      ],
                    ),
                  ),
                  Text(
                    hasAnsweredList[currentQuestionIndex]
                        ? (isAnswerCorrect
                            ? 'Correct! (1 point)'
                            : 'Wrong answer (0 points)')
                        : 'Choose your answer',
                    style: TextStyle(
                      color: hasAnsweredList[currentQuestionIndex]
                          ? (isAnswerCorrect ? Colors.green : Colors.red)
                          : Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: goToPreviousQuestion,
                        child: const Text('Previous Question'),
                      ),
                      ElevatedButton(
                        onPressed: goToNextQuestion,
                        child: Text(currentQuestionIndex == quizData!.length - 1
                            ? 'Finish Quiz'
                            : 'Next Question'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Display score for each question
                  Text(
                    'Score for this question: ${scores[currentQuestionIndex]} / 1',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ),
    );
  }

  Widget buildAnswerOption(String optionLabel, String? answerText) {
    if (answerText == null) {
      return Container(); // Skip if the option is null
    }
    return ListTile(
      title: Text("$optionLabel: $answerText"),
      leading: Radio<String>(
        value: answerText,
        groupValue: selectedAnswers[
            currentQuestionIndex], // Use stored answer for the current question
        onChanged: hasAnsweredList[currentQuestionIndex]
            ? null
            : (value) {
                // Disable changing answer if already answered
                checkAnswer(value!);
              },
      ),
    );
  }
}
