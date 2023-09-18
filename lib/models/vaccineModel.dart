// ignore_for_file: file_names

class VaccineModel {
  late final int vaccineId;
  late final String name;
  late final bool canine;
  late final bool feline;

  VaccineModel(
      {required this.vaccineId,
      required this.name,
      required this.canine,
      required this.feline});

  factory VaccineModel.fromJson(Map<String, dynamic> json) {
    return VaccineModel(
        vaccineId: json['vaccineId'],
        name: json['name'],
        canine: json['canine'],
        feline: json['feline']);
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccineId': vaccineId,
      'name': name,
      'canine': canine,
      'feline': feline
    };
  }
}
