// ignore_for_file: file_names

class PetModel {
  late final int tutorId;
  late final int id;
  late final String name;
  late final String nickname;
  late final String specie;
  late final String race;
  late final String gender;
  late final String birthday;
  late final String age;
  late final String food;
  late final String environment;
  late final String weight;
  String photoName;
  late String imageUrl;

  set setId(int value) {
    id = value;
  }

  set setPhotoName(String value) {
    photoName = value;
  }

  set setNickname(String value) {
    nickname = value;
  }

  String getNickname() {
    return nickname;
  }

  PetModel({
    required this.tutorId,
    required this.id,
    required this.name,
    required this.nickname,
    required this.specie,
    required this.race,
    required this.gender,
    required this.birthday,
    required this.age,
    required this.food,
    required this.environment,
    required this.weight,
    required this.photoName,
    required this.imageUrl,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      tutorId: json['tutorId'],
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      specie: json['specie'],
      race: json['race'],
      gender: json['gender'],
      birthday: json['birthday'],
      age: json['age'],
      food: json['food'],
      environment: json['environment'],
      weight: json['weight'],
      photoName: json['photoName'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tutorId': tutorId,
      'id': id,
      'name': name,
      'nickname': nickname,
      'specie': specie,
      'race': race,
      'gender': gender,
      'birthday': birthday,
      'age': age,
      'food': food,
      'environment': environment,
      'weight': weight,
      'photoName': photoName,
      'imageUrl': imageUrl,
    };
  }

  void cancel() {}
}
