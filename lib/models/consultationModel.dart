// ignore_for_file: file_names

class ConsultationModel {
  late final int id;
  late final String name;
  
  ConsultationModel({
    required this.id,
    required this.name,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
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
