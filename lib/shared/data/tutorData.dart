// ignore_for_file: file_names

class TutorData {
  int? _id;
  String? _name;
  String? _email;

  static final TutorData _instance = TutorData._internal();

  factory TutorData() {
    return _instance;
  }

  TutorData._internal();

  void setId(int id) {
    _id = id;
  }

  void setName(String name) {
    _name = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  int? getId() {
    return _id;
  }

  String? getName() {
    return _name;
  }

  String? getEmail() {
    return _email;
  }
}
