// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:petner_web/pages/service/service_query.dart';
import 'package:petner_web/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFilaDeAtendimento = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            children: [
              Image.asset(
                'lib/shared/images/logoPetner.png', // Caminho para a imagem do logotipo
                width: 150, // Largura desejada do logotipo
                height: 150, // Altura desejada do logotipo
              ),
              const SizedBox(width: 10), // Espaço entre a imagem e o texto
              const Text('Sistema de Atendimento Veterinário', textAlign: TextAlign.center),
            ],
          ),
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
                          .pushReplacementNamed('/serviceQuery');
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
      backgroundColor: Colors.grey,
    );
  }
}
