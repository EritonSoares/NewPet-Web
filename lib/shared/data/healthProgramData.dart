// ignore_for_file: file_names

import 'package:petner_web/models/healthProgramModel.dart';

class HealthProgramData {
  static final HealthProgramData _instance = HealthProgramData._internal();

  factory HealthProgramData() {
    return _instance;
  }

  HealthProgramData._internal();

  List<HealthProgramModel> healthProgramList = [];

  HealthProgramModel getHealthProgramById(String index) {
    return healthProgramList
        .firstWhere((element) => (element.healthProgramId == index));
  }

  List<HealthProgramModel> getHealthProgramBySpecieId(int index) {
    return healthProgramList
        .where((element) => (element.specieId == index))
        .toList();
  }
}
