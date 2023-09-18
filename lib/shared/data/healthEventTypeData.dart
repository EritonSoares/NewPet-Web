// ignore_for_: _names

import '../../models/healthEventTypeModel.dart';

class HealthEventTypeData {
  static final HealthEventTypeData _instance = HealthEventTypeData._internal();

  factory HealthEventTypeData() {
    return _instance;
  }

  HealthEventTypeData._internal();

  List<HealthEventTypeModel> healthEventTypeList = [];
}
