// ignore_for_file: file_names

import 'package:petner_web/models/petShceduleTreatmentModel.dart';

class PetScheduleTreatmentData {
  static final PetScheduleTreatmentData _instance =
      PetScheduleTreatmentData._internal();

  factory PetScheduleTreatmentData() {
    return _instance;
  }

  PetScheduleTreatmentData._internal();

  List<PetScheduleTreatmentModel> petScheduleTreatmentList = [];

  List<PetScheduleTreatmentListModel> getShceduleTreatmentByTreatmentId(
      String index) {
    return petScheduleTreatmentList
        .firstWhere((element) => (element.treatmentId.toString() == index))
        .scheduleTreatment;
  }
}
