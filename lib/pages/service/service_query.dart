// ignore_for_file: library_private_types_in_public_api, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'package:petner_web/models/serviceQueueModel.dart';
import 'package:petner_web/shared/data/serviceQueueData.dart';
import 'package:petner_web/shared/data/userData.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:petner_web/utils/functionsRest.dart';
import 'package:petner_web/utils/routes.dart';
import 'dart:html' as html;

class ServiceQueryPage extends StatefulWidget {
  const ServiceQueryPage({super.key});

  @override
  _ServiceQueryPageState createState() => _ServiceQueryPageState();
}

class _ServiceQueryPageState extends State<ServiceQueryPage> {
  final TextEditingController _tutorNameController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _specieController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _screningController = TextEditingController();

  List<ServiceQueueModel> serviceQueueList = [];
  bool _queueSelected = false;
  late Future<List<dynamic>> _future;
  late Timer timer;
  late int _index;
  late String roomToken;
  String? _crmv, _veterinary, _veterinaryId;
  int seconds = 0;

  void _queueInformation(int index) {
    setState(() {
      _index = index;
      _tutorNameController.text = serviceQueueList[index].tutorName!;
      _petNameController.text = serviceQueueList[index].petName!;
      _raceController.text = serviceQueueList[index].raceName!;
      _specieController.text = serviceQueueList[index].specieName!;
      _genderController.text = serviceQueueList[index].genderName!;
      _screningController.text = serviceQueueList[index].screeningName!;

      _queueSelected = true; // Atualiza a variável de estado
    });
  }

