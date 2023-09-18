// ignore_for_file: file_names

import 'package:petner_web/models/cityModel.dart';

class CityData {
  static final CityData _instance = CityData._internal();

  factory CityData() {
    return _instance;
  }

  CityData._internal();

  List<CityModel> cityList = [];

  CityModel getCityById(String index) {
    return cityList.firstWhere((element) => (element.id.toString() == index));
  }

  int getIndexById(String index) {
    return cityList.indexWhere((element) => (element.id.toString() == index));
  }
}
