// ignore_for_file: file_names

import 'package:petner_web/models/petTreatmentModel.dart';

class PetTreatmentData {
  static final PetTreatmentData _instance = PetTreatmentData._internal();

  factory PetTreatmentData() {
    return _instance;
  }

  PetTreatmentData._internal();

  List<PetTreatmentModel> petTreatmentList = [];

  PetTreatmentModel getPetTreatmentById(String index) {
    return petTreatmentList.firstWhere((element) => (element.treatmentId.toString() == index));
  }

  int getIndexById(String index) {
    return petTreatmentList.indexWhere((element) => (element.treatmentId.toString() == index));
  }
}
