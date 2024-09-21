// ignore_for_file: non_constant_identifier_names

class AnswerModel {
  final String? answer_a;
  final String? answer_b;
  final String? answer_c;
  final String? answer_d;
  final String? answer_e;
  final String? answer_f;
  AnswerModel({
    this.answer_a,
    this.answer_b,
    this.answer_c,
    this.answer_d,
    this.answer_e,
    this.answer_f,
  });
  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      answer_a: json['answer_a']?.toString(),
      answer_b: json['answer_b']?.toString(),
      answer_c: json['answer_c']?.toString(),
      answer_d: json['answer_d']?.toString(),
      answer_e: json['answer_e']?.toString(),
      answer_f: json['answer_f']?.toString(),
    );
  }
}
