// ignore_for_file: file_names

class CoatModel {
  late final String id;
  late final String specieId;
  late final String name;

  CoatModel({required this.id,required this.specieId,  required this.name});

  factory CoatModel.fromJson(Map<String, dynamic> json) {
    return CoatModel(
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