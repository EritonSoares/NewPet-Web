// ignore_for_file: file_names

import 'package:petner_web/models/petShceduleActivityModel.dart';

class PetScheduleActivityData {
  static final PetScheduleActivityData _instance =
      PetScheduleActivityData._internal();

  factory PetScheduleActivityData() {
    return _instance;
  }

  PetScheduleActivityData._internal();

  List<PetScheduleActivityModel> petScheduleTreatmentList = [];

  List<PetScheduleActivityListModel> getShceduleTreatmentByTreatmentId(
      String index) {
    return petScheduleTreatmentList
        .firstWhere((element) => (element.activityId.toString() == index))
        .scheduleActivity;
  }
}
