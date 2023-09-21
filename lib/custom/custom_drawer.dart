import 'package:flutter/material.dart';
import 'package:petner_web/utils/routes.dart';

class CustomDrawer extends StatelessWidget implements PreferredSizeWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.blueAccent, // Cor de fundo azul
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
    );
  }
}
