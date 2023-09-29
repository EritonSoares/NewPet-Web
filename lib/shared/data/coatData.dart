// ignore_for_file: file_names

import 'package:petner_web/models/coatModel.dart';

class CoatData {
  static final CoatData _instance = CoatData._internal();

  factory CoatData() {
    return _instance;
  }

  CoatData._internal();

  List<CoatModel> coatList = [];

  CoatModel getCoatById(String index) {
    return coatList.firstWhere((element) => (element.id == index));
  }
}
