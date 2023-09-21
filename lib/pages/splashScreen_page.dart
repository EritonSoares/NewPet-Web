// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:petner_web/pages/home/home_page.dart';
import 'package:petner_web/pages/login/login_page.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:petner_web/utils/functionsRest.dart';
import 'package:petner_web/utils/petColors.dart';
import 'package:petner_web/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Verificar se o usuário já fez login anteriormente
    // por exemplo, utilizando SharedPreferences
    bool isLoggedIn = await checkIfUserIsLoggedIn();

    // Aguardar um tempo simulado para exibir a tela de splash
    await Future.delayed(const Duration(seconds: 2));

    // Navegar para a página de login ou para a página principal,
    // dependendo do estado de login
    if (isLoggedIn) {
      // Usuário já fez login, navegar para a página principal
      //Ir para HOME
      Navigator.of(Routes.navigatorKey!.currentContext!)
                          .pushReplacementNamed('/home');
/*
      showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(

        content: const Row(
          children: [
            Text('Texto 1'),
            Text('Texto 2'),
            Text('Texto 3'),
          ],
        ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o diálogo
          },
          child: const Text('Fechar'),
        ),
      ],
    );
    },
  );
  */
      print('logado');
      /*
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      */
    } else {
      // Usuário não fez login, navegar para a página de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  Future<bool> checkIfUserIsLoggedIn() async {
    String? email = await UserPreferences.getEmail();
    String? password = await UserPreferences.getPassword();

    if (email != null && password != null) {
      Map<String, dynamic> responseData =
          await validateUserApi(email, password, 1);

      if (responseData['validateUser'] == 2) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'lib/shared/images/logoPetner.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'A melhor amiga do seu melhor amigo!',
                style: TextStyle(
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.bold,
                    color: PetColors.petnerShakespeare),
              ),
              const SizedBox(
                height: 30,
              ),
              const CircularProgressIndicator(
                  backgroundColor: PetColors.petnerCaputMortuum,
                  color: PetColors.petnerFlamingo),
            ],
          ),
        ),
      ),
    );
  }
}
