// ignore_for_file: file_names

import 'package:petner_web/models/examModel.dart';

class ExamData{
  static final ExamData _instance = ExamData._internal();

  factory ExamData() {
    return _instance;
  }

  ExamData._internal();

  List<ExamModel> examList = [];

  ExamModel getExamById(int index) {
    return examList.firstWhere((element) => (element.id == index));
  }
}
