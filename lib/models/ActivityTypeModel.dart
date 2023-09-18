// ignore_for_file: file_names

class ActivityTypeModel {
  String activityTypeId;
  String description;
  ActivityTypeModel({
    required this.activityTypeId,
    required this.description,
  });

  factory ActivityTypeModel.fromJson(Map<String, dynamic> json) {
    return ActivityTypeModel(
      activityTypeId: json['activityTypeId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityTypeId': activityTypeId,
      'description': description,
    };
  }
}
