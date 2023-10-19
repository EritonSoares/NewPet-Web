// ignore_for_file: file_names

import 'package:petner_web/models/medicineModel.dart';

class MedicineData {
  static final MedicineData _instance = MedicineData._internal();

  factory MedicineData() {
    return _instance;
  }

  MedicineData._internal();

  List<MedicineModel> medicineList = [];

  MedicineModel getMedicineById(String index) {
    return medicineList.firstWhere((element) => (element.id == index));
  }
}
