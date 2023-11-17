// ignore_for_file: file_names

class PetVaccineDoseModel {
  late final int petVaccineDoseId;
  late final String name;

  PetVaccineDoseModel({required this.petVaccineDoseId, required this.name});

  factory PetVaccineDoseModel.fromJson(Map<String, dynamic> json) {
    return PetVaccineDoseModel(
        petVaccineDoseId: json['petVaccineDoseId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'petVaccineDoseId': petVaccineDoseId, 'name': name};
  }
}
