// ignore_for_file: file_names

class UserData {
  int? _id;
  String? _name;
  
  static final UserData _instance = UserData._internal();

  factory UserData() {
    return _instance;
  }

  UserData._internal();

  void setId(int id) {
    _id = id;
  }

  void setName(String name) {
    _name = name;
  }

  int? getId() {
    return _id;
  }

  String? getName() {
    return _name;
  }
  
}
