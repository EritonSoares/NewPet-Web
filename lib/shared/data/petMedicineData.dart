// ignore_for_file: file_names

import 'package:petner_web/models/petMedicineModel.dart';

class PetMedicineData {
  static final PetMedicineData _instance = PetMedicineData._internal();

  factory PetMedicineData() {
    return _instance;
  }

  PetMedicineData._internal();

  List<PetMedicineModel> petMedicineList = [];

  PetMedicineModel getMedicineById(String index) {
    return petMedicineList
        .firstWhere((element) => (element.petMedicineId == index));
  }
}
