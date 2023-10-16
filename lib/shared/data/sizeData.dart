// ignore_for_file: file_names

class SizeData {
  List<Map<String, dynamic>> sizeList = [
    {
      'id': '1',
      'name': 'Pequeno',
    },
    {
      'id': '2',
      'name': 'Médio',
    },
    {
      'id': '3',
      'name': 'Grande',
    },
    {
      'id': '4',
      'name': 'Gigante',
    },
  ];

  List<Map<String, dynamic>> getSizeList() {
    return sizeList;
  }

  Map<String, dynamic> getSizeByIndex(int index) {
    if (index >= 0 && index < sizeList.length) {
      return sizeList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getSizeById(int id) {
    return sizeList.firstWhere((element) => element['id'] == id);
  }
}
