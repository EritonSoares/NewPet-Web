// ignore_for_file: file_names

class PetAllergyModel {
  late final int? petAllergyId;
  late final String? name;

  PetAllergyModel(
      {required this.petAllergyId,
      required this.name,});

  factory PetAllergyModel.fromJson(Map<String, dynamic> json) {
    return PetAllergyModel(
      petAllergyId: json['petAllergyId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petAllergyId': petAllergyId,
      'name': name,
    };
  }
}
