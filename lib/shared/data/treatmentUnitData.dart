// ignore_for_file: file_names

class TreatmentUnitData {
  List<Map<String, dynamic>> treatmentUnitList = [
    {
      'id': '1',
      'name': 'Comprimido',
    },
    {
      'id': '2',
      'name': 'ML',
    },
    {
      'id': '3',
      'name': 'Gotas',
    },
    {
      'id': '4',
      'name': 'MG',
    },
    {
      'id': '5',
      'name': 'Gramas',
    },
    {
      'id': '6',
      'name': 'Dose',
    }
  ];

  List<Map<String, dynamic>> getTreatmentUnitList() {
    return treatmentUnitList;
  }

  Map<String, dynamic> getTreatmentUniByIndex(int index) {
    if (index >= 0 && index < treatmentUnitList.length) {
      return treatmentUnitList[index];
    } else {
      return {};
    }
  }
}
