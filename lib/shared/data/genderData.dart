// ignore_for_file: file_names

class GenderData {
  List<Map<String, dynamic>> genderList = [
    {
      'id': 'M',
      'name': 'Macho',
    },
    {
      'id': 'F',
      'name': 'Fêmea',
    },
  ];

  List<Map<String, dynamic>> getGenderList() {
    return genderList;
  }

  Map<String, dynamic> getGenderByIndex(int index) {
    if (index >= 0 && index < genderList.length) {
      return genderList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getGenderById(String index) {
    return genderList.firstWhere((element) => (element['id'] == index));
  }
}
