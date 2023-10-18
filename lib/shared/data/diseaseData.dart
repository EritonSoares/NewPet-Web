// ignore_for_file: file_names

import 'package:petner_web/models/diseaseModel.dart';

class DiseaseData {
  static final DiseaseData _instance = DiseaseData._internal();

  factory DiseaseData() {
    return _instance;
  }

  DiseaseData._internal();

  List<DiseaseModel> diseaseList = [];

  DiseaseModel getDiseaseById(String index) {
    return diseaseList.firstWhere((element) => (element.id == index));
  }
}
