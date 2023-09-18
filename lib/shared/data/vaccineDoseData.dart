// ignore_for_file: file_names

import 'package:petner_web/models/vaccineDoseModel.dart';

class VaccineDoseData {
  static final VaccineDoseData _instance = VaccineDoseData._internal();

  factory VaccineDoseData() {
    return _instance;
  }

  VaccineDoseData._internal();

  List<VaccineDoseModel> vaccineDoseList = [];

  VaccineDoseModel getVaccineDoseById(String index) {
    return vaccineDoseList.firstWhere((element) => (element.vaccineDoseId.toString() == index));
  }

  removeVaccineDoseById(String index) {
    vaccineDoseList.removeWhere((element) => (element.vaccineDoseId.toString() == index));
  }
}
