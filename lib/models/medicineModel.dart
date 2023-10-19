// ignore_for_file: file_names

class MedicineModel {
  late final String id;
  late final String name;
  late final int specieId;
  late final bool veterinaryUse;

  MedicineModel({
    required this.id,
    required this.name,
    required this.specieId,
    required this.veterinaryUse,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      name: json['name'],
      specieId: json['specieId'],
      veterinaryUse: json['veterinaryUse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specieId': specieId,
      'veterinaryUse': veterinaryUse,
    };
  }
}
