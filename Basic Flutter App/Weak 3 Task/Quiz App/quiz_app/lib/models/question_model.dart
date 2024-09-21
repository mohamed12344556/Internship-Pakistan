import 'package:quiz_app/models/answer_model.dart';
import 'package:quiz_app/models/correct_answer_model.dart';

class QuestionModel {
  final int id;
  final String question;
  final String? description;
  final AnswerModel answers;
  final bool multipleCorrectAnswers;
  final CorrectAnswerModel correctAnswers;
  final String? correctAnswer;
  final String category;
  QuestionModel({
    required this.id,
    required this.question,
    this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    required this.correctAnswer,
    required this.category,
  });

  factory QuestionModel.fromJson(json) {
    return QuestionModel(
        id: json['id'],
        question: json['question'],
        description: json['description'],
        answers: AnswerModel.fromJson(json['answers']),
        multipleCorrectAnswers: json['multiple_correct_answers'].toString() == 'true' ? true : false,
        correctAnswers: CorrectAnswerModel.fromJson(json['correct_answers']),
        correctAnswer: json['correct_answer']?.toString(),
        category: json['category']);
  }
}
