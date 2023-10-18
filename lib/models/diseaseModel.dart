// ignore_for_file: file_names

class DiseaseModel {
  late final String id;
  late final String name;
  late final int specieId;
  late final bool chronic;

  DiseaseModel(
      {required this.id,
      required this.name,
      required this.specieId,
      required this.chronic});

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['id'],
      name: json['name'],
      specieId: json['specieId'],
      chronic: json['chronic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specieId': specieId,
      'chronic': chronic,
    };
  }
}
