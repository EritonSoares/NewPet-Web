// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  /***************************************************************************************/
  /* Credênciais de Login  */
  static Future<void> saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Raças  */
  static Future<void> saveRace(String race) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('race', race);
  }

  static Future<String?> getRace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('race');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Espécie  */
  static Future<void> saveSpecie(String specie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('specie', specie);
  }

  static Future<String?> getSpecie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('specie');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Pelagem  */
  static Future<void> saveCoat(String coat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('coat', coat);
  }

  static Future<String?> getCoat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('coat');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Doença  */
  static Future<void> saveDisease(String disease) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('disease', disease);
  }

  static Future<String?> getDisease() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('disease');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Sintoma  */
  static Future<void> saveSymptom(String symptom) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('symptom', symptom);
  }

  static Future<String?> getSymptom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('symptom');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Doença  */
  static Future<void> saveMedicine(String medicine) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('medicine', medicine);
  }

  static Future<String?> getMedicine() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('medicine');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Programas de Sa[ude]  */
  static Future<void> saveHealthProgram(String healthProgram) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('healthProgram', healthProgram);
  }

  static Future<String?> getHealthProgram() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('healthProgram');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Sala de Consulta  */
  static Future<void> saveRoom(String token, String channel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('channel', channel);
  }

  static Future<String?> getRoomToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String?> getRoomChannel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('channel');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Dados dos Veterinário  */
  static Future<void> saveVeterinary(
      String userId, String name, String crmv) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('name', name);
    await prefs.setString('crmv', crmv);
  }

  static Future<String?> getVeterinaryUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<String?> getVeterinaryName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<String?> getVeterinaryCrmv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('crmv');
  }
  /****************************************************************************************/

/****************************************************************************************/
  /* Dados do agendamento  */
  static Future<void> saveQueue(String queue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('queue');
    await prefs.setString('queue', queue);
  }

  static Future<String?> getQueue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('queue');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Vacinas  */
  static Future<void> saveVaccine(String vaccine) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vaccine', vaccine);
  }

  static Future<String?> getVaccine() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('vaccine');
  }
  /****************************************************************************************/

  /****************************************************************************************/
  /* Listagem de Dose Vacina  */
  static Future<void> saveVaccineDose(String vaccineDose) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vaccineDose', vaccineDose);
  }

  static Future<String?> getVaccineDose() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('vaccineDose');
  }
  /****************************************************************************************/
}
