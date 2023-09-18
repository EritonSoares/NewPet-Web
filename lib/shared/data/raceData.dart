// ignore_for_file: file_names

import 'package:petner_web/models/raceModel.dart';

class RaceData {
  static final RaceData _instance = RaceData._internal();

  factory RaceData() {
    return _instance;
  }

  RaceData._internal();

  List<RaceModel> raceList = [];

  RaceModel getRaceById(String index) {
    return raceList.firstWhere((element) => (element.id == index));
  }
}
