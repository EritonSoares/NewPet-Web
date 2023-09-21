// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petner_web/pages/home/home_page.dart';
import 'package:petner_web/utils/functionsRest.dart';

import '../../utils/petColors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isObscure = true;
  bool _isNotWeb = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _isNotWeb =
          true; //alterar para false quando for desenvolver o sistema do veterinário
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }

    return null;
  }

  Future<int> _submit(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final form = _formKey.currentState;

    if (form!.validate()) {
      Map<String, dynamic> responseData = await validateUserApi(
          _emailController.text, _passwordController.text, 0);

      setState(() {
        _isLoading = false;
      });

      return responseData['validateUser'];
    } else {
      return 6;
    }
  }

  void _forgotPassword() {
    // TODO: Implement forgot password logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bem vindo a Petner'),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: kIsWeb ? 500.0 : MediaQuery.of(context).size.width,
              alignment: kIsWeb ? Alignment.center : null,
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email), // Ícone do e-mail
                      ),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.lock), // Ícone do e-mail
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _toggleObscure,
                        ),
                      ),
                      validator: (input) => (input?.length ?? 0) < 6
                          ? 'A senha deve ter pelo menos 6 caracteres'
                          : null,
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () {
                        _submit(context).then((value) {
                          switch (value) {
                            case 0:
                              _showAlertDialog(
                                  context, 'Usuário não encontrado');
                              break;
                            case 1:
                              _showAlertDialog(context, 'Senha inválida');
                              break;
                            case 2:
                              //Ir para HOME
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                              break;
                            case 3:
                              _showAlertDialog(context,
                                  'Usuário não tem acesso ao Sistema.');
                              break;
                            default:
                              _showAlertDialog(
                                  context, 'Erro ao efetuar Validação');
                              break;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: PetColors.petnerShakespeare,
                      ),
                      child: const Text(
                        'Acessar Conta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Visibility(
                      visible: _isNotWeb,
                      child: TextButton(
                        onPressed: _forgotPassword,
                        child: const Text(
                          'Esqueceu a Senha?',
                          style: TextStyle(
                            color: PetColors.petnerShakespeare,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                  child: CircularProgressIndicator(color: Colors.black)),
            ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alerta'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
