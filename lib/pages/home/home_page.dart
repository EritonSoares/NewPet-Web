// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    print('xxxxxxxxxxxxxxxxxxxxxxxxxx');
    //_fetchServiceQueue;
    print('xxxxxxxxxxxxxxxxxxxxxxxxxx');

    /*
    // Iniciar um Timer que atualiza a ListView a cada 30 segundos
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        // Atualize seus dados aqui, por exemplo:
        items.add(DateTime.now().toString());
      });
    });
    */
  }
  
  bool showFilaDeAtendimento = false;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      backgroundColor: Color.fromARGB(255, 207, 207, 207),
    );
  }
}
