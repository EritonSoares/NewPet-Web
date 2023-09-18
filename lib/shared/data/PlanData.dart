// ignore_for_file: file_names

class PlanData {
  List<Map<String, String>> planList = [
    {'name': 'Petner Full', 'price': 'R\$ 128,90', 'description': 'Garanta o bem-estar do seu companheiro com cobertura de vacinação, carteira de vacinação digital, prontuário online e atendimento de emergência. Tudo a partir de R\$128,90. Cuide, previna e proteja com o Plano de Saúde Pet.'},
    {'name': 'Petner Plus', 'price': 'R\$ 64,90', 'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus a nunc eget sollicitudin. Etiam ultricies mauris a eros fermentum, eget gravida dolor lacinia.'},
    {'name': 'Petner Telemedicina', 'price': 'R\$ 34,90', 'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus a nunc eget sollicitudin. Etiam ultricies mauris a eros fermentum, eget gravida dolor lacinia.'},
    {'name': 'Petner Digital', 'price': 'R\$ 14,90', 'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus a nunc eget sollicitudin. Etiam ultricies mauris a eros fermentum, eget gravida dolor lacinia.'},
  ];

  List<Map<String, dynamic>> getStateList() {
    return planList;
  }

  Map<String, dynamic> getStateIndex(int index) {
    if (index >= 0 && index < planList.length) {
      return planList[index];
    } else {
      return {};
    }
  }

  Map<String, dynamic> getStateById(String index) {
    return planList.firstWhere((element) => (element['id'] == index));
  }
}
