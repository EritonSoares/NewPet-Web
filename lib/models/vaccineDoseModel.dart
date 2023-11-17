// ignore_for_file: file_names

class VaccineDoseModel {
  late final int vaccineDoseId;
  late final String name;
  late final int vaccineId;

  VaccineDoseModel({
    required this.vaccineDoseId,
    required this.name,
    required this.vaccineId,
  });

  factory VaccineDoseModel.fromJson(Map<String, dynamic> json) {
    return VaccineDoseModel(
      vaccineDoseId: json['vaccineDoseId'],
      name: json['name'],
      vaccineId: json['vaccineId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccineDoseId': vaccineDoseId,
      'name': name,
      'vaccineId': vaccineId,
    };
  }
}
