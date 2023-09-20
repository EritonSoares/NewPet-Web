// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

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
        title: const Text('Fila de Atendimento'),
      ),
      body: const Center(
        child: Text('Fila'),
      ),
    );
  }
}
