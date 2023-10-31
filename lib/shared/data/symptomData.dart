// ignore_for_file: file_names

import 'package:petner_web/models/symptomModel.dart';

class SymptomData {
  static final SymptomData _instance = SymptomData._internal();

  factory SymptomData() {
    return _instance;
  }

  SymptomData._internal();

  List<SymptomModel> symptomList = [];

  SymptomModel getSymptomById(String index) {
    return symptomList.firstWhere((element) => (element.id == index));
  }
}
