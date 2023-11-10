// ignore_for_file: file_names

class PetDiseaseServiceModel {
  late final int? petDiseaseServiceId;
  late final String? name;

  PetDiseaseServiceModel({
    required this.petDiseaseServiceId,
    required this.name,
  });

  factory PetDiseaseServiceModel.fromJson(Map<String, dynamic> json) {
    return PetDiseaseServiceModel(
      petDiseaseServiceId: json['petDiseaseServiceId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petDiseaseServiceId': petDiseaseServiceId,
      'name': name,
    };
  }
}
