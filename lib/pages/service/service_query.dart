// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('Petner - Sistema de Atendimento Veterinário'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              // Adicione a tradução ao atributo semanticLabel
              tooltip: 'Abrir menu de navegação',
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.blue, // Cor de fundo azul
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white, // Texto branco
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Fila de Atendimento',
                      style: TextStyle(
                          color: Colors.grey[800]), // Letras cinza escuro
                    ),
                    onTap: () {
                      // Coloque aqui a ação ao selecionar "Fila de Atendimento"
                      //Navigator.pop(context); // Fecha o menu
                      Navigator.of(Routes.navigatorKey!.currentContext!)
                          .pushNamed('/serviceQuery');
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Clientes',
                      style: TextStyle(
                          color: Colors.grey[800]), // Letras cinza escuro
                    ),
                    onTap: () {
                      // Coloque aqui a ação ao selecionar "Clientes"
                      Navigator.pop(context); // Fecha o menu
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 1200, // Largura desejada
          height: 600, // Altura desejada
          decoration: const BoxDecoration(
            color: Colors.white          
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Fila de Atendimento',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Fila',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
