// ignore_for_file: file_names

import '../../models/petActivityModel.dart';

class PetActivityData {
  static final PetActivityData _instance = PetActivityData._internal();

  factory PetActivityData() {
    return _instance;
  }

  PetActivityData._internal();

  List<PetActivityModel> petActivityList = [];

  /*PetActivityModel getPetTreatmentById(String index) {
    return petActivityList
        .firstWhere((element) => (element.activityId.toString() == index));
  }

  int getIndexById(String index) {
    return petActivityList
        .indexWhere((element) => (element.activityId.toString() == index));
  }*/
}
