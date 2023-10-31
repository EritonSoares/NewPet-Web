// ignore_for_file: file_names

import 'package:petner_web/models/petSymptomModel.dart';

class PetSymptomData {
  static final PetSymptomData _instance = PetSymptomData._internal();

  factory PetSymptomData() {
    return _instance;
  }

  PetSymptomData._internal();

  List<PetSymptomModel> petSymptomList = [];

  PetSymptomModel getSymptomById(String index) {
    return petSymptomList
        .firstWhere((element) => (element.petSymptomId == index));
  }
}
