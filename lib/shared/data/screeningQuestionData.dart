// ignore_for_file: file_names

import 'package:petner_web/models/raceModel.dart';
import 'package:petner_web/models/screeningQuestionListModel.dart';

class ScreeningQuestionData {
  static final ScreeningQuestionData _instance =
      ScreeningQuestionData._internal();

  factory ScreeningQuestionData() {
    return _instance;
  }

  ScreeningQuestionData._internal();

  List<ScreeningQuestionModel> screeningQuestionList = [];

  List<ScreeningQuestionModel> getQuestionsByScreeningReasonId(int index) {
    return screeningQuestionList
        .where((element) => (element.screeningReasonId == index))
        .toList();
  }
}
