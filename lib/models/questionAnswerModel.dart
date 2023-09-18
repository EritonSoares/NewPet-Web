// ignore_for_file: file_names
/*
 "screeningQuestionId": 1,
        "questionAnswerId": 1,
        "description": "ATÉ 30 MIN"
*/

class QuestionAnswerModel {
  final int screeningQuestionId;
  final int questionAnswerId;
  final String description;

  QuestionAnswerModel(
      {required this.screeningQuestionId,
      required this.questionAnswerId,
      required this.description});

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAnswerModel(
      screeningQuestionId: json['screeningQuestionId'],
      questionAnswerId: json['questionAnswerId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screeningQuestionId': screeningQuestionId,
      'questionAnswerId': questionAnswerId,
      'description': description,
    };
  }
}
