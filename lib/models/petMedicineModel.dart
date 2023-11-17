// ignore_for_file: file_names

class PetMedicineModel {
  late final int? petMedicineId;
  late final String? name;
  late final int? medicineId;
  late final String? useTypeId;
  late final String? amountMedicine;
  late final String? dosage;
  late final bool? veterinaryUse;
  late final int? petVaccineId;
  late final String? doseName;

  PetMedicineModel({
    required this.petMedicineId,
    required this.name,
    required this.medicineId,
    required this.useTypeId,
    required this.amountMedicine,
    required this.dosage,
    required this.veterinaryUse,
    required this.petVaccineId,
    required this.doseName,
  });

  factory PetMedicineModel.fromJson(Map<String, dynamic> json) {
    return PetMedicineModel(
      petMedicineId: json['petMedicineId'],
      name: json['name'],
      medicineId: json['medicineId'],
      useTypeId: json['useTypeId'],
      amountMedicine: json['amountMedicine'],
      dosage: json['dosage'],
      veterinaryUse: json['veterinaryUse'],
      petVaccineId: json['petVaccineId'],
      doseName: json['doseName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petMedicineId': petMedicineId,
      'name': name,
      'medicineId': medicineId,
      'useTypeId': useTypeId,
      'amountMedicine': amountMedicine,
      'dosage': dosage,
      'veterinaryUse': veterinaryUse,
      'petVaccineId': petVaccineId,
      'doseName': doseName,
    };
  }
}
