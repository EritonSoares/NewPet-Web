// ignore_for_file: file_names

import 'package:petner_web/models/petModel.dart';

class PetData {
  static final PetData _instance = PetData._internal();

  factory PetData() {
    return _instance;
  }

  PetData._internal();

  List<PetModel> petList = [];

  PetModel getPetById(String index) {
    return petList.firstWhere((element) => (element.id.toString() == index));
  }

  int getIndexById(String index) {
    return petList.indexWhere((element) => (element.id.toString() == index));
  }
}
