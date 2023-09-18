// ignore_for_file: file_names
class HealthEventTypeModel {
  final int healthEventTypeId;
  final String description;

  HealthEventTypeModel(
      {required this.healthEventTypeId, required this.description});

  factory HealthEventTypeModel.fromJson(Map<String, dynamic> json) {
    return HealthEventTypeModel(
      healthEventTypeId: json['healthEventTypeId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthEventTypeId': healthEventTypeId,
      'description': description,
    };
  }
}
