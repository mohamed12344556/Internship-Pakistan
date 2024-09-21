// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class CorrectAnswerModel {
  final bool answer_a_correct;
  final bool answer_b_correct;
  final bool answer_c_correct;
  final bool answer_d_correct;
  final bool answer_e_correct;
  final bool answer_f_correct;
  CorrectAnswerModel({
    required this.answer_a_correct,
    required this.answer_b_correct,
    required this.answer_c_correct,
    required this.answer_d_correct,
    required this.answer_e_correct,
    required this.answer_f_correct,
  });
  factory CorrectAnswerModel.fromJson(json) {
    return CorrectAnswerModel(
      answer_a_correct: json['answer_a_correct'].toString() == 'true' ? true : false,
      answer_b_correct: json['answer_b_correct'].toString() == 'true' ? true : false,
      answer_c_correct: json['answer_c_correct'].toString() == 'true' ? true : false,
      answer_d_correct: json['answer_d_correct'].toString() == 'true' ? true : false,
      answer_e_correct: json['answer_e_correct'].toString() == 'true' ? true : false,
      answer_f_correct: json['answer_f_correct'].toString() == 'true' ? true : false,
    );
  }
}