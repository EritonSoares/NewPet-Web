// ignore_for_file: file_names

class BodyScoreData {
  List<Map<String, dynamic>> bodyScoreList = [
    {
      'id': '1',
      'name': 'Bom',
    },
    {
      'id': '2',
      'name': 'Magro',
    },
    {
      'id': '3',
      'name': 'Caquético',
    },
    {
      'id': '4',
      'name': 'Obeso',
    },
  ];

  List<Map<String, dynamic>> getBodyScoreList() {
    return bodyScoreList;
  }

  Map<String, dynamic> getBodyScoreByIndex(int index) {
    if (index >= 0 && index < bodyScoreList.length) {
      return bodyScoreList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getBodyScoreById(int id) {
    return bodyScoreList.firstWhere((element) => element['id'] == id);
  }
}
