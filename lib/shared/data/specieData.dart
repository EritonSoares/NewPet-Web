// ignore_for_file: file_names

class SpecieData {
  List<Map<String, dynamic>> specieList = [
    {
      'id': '1',
      'name': 'Canina',
    },
    {
      'id': '2',
      'name': 'Felina',
    },
  ];

  List<Map<String, dynamic>> getSpecieList() {
    return specieList;
  }

  Map<String, dynamic> getSpecieByIndex(int index) {
    if (index >= 0 && index < specieList.length) {
      return specieList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getSpecieById(int id) {
    return specieList.firstWhere((element) => element['id'] == id);
  }
}
