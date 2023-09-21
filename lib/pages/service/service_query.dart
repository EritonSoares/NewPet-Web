// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'package:petner_web/models/serviceQueueModel.dart';
import 'package:petner_web/shared/data/serviceQueueData.dart';
import 'package:petner_web/utils/functionsRest.dart';
import 'package:petner_web/utils/routes.dart';

class ServiceQueryPage extends StatefulWidget {
  const ServiceQueryPage({super.key});

  @override
  _ServiceQueryPageState createState() => _ServiceQueryPageState();
}

class _ServiceQueryPageState extends State<ServiceQueryPage> {
  final TextEditingController _tutorNameController = TextEditingController();
  List<ServiceQueueModel> serviceQueueList = [];
  bool _queueSelected = false;
  late Future<List<dynamic>> _future;
  late Timer timer;
  late int _index;

  void _teste(int index) {
    setState(() {
      _index = index;
      _tutorNameController.text = serviceQueueList[index].tutorName!;
      _queueSelected = true; // Atualiza a variável de estado
    });
  }

  @override
  void initState() {
    super.initState();
    _future = _fetchServiceQueue();

    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        _queueSelected = false;
        // Atualize seus dados aqui, por exemplo:
        _future = _fetchServiceQueue();
      });
    });
  }

  Future<List<dynamic>> _fetchServiceQueue() async {
    return serviceQueueList = await serviceQueueApi();
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
                                                //print(petVaccine.);
                                                _teste(index);
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          !_queueSelected
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
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                      enabled: false,
                      controller: _tutorNameController,
                      
                      decoration: const InputDecoration(
                        labelText: 'Nomedo Tutor',
                        
                      ),
                      validator: (input) => input?.isEmpty == true ? 'Por favor informar o Nome' : null,
                    ),
              Text(serviceQueueList[index].petName!),
            ],
          ),
        ),
      ),
    );
  }
}
