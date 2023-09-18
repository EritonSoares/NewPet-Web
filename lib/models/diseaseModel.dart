// ignore_for_file: file_names

class DiseaseModel {
  late final String id;
  late final String specieId;
  late final String name;

  DiseaseModel({required this.id, required this.specieId, required this.name});

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['id'],
      specieId: json['specieId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specieId': specieId,
      'name': name,
    };
  }
}
