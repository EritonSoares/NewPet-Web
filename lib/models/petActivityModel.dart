// ignore_for_file: file_names

class PetActivityModel {
  late final int activityId;
  late final String activityDate;
  late final String? endDate;
  late final int activityTypeId;
  late final String otherType;
  late final int intervalType;
  late final String timeTable;
  late final int repeatEach;
  late final bool monday;
  late final bool tuesday;
  late final bool wednesday;
  late final bool thursday;
  late final bool friday;
  late final bool saturday;
  late final bool sunday;
  late final bool neverEnds;
  late final bool sendNotice;
  late final bool repeatDayOfMonth;
  late final bool repeatDayOfWeek;
  late final String activityTypeName;

  PetActivityModel(
      {required this.activityId,
      required this.activityDate,
      required this.endDate,
      required this.activityTypeId,
      required this.otherType,
      required this.intervalType,
      required this.timeTable,
      required this.repeatEach,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday,
      required this.neverEnds,
      required this.sendNotice,
      required this.repeatDayOfMonth,
      required this.repeatDayOfWeek,
      required this.activityTypeName});

  factory PetActivityModel.fromJson(Map<String, dynamic> json) {
    return PetActivityModel(
      activityId: json['activityId'],
      activityDate: json['activityDate'],
      endDate: json['endDate'],
      activityTypeId: json['activityTypeId'],
      otherType: json['otherType'],
      intervalType: json['intervalType'],
      timeTable: json['timeTable'],
      repeatEach: json['repeatEach'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
      sunday: json['sunday'],
      neverEnds: json['neverEnds'],
      sendNotice: json['sendNotice'],
      repeatDayOfMonth: json['repeatDayOfMonth'],
      repeatDayOfWeek: json['repeatDayOfWeek'],
      activityTypeName: json['activityTypeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'activityDate': activityDate,
      'endDate': endDate,
      'activityTypeId': activityTypeId,
      'otherType': otherType,
      'intervalType': intervalType,
      'timeTable': timeTable,
      'repeatEach': repeatEach,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
      'neverEnds': neverEnds,
      'sendNotice': sendNotice,
      'repeatDayOfMonth': repeatDayOfMonth,
      'repeatDayOfWeek': repeatDayOfWeek,
      'activityTypeName': activityTypeName,
    };
  }
}
