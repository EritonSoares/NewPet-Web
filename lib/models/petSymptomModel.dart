// ignore_for_file: file_names

class PetSymptomModel {
  late final int? petSymptomId;
  late final String? name;

  PetSymptomModel({
    required this.petSymptomId,
    required this.name,
  });

  factory PetSymptomModel.fromJson(Map<String, dynamic> json) {
    return PetSymptomModel(
      petSymptomId: json['petSymptomId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petSymptomId': petSymptomId,
      'name': name,
    };
  }
}
