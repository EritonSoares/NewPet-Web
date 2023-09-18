// ignore_for_file: file_names

class PetScheduleActivityModel {
  late final int activityId;
  late final String date;
  late final List<PetScheduleActivityListModel> scheduleActivity;

  PetScheduleActivityModel({
    required this.activityId,
    required this.date,
    required this.scheduleActivity,
  });

  factory PetScheduleActivityModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> scheduleActivityJson = json['scheduleActivity'];
    List<PetScheduleActivityListModel> scheduleActivity = scheduleActivityJson
        .map((scheduleJson) =>
            PetScheduleActivityListModel.fromJson(scheduleJson))
        .toList();

    return PetScheduleActivityModel(
      activityId: json['activityId'],
      date: json['date'],
      scheduleActivity: scheduleActivity,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> scheduleActivityJson =
        scheduleActivity.map((schedule) => schedule.toJson()).toList();

    return {
      'activityId': activityId,
      'date': date,
      'scheduleActivity': scheduleActivityJson
    };
  }
}

class PetScheduleActivityListModel {
  late final int scheduleId;
  late final String timeTable;
  late final bool performed;
  late final bool expired;
  PetScheduleActivityListModel({
    required this.scheduleId,
    required this.timeTable,
    required this.performed,
    required this.expired,
  });

  void setPerformed(bool xperformed) {
    performed = xperformed;
  }

  factory PetScheduleActivityListModel.fromJson(Map<String, dynamic> json) {
    return PetScheduleActivityListModel(
      scheduleId: json['scheduleId'],
      timeTable: json['timeTable'],
      performed: json['performed'],
      expired: json['expired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduleId': scheduleId,
      'timeTable': timeTable,
      'performed': performed,
      'expired': expired,
    };
  }
}
