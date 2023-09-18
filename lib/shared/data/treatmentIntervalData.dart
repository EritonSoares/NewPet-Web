// ignore_for_file: file_names

class TreatmentIntervalData {
  List<Map<String, dynamic>> treatmentIntervalList = [
    {
      'id': '1',
      'name': 'Hora(s)',
    },
    {
      'id': '2',
      'name': 'Dia(s)',
    },
    {
      'id': '3',
      'name': 'Mês(s)',
    },
    {
      'id': '4',
      'name': 'Ano(s)',
    },
  ];

  List<Map<String, dynamic>> getTreatmentUnitList() {
    return treatmentIntervalList;
  }

  Map<String, dynamic> getTreatmentUniByIndex(int index) {
    if (index >= 0 && index < treatmentIntervalList.length) {
      return treatmentIntervalList[index];
    } else {
      return {};
    }
  }
}
