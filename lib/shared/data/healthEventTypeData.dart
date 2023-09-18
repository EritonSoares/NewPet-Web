// ignore_for_: _names

// ignore_for_file: file_names

import '../../models/healthEventTypeModel.dart';

class HealthEventTypeData {
  static final HealthEventTypeData _instance = HealthEventTypeData._internal();

  factory HealthEventTypeData() {
    return _instance;
  }

  HealthEventTypeData._internal();

  List<HealthEventTypeModel> healthEventTypeList = [];
}
