// ignore_for_file: file_names
/*
"screeningReasonId": 1,
        "screeningQuestionId": 1,
        "description": "HÁ QUANTO TEMPO OCORREU"
*/

class ScreeningQuestionModel {
  final int screeningReasonId;
  final int screeningQuestionId;
  final String description;

  ScreeningQuestionModel(
      {required this.screeningReasonId,
      required this.screeningQuestionId,
      required this.description});

  factory ScreeningQuestionModel.fromJson(Map<String, dynamic> json) {
    return ScreeningQuestionModel(
      screeningReasonId: json['screeningReasonId'],
      screeningQuestionId: json['screeningQuestionId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screeningReasonId': screeningReasonId,
      'screeningQuestionId': screeningQuestionId,
      'description': description,
    };
  }
}
