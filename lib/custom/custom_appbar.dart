import 'package:flutter/material.dart';
import 'package:petner_web/shared/data/userPreference.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Row(
        children: [
          Image.asset(
            'lib/shared/images/logoPetner.png', // Caminho para a imagem do logotipo
            width: 150, // Largura desejada do logotipo
            height: 150, // Altura desejada do logotipo
          ),
          const SizedBox(width: 10), // Espaço entre a imagem e o texto
          const Text('Sistema de Atendimento Veterinário (1.0.0.14)',
              textAlign: TextAlign.center),
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
    );
  }
}
