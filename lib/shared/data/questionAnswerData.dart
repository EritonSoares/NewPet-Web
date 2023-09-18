// ignore_for_file: file_names

import '../../models/questionAnswerModel.dart';

class QuestionAnswerData {
  static final QuestionAnswerData _instance = QuestionAnswerData._internal();

  factory QuestionAnswerData() {
    return _instance;
  }

  QuestionAnswerData._internal();

  List<QuestionAnswerModel> questionAnswerList = [];

  List<QuestionAnswerModel> getQuestionAnswersId(int index) {
    return questionAnswerList
        .where((element) => (element.screeningQuestionId == index))
        .toList();
  }
}
