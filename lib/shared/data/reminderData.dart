// ignore_for_file: file_names

class ReminderData {
  List<Map<String, dynamic>> reminderList = [
    {
      'id': '1',
      'name': 'Na hora',
    },
    {
      'id': '2',
      'name': '5 Minutos antes',
    },
    {
      'id': '3',
      'name': '10 Minutos antes',
    },
    {
      'id': '4',
      'name': '15 Minutos antes',
    },
    {
      'id': '5',
      'name': '30 Minutos antes',
    },
    {
      'id': '6',
      'name': '60 Minutos antes',
    },
  ];

  List<Map<String, dynamic>> getTreatmentUnitList() {
    return reminderList;
  }

  Map<String, dynamic> getTreatmentUniByIndex(int index) {
    if (index >= 0 && index < reminderList.length) {
      return reminderList[index];
    } else {
      return {};
    }
  }
}
