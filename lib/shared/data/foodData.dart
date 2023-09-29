// ignore_for_file: file_names

class FoodData {
  List<Map<String, dynamic>> foodList = [
    {
      'id': '1',
      'name': 'Alimentação Comercial',
      'specie': 1,
    },
    {
      'id': '2',
      'name': 'Alimentação Caseira',
      'specie': 1,
    },
    {
      'id': '3',
      'name': 'Alimentação Natural',
      'specie': 1,
    },
    {
      'id': '4',
      'name': 'Alimentação Seca',
      'specie': 2,
    },
    {
      'id': '5',
      'name': 'Alimentação Umida',
      'specie': 2,
    },
    {
      'id': '6',
      'name': 'Dieta Caseira',
      'specie': 2,
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
