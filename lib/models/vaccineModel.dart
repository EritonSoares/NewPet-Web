// ignore_for_file: file_names

class VaccineModel {
  late final int vaccineId;
  late final String name;
  late final int specieId;

  VaccineModel({
    required this.vaccineId,
    required this.name,
    required this.specieId,
  });

  factory VaccineModel.fromJson(Map<String, dynamic> json) {
    return VaccineModel(
      vaccineId: json['vaccineId'],
      name: json['name'],
      specieId: json['specieId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccineId': vaccineId,
      'name': name,
      'specieId': specieId,
    };
  }
}
