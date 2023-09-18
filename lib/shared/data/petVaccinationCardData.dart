// ignore_for_file: file_names

import 'package:petner_web/models/petVaccineCardModel.dart';

class PetVaccinationCardData {
  static final PetVaccinationCardData _instance = PetVaccinationCardData._internal();

  factory PetVaccinationCardData() {
    return _instance;
  }

  PetVaccinationCardData._internal();

  List<PetVaccinationCardModel> petVaccinationCardList = [];

  removeVaccinationCardByDoseId(String index) {
    petVaccinationCardList.removeWhere((element) => (element.vaccinationCardId.toString() == index));
  }
}
