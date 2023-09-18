// ignore_for_file: file_names

import '../../models/screeningReasonmodel.dart';

class ScreeningReasonData {
  static final ScreeningReasonData _instance = ScreeningReasonData._internal();

  factory ScreeningReasonData() {
    return _instance;
  }

  ScreeningReasonData._internal();

  List<ScreeningReasonModel> screeningReasonList = [];

  getScreeningReasonId(String index) {
    return screeningReasonList.firstWhere((element) => (element.id == index));
  }
}
