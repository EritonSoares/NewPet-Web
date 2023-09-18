// ignore_for_file: file_names

class RaceModel {
  late final String id;
  late final String specieId;
  late final String name;

  RaceModel({required this.id,required this.specieId,  required this.name});

  factory RaceModel.fromJson(Map<String, dynamic> json) {
    return RaceModel(
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