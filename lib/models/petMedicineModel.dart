// ignore_for_file: file_names

class PetMedicineModel {
  late final int? petMedicineId;
  late final String? name;
  late final bool? veterinaryUse;

  PetMedicineModel(
      {required this.petMedicineId,
      required this.name,
      required this.veterinaryUse});

  factory PetMedicineModel.fromJson(Map<String, dynamic> json) {
    return PetMedicineModel(
      petMedicineId: json['petMedicineId'],
      name: json['name'],
      veterinaryUse: json['veterinaryUse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petMedicineId': petMedicineId,
      'name': name,
      'veterinaryUse': veterinaryUse,
    };
  }
}
