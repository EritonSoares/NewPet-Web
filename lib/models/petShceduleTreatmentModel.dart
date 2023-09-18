// ignore_for_file: file_names

class PetScheduleTreatmentModel {
  late final int treatmentId;
  late final String date;
  late final List<PetScheduleTreatmentListModel> scheduleTreatment;

  PetScheduleTreatmentModel({
    required this.treatmentId,
    required this.date,
    required this.scheduleTreatment,
  });

  factory PetScheduleTreatmentModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> scheduleTreatmentJson = json['scheduleTreatment'];
    List<PetScheduleTreatmentListModel> scheduleTreatment = scheduleTreatmentJson.map((scheduleJson) => PetScheduleTreatmentListModel.fromJson(scheduleJson)).toList();

    return PetScheduleTreatmentModel(
      treatmentId: json['treatmentId'],
      date: json['date'],
      scheduleTreatment: scheduleTreatment,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> scheduleTreatmentJson = scheduleTreatment.map((schedule) => schedule.toJson()).toList();

    return {'treatmentId': treatmentId, 'date': date, 'scheduleTreatment': scheduleTreatmentJson};
  }
}

class PetScheduleTreatmentListModel {
  late final int scheduleId;
  late final String timeTable;
  late final bool performed;
  late final bool expired;
  PetScheduleTreatmentListModel({
    required this.scheduleId,
    required this.timeTable,
    required this.performed,
    required this.expired,
  });

  void setPerformed(bool xperformed) {
    performed = xperformed;
  }

  factory PetScheduleTreatmentListModel.fromJson(Map<String, dynamic> json) {
    return PetScheduleTreatmentListModel(
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
