// ignore_for_file: file_names

class ScreeningReasonModel {
  final int id;
  final String description;

  ScreeningReasonModel({required this.id, required this.description});

  factory ScreeningReasonModel.fromJson(Map<String, dynamic> json) {
    return ScreeningReasonModel(
      id: json['screeningReasonId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }
}
