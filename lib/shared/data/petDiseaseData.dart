// ignore_for_file: file_names

import 'package:petner_web/models/petDiseaseModel.dart';

class PetDiseaseData {
  static final PetDiseaseData _instance = PetDiseaseData._internal();

  factory PetDiseaseData() {
    return _instance;
  }

  PetDiseaseData._internal();

  List<PetDiseaseModel> petDiseaseList = [];

  PetDiseaseModel getDiseaseById(String index) {
    return petDiseaseList.firstWhere((element) => (element.petDiseaseId == index));
  }

  PetDiseaseModel getDiseaseByChronic() {
    return petDiseaseList.firstWhere((element) => (element.chronic == true));
  }
}
