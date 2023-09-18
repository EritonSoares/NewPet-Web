// ignore_for_file: file_names

import 'package:petner_web/models/speciedModel.dart';

class SpecieData {
  static final SpecieData _instance = SpecieData._internal();

  factory SpecieData() {
    return _instance;
  }

  SpecieData._internal();

  List<SpecieModel> specieList = [];

  SpecieModel getSpecieById(String index) {
    return specieList.firstWhere((element) => (element.id == index));
  }
}
