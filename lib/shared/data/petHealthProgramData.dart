// ignore_for_file: file_names

import 'package:petner_web/models/petHealthProgramModel.dart';

class PetHealthProgramData {
  static final PetHealthProgramData _instance =
      PetHealthProgramData._internal();

  factory PetHealthProgramData() {
    return _instance;
  }

  PetHealthProgramData._internal();

  List<PetHealthProgramModel> petHealthProgramList = [];

  PetHealthProgramModel getPetHealthProgramById(String index) {
    return petHealthProgramList
        .firstWhere((element) => (element.petHealthProgramId == index));
  }
}
