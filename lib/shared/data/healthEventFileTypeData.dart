// ignore_for_file: file_names

import '../../models/healthEventFileTypeModel.dart';

class HealthEventFileTypeData {
  static final HealthEventFileTypeData _instance =
      HealthEventFileTypeData._internal();

  factory HealthEventFileTypeData() {
    return _instance;
  }

  HealthEventFileTypeData._internal();

  List<HealthEventFileTypeModel> healthEventFileTypeList = [];
}
