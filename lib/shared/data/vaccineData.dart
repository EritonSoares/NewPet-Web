// ignore_for_file: file_names

import 'package:petner_web/models/vaccineModel.dart';

class VaccineData {
  static final VaccineData _instance = VaccineData._internal();

  factory VaccineData() {
    return _instance;
  }

  VaccineData._internal();

  List<VaccineModel> vaccineList = [];

  VaccineModel getVaccineById(String index) {
    return vaccineList
        .firstWhere((element) => (element.vaccineId.toString() == index));
  }

  List<VaccineModel> getVaccineBySpecieId(int specieId) {
    return vaccineList
        .where((element) => (element.specieId == specieId))
        .toList();
  }
}
