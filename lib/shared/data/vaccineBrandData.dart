// ignore_for_file: file_names

import 'package:petner_web/models/vaccineBrandModel.dart';

class VaccineBrandData {
  static final VaccineBrandData _instance = VaccineBrandData._internal();

  factory VaccineBrandData() {
    return _instance;
  }

  VaccineBrandData._internal();

  List<VaccineBrandModel> vaccineBrandList = [];

  VaccineBrandModel getVaccineBrandById(String index) {
    return vaccineBrandList.firstWhere((element) => (element.brandId.toString() == index));
  }

  List<VaccineBrandModel> getVaccineBrandByVaccineId(String index) {
    return vaccineBrandList.where((element) => (element.brandId.toString() == index)).toList();
  }
}
