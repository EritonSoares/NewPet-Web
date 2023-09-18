// ignore_for_file: file_names

class FoodData {
  List<Map<String, dynamic>> foodList = [
    {
      'id': '1',
      'name': 'Comida de Panela',
    },
    {
      'id': '2',
      'name': 'Natural',
    },
    {
      'id': '3',
      'name': 'Ração',
    },
  ];

  List<Map<String, dynamic>> getFoodList() {
    return foodList;
  }

  Map<String, dynamic> getFoodByIndex(int index) {
    if (index >= 0 && index < foodList.length) {
      return foodList[index];
    } else {
      return {};
    }
  }
}
