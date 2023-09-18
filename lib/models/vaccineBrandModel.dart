// ignore_for_file: file_names

class VaccineBrandModel {
  late final int brandId;
  late final String brandName;
  late final int vaccineId;

  VaccineBrandModel(
      {required this.brandId,
      required this.brandName,
      required this.vaccineId});

  factory VaccineBrandModel.fromJson(Map<String, dynamic> json) {
    return VaccineBrandModel(
        brandId: json['brandId'],
        brandName: json['brandName'],
        vaccineId: json['vaccineId']);
  }

  Map<String, dynamic> toJson() {
    return {'brandId': brandId, 'brandName': brandName, 'vaccineId': vaccineId};
  }
}
