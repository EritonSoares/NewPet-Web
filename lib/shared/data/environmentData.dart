// ignore_for_file: file_names

class EnvironmentData {
  List<Map<String, dynamic>> environmentList = [
    {
      'id': '1',
      'name': 'Apartamento',
    },
    {
      'id': '2',
      'name': 'Casa',
    },
    {
      'id': '3',
      'name': 'Quintal',
    },
    {
      'id': '4',
      'name': 'Sítio',
    },
  ];

  List<Map<String, dynamic>> getEnvironmentList() {
    return environmentList;
  }

  Map<String, dynamic> getEnvironmentByIndex(int index) {
    if (index >= 0 && index < environmentList.length) {
      return environmentList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getEnvironmentById(int id) {
    return environmentList.firstWhere((element) => element['id'] == id);
  }
}
