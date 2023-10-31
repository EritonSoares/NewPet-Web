// ignore_for_file: file_names

import 'package:petner_web/models/petSericeHistoryModel.dart';

class PetServiceHistoryData {
  static final PetServiceHistoryData _instance =
      PetServiceHistoryData._internal();

  factory PetServiceHistoryData() {
    return _instance;
  }

  PetServiceHistoryData._internal();

  List<PetServiceHistoryModel> petServiceHistoryList = [];

  List<PetFileListModel> getAnexodByServiceFormId(int serviceFormId) {
    return petServiceHistoryList
        .firstWhere((element) => (element.serviceFormId == serviceFormId))
        .fileList;
  }

/*
  PetServiceHistoryModel getPetTreatmentById(String index) {
    return petServiceHistoryList
        .firstWhere((element) => (element.activityId.toString() == index));
  }


  int getIndexById(String index) {
    return petServiceHistoryList
        .indexWhere((element) => (element.activityId.toString() == index));
  }
*/
}