  @override
  void initState() {
    super.initState();

    final isReload = html.window.performance.navigation.type == 1;
    if (isReload) {
      print('LOADING DE PAGINA');
    }

    _getVeterinaryCrmv();

    _future = _fetchServiceQueue();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          //_queueSelected = false;
          // Atualize seus dados aqui, por exemplo:
          if (seconds == 30 || seconds == 59) {
            _future = _fetchServiceQueue();
          }
        });
      }
    });
  }

  Future<void> _getVeterinaryCrmv() async {
    _veterinaryId = (await UserPreferences.getVeterinaryUserId())!;
    _veterinary = (await UserPreferences.getVeterinaryName())!;
    _crmv = (await UserPreferences.getVeterinaryCrmv())!;
  }

  Future<List<dynamic>> _fetchServiceQueue() async {
    return serviceQueueList = await serviceQueueApi();
  }

  Future<String> _getRTCToken(
      int petId, int queueId, int crmv, int veterinaryId) async {
    final roomToken = await getRTCTokenApi(petId, queueId, crmv, veterinaryId);

    return roomToken;
  }

  @override
  void dispose() {
    // Cancela o timer ao sair da tela para evitar memory leaks
    timer.cancel();
    super.dispose();
  }

  String formatElapsedTime(DateTime timestamp) {
    Duration difference = DateTime.now().difference(timestamp);
    seconds = difference.inSeconds;

    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    seconds = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      backgroundColor: const Color.fromARGB(255, 207, 207, 207),
      body: Center(
        child: Container(
          width: 1200, // Largura desejada
          height: 600, // Altura desejada
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // Título da barra superior
              Container(
                padding: const EdgeInsets.all(8.5),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        5.0), // Arredonda apenas o canto superior esquerdo
                    topRight: Radius.circular(
                        5.0), // Arredonda apenas o canto superior direito
                  ),
                ),
                height: 40, // Altura desejada
                width: double.infinity, // Ocupa todo o espaço horizontal
                child: const Text(
                  'Fila de Atendimento',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    //fontWeight: FontWeight.w600,
                    color: Colors.white, // Cor do texto em branco
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ), // Espaço entre o título e o conteúdo
              // Conteúdo da parte inferior (branco)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 6, // 60% do tamanho total
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FutureBuilder<List<dynamic>>(
                              future: _future,
                              builder: (context, snapshot) {
                                /*if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else*/
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.1,
                                    child: ListView.builder(
                                      itemCount: serviceQueueList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3,
                                              right: 15,
                                              top: 1,
                                              bottom: 5),
                                          child: Container(
                                            height:
                                                90, // Defina a altura desejada para o card
                                            width: double
                                                .infinity, // Defina a largura desejada para o card

                                            // Estilize o card com o BoxDecoration ou o Card widget
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              /*serviceQueueList[
                                                                      index]
                                                                  .queueType == 0 ? Colors.red : serviceQueueList[
                                                                      index]
                                                                  .queueType == 1 ? Colors.yellow : Colors.blue,*/
                                              border: Border(
                                                left: BorderSide(
                                                  color: serviceQueueList[index]
                                                              .queueType ==
                                                          0
                                                      ? Colors.red
                                                      : serviceQueueList[index]
                                                                  .queueType ==
                                                              1
                                                          ? Colors.yellow
                                                          : const Color
                                                              .fromARGB(
                                                              255,
                                                              10,
                                                              108,
                                                              189), // Cor da borda esquerda
                                                  width:
                                                      5.0, // Largura da borda esquerda
                                                ),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                _queueInformation(index);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  serviceQueueList[
                                                                          index]
                                                                      .petName!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(serviceQueueList[
                                                                        index]
                                                                    .tutorName!),
                                                                Text(serviceQueueList[
                                                                        index]
                                                                    .petName!),
                                                              ],
                                                            ),
                                                            Text(serviceQueueList[
                                                                    index]
                                                                .queueDate
                                                                .toString()),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(formatElapsedTime(
                                                                DateTime.parse(
                                                                    serviceQueueList[
                                                                            index]
                                                                        .queueDate))),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1, // Largura da linha divisória
                      color: Colors.grey, // Cor da linha divisória
                    ),
                    Expanded(
                      flex: 4, // 40% do tamanho total
                      child: Column(
                        mainAxisAlignment: !_queueSelected
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          (serviceQueueList.length == 0)
                              ? const Text('Nenhum Atendimento na Fila')
                              : (!_queueSelected || _index < 0)
                                  ? const Text(
                                      'Selecione um Atendimento para ver as Informações')
                                  : _serviceSummary(_index),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceSummary(int index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: const TextStyle(fontSize: 15.0),
              enabled: false,
              controller: _tutorNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0)), // Raio dos cantos da borda
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0), // Cor e largura da borda
                ),
                labelText: 'Tutor',
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              style: const TextStyle(fontSize: 15.0),
              enabled: false,
              controller: _petNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0)), // Raio dos cantos da borda
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0), // Cor e largura da borda
                ),
                labelText: 'Pet',
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              style: const TextStyle(fontSize: 15.0),
              enabled: false,
              controller: _raceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0)), // Raio dos cantos da borda
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0), // Cor e largura da borda
                ),
                labelText: 'Raça',
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(fontSize: 15.0),
                    enabled: false,
                    controller: _specieController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8.0)), // Raio dos cantos da borda
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0), // Cor e largura da borda
                      ),
                      labelText: 'Espécie',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(fontSize: 15.0),
                    enabled: false,
                    controller: _genderController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8.0)), // Raio dos cantos da borda
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0), // Cor e largura da borda
                      ),
                      labelText: 'Gênero',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              style: const TextStyle(fontSize: 15.0),
              enabled: false,
              controller: _screningController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0)), // Raio dos cantos da borda
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0), // Cor e largura da borda
                ),
                labelText: 'Sintoma',
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Triagem',
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      itemCount: serviceQueueList[index].screeningList!.length,
                      itemBuilder: (context, subindex) {
                        return Padding(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.all(1),
                          child: SizedBox(
                            height: 55, // Defina a altura desejada para o card
                            width: double.infinity,
                            child: ListTile(
                              title: Text(
                                  '${subindex + 1}- ${serviceQueueList[index].screeningList![subindex].question!}'),
                              subtitle: Text(
                                  'R: ${serviceQueueList[index].screeningList![subindex].answer!}'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      _getVeterinaryCrmv();
                      roomToken = await _getRTCToken(
                          serviceQueueList[index].petId,
                          serviceQueueList[index].queueId,
                          int.parse(_crmv!),
                          int.parse(_veterinaryId!));

                      if (roomToken == '0') {
                        print('erro 0');
                      } else if (roomToken == '-1') {
                        print('erro 1');
                      } else if (roomToken == '-2') {
                        print('erro 2');
                      } else {
                        UserPreferences.saveRoom(roomToken,
                            serviceQueueList[index].queueId.toString());
                        print(serviceQueueList[index].toJson());
                        UserPreferences.saveQueue(
                            jsonEncode(serviceQueueList[index].toJson()));
                        print('xxxxxxxxxxxxxxxxxxxxxxx');
                        Navigator.of(Routes.navigatorKey!.currentContext!)
                            .pushReplacementNamed('/consultationRoom');
                      }
                    },
                    child: const Text('Iniciar Atendimento'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
