// ignore_for_file: file_names

class StateModel {
  //"id":11,"sigla":"RO","nome":"Rondônia",

  int id;
  String acronym;
  String name;

  StateModel({
    required this.id,
    required this.acronym,
    required this.name,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      acronym: json['sigla'],
      name: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'acronym': acronym,
    };
  }
}
