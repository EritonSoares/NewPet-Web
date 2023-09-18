// ignore_for_file: file_names

class VaccineDoseModel {
  late final int vaccineDoseId;
  late final String name;

  VaccineDoseModel({required this.vaccineDoseId, required this.name});

  factory VaccineDoseModel.fromJson(Map<String, dynamic> json) {
    return VaccineDoseModel(
        vaccineDoseId: json['vaccineDoseId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'vaccineDoseId': vaccineDoseId, 'name': name};
  }
}
