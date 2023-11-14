// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'package:petner_web/pages/login/login_page.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:petner_web/utils/functionsRest.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    if (!isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
