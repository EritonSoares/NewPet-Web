// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'package:petner_web/utils/routes.dart';

class ServiceQueryPage extends StatefulWidget {
  const ServiceQueryPage({super.key});

  @override
  _ServiceQueryPageState createState() => _ServiceQueryPageState();
}

class _ServiceQueryPageState extends State<ServiceQueryPage> {
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
                height: 16,
              ), // Espaço entre o título e o conteúdo
              // Conteúdo da parte inferior (branco)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 1000,
                                padding: const EdgeInsets.only(left: 8, top: 2),
                                decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        5.0), // Arredonda apenas o canto superior esquerdo
                                    topRight: Radius.circular(
                                        5.0), // Arredonda apenas o canto superior direito
                                  ),
                                ),
                                height:
                                    25, // Altura desejada// Ocupa todo o espaço horizontal
                                child: const Text(
                                  'Emergência',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    //fontWeight: FontWeight.w600,
                                    color:
                                        Colors.white, // Cor do texto em branco
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 1000,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: ListView.builder(
                          shrinkWrap:
                              true, // Para que a ListView assuma o espaço mínimo necessário
                          itemCount:
                              5, // Substitua pelo número de itens que você deseja exibir
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Item $index'),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 1000,
                            padding: const EdgeInsets.only(left: 8, top: 2),
                            decoration: const BoxDecoration(
                              color: Colors.yellowAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    5.0), // Arredonda apenas o canto superior esquerdo
                                topRight: Radius.circular(
                                    5.0), // Arredonda apenas o canto superior direito
                              ),
                            ),
                            height:
                                25, // Altura desejada// Ocupa todo o espaço horizontal
                            child: const Text(
                              'Consultas Agendadas',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                //fontWeight: FontWeight.w600,
                                color: Colors.black, // Cor do texto em branco
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 1000,
                            padding: const EdgeInsets.only(left: 8, top: 2),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    5.0), // Arredonda apenas o canto superior esquerdo
                                topRight: Radius.circular(
                                    5.0), // Arredonda apenas o canto superior direito
                              ),
                            ),
                            height:
                                25, // Altura desejada// Ocupa todo o espaço horizontal
                            child: const Text(
                              'Consultas',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                //fontWeight: FontWeight.w600,
                                color: Colors.white, // Cor do texto em branco
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
