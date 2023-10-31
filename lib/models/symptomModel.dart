// ignore_for_file: file_names

class SymptomModel {
  late final String id;
  late final String name;

  SymptomModel({
    required this.id,
    required this.name,
  });

  factory SymptomModel.fromJson(Map<String, dynamic> json) {
    return SymptomModel(
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
