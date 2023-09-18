// ignore_for_file: file_names

class CityModel {
  int id;
  String name;

  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
