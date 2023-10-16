// ignore_for_file: file_names

class TemperamentData {
  List<Map<String, dynamic>> temperamentList = [
    {
      'id': '0',
      'name': 'Selecione uma opção',
    },
    {
      'id': '1',
      'name': 'Linfático',
    },
    {
      'id': '2',
      'name': 'Sanguíneo',
    },
  ];

  List<Map<String, dynamic>> getTemperamentList() {
    return temperamentList;
  }

  Map<String, dynamic> getTemperamentByIndex(int index) {
    if (index >= 0 && index < temperamentList.length) {
      return temperamentList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getTemperamentById(int id) {
    return temperamentList.firstWhere((element) => element['id'] == id);
  }
}
