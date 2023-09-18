// ignore_for_file: file_names

class SpecieModel {
  final String id;
  final String name;

  SpecieModel({required this.id, required this.name});

  factory SpecieModel.fromJson(Map<String, dynamic> json) {
    return SpecieModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
