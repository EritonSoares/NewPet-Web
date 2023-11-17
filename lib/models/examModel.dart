// ignore_for_file: file_names

class ExamModel {
  late final int id;
  late final String name;
  late final bool dog;
  late final bool cat;

  ExamModel({
    required this.id,
    required this.name,
    required this.dog,
    required this.cat,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      name: json['name'],
      dog: json['dog'],
      cat: json['cat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dog': dog,
      'cat': cat,
    };
  }
}
