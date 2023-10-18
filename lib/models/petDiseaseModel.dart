// ignore_for_file: file_names

class PetDiseaseModel {
  late final int? petDiseaseId;
  late final String? name;
  late final bool? chronic;

  PetDiseaseModel(
      {required this.petDiseaseId,
      required this.name,
      required this.chronic});

  factory PetDiseaseModel.fromJson(Map<String, dynamic> json) {
    return PetDiseaseModel(
      petDiseaseId: json['petDiseaseId'],
      name: json['name'],
      chronic: json['chronic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petDiseaseId': petDiseaseId,
      'name': name,
      'chronic': chronic,
    };
  }
}
