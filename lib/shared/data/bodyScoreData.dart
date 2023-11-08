// ignore_for_file: file_names

class BodyScoreData {
  List<Map<String, dynamic>> bodyScoreList = [
    {
      'id': '1',
      'name': 'Emaciado',
    },
    {
      'id': '2',
      'name': 'Muito Magro',
    },
    {
      'id': '3',
      'name': 'Magro',
    },
    {
      'id': '4',
      'name': 'Ideal',
    },
    {
      'id': '5',
      'name': 'Sobrepeso',
    },
    {
      'id': '6',
      'name': 'Obesidade',
    },
    {
      'id': '7',
      'name': 'Obesidade Grave',
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
