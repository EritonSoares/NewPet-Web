// ignore_for_file: file_names

import 'package:petner_web/models/petDiseaseServiceModel.dart';

class PetDiseaseServiceData {
  static final PetDiseaseServiceData _instance =
      PetDiseaseServiceData._internal();

  factory PetDiseaseServiceData() {
    return _instance;
  }

  PetDiseaseServiceData._internal();

  List<PetDiseaseServiceModel> petDiseaseServiceList = [];

  PetDiseaseServiceModel getSymptomById(String index) {
    return petDiseaseServiceList
        .firstWhere((element) => (element.petDiseaseServiceId == index));
  }
}
