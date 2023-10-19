// ignore_for_file: file_names

import 'package:petner_web/models/petAllergyModel.dart';

class PetAllergyData {
  static final PetAllergyData _instance = PetAllergyData._internal();

  factory PetAllergyData() {
    return _instance;
  }

  PetAllergyData._internal();

  List<PetAllergyModel> petAllergyList = [];

  PetAllergyModel getAllergyById(String index) {
    return petAllergyList
        .firstWhere((element) => (element.petAllergyId == index));
  }
}
