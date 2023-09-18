// ignore_for_file: file_names

import 'package:petner_web/models/petVaccineCardModel.dart';

class PetVaccineData {
  static final PetVaccineData _instance = PetVaccineData._internal();

  factory PetVaccineData() {
    return _instance;
  }

  PetVaccineData._internal();

  List<PetVaccineCardModel> petVaccineList = [];

  List<PetVaccinationCardModel> getVaccinationCardByVaccineId(String index) {
    return petVaccineList.firstWhere((element) => (element.petVaccineId.toString() == index)).vaccineList;
  }

  PetVaccinationCardModel getVaccinationCardByVaccinationCardId(String petVaccineId, String vaccinationCardId) {
    return petVaccineList.firstWhere((element) => (element.petVaccineId.toString() == petVaccineId)).vaccineList.firstWhere((element) => (element.vaccinationCardId.toString() == vaccinationCardId));
  }

  PetVaccineCardModel getVaccineCardById(String index) {
    return petVaccineList.firstWhere((element) => (element.petVaccineId.toString() == index));
  }

  addVaccinationCardByVaccineId(String index, PetVaccinationCardModel vaccinationCard) {
    petVaccineList.firstWhere((element) => (element.petVaccineId.toString() == index)).vaccineList.add(vaccinationCard);
  }
}
