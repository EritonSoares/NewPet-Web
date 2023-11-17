// ignore_for_file: file_names

import 'package:petner_web/models/petVaccineDoseModel.dart';

class PetVaccineDoseData {
  static final PetVaccineDoseData _instance = PetVaccineDoseData._internal();

  factory PetVaccineDoseData() {
    return _instance;
  }

  PetVaccineDoseData._internal();

  List<PetVaccineDoseModel> petVaccineDoseList = [];

  PetVaccineDoseModel getPetVaccineDoseById(String index) {
    return petVaccineDoseList.firstWhere(
        (element) => (element.petVaccineDoseId.toString() == index));
  }

  removePetVaccineDoseById(String index) {
    petVaccineDoseList.removeWhere(
        (element) => (element.petVaccineDoseId.toString() == index));
  }
}
