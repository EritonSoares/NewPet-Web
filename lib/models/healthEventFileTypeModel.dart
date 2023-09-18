// ignore_for_file: file_names
class HealthEventFileTypeModel {
  final int healthEventTypeId;
  final int fileTypeId;
  final String description;

  HealthEventFileTypeModel(
      {required this.healthEventTypeId,
      required this.fileTypeId,
      required this.description});

  factory HealthEventFileTypeModel.fromJson(Map<String, dynamic> json) {
    return HealthEventFileTypeModel(
      healthEventTypeId: json['healthEventTypeId'],
      fileTypeId: json['fileTypeId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthEventTypeId': healthEventTypeId,
      'fileTypeId': fileTypeId,
      'description': description,
    };
  }
}
