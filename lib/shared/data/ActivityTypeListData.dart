// ignore_for_file: file_names

import 'package:petner_web/models/ActivityTypeModel.dart';

class ActivityTypeListData {
  static final ActivityTypeListData _instance = ActivityTypeListData._internal();

  factory ActivityTypeListData() {
    return _instance;
  }

  ActivityTypeListData._internal();

  List<ActivityTypeModel> activityTypeList = [];
}
