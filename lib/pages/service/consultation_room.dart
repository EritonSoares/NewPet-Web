// ignore_for_file: library_private_types_in_public_api, library_prefixes, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'dart:html' as html;

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:petner_web/shared/data/userPreference.dart';

const appId = "a12600dd0e80435ca0a1efc4660cbe6b";
//const token = "006a12600dd0e80435ca0a1efc4660cbe6bIABA0Ug4bFpjYxdjWXx//De36mr93wxw9jsOjttA0Li+BEwKp+vpr4RpIgBOqzEBnUoEZQQAAQAtBwNlAgAtBwNlAwAtBwNlBAAtBwNl";
//const channel = "petner";

class ConsultationRoomPage extends StatefulWidget {
  const ConsultationRoomPage({super.key});

  @override
  _ConsultationRoomPageState createState() => _ConsultationRoomPageState();
}

class _ConsultationRoomPageState extends State<ConsultationRoomPage> {
  late final RtcEngine _engine;
  late final List<Map<int, String>> typeService;
  late final int _selectedTypeService;
  int selectedOption = 1;
  late List<Map<int, String>> consultaOptions;
  late List<Widget> _pages;
  late int _currentPageIndex;
  late String? _token, _channel, _crmv;


  bool isJoined = false,
      enabledAudio = true,
      enableCamera = true,
      shareScreen = false;
  int? _remoteUid;

  @override
  void initState() {
    super.initState();

    _roomConfiguration();
    consultaOptions = [
      {1: 'Consulta Boas Vindas'},
      {2: 'Consulta por Queixa'},
      {3: 'Consulta'},
      {4: 'Tele Orientação'},
      {5: 'Acompanhamento de Evolução'},
    ];

    _currentPageIndex = 0;
    if (selectedOption == 1) {
      _pages = [
        WelcomePage(),
        UpdateRegistrationDataPage(),
        VaccineRegistrationPage(),
        ChronicHealthConditionPage(),
        SymptomPage(),
        AnamnesisPage(),
        Quiz3Page(),
        Quiz4Page(),
        IaPage(),
        RecommendationPage(),
        FinalClassificationPage(),
        HealthProgramPage(),
        DocumentAvaliablePage(),
      ];
    }

    //DESCOMENTAR PARA ATIVAR A CHAMADA DE VÍDEO
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _roomConfiguration() async {
    _token = await UserPreferences.getRoomToken();
    _channel = await UserPreferences.getRoomChannel();
    _crmv = (await UserPreferences.getVeterinaryCrmv())!;
  }

  Future<void> _dispose() async {
    await _engine.stopScreenCapture();
    await _engine.leaveChannel();
    await _engine.destroy();
  }

  Future<void> _startScreenShare() async {
    if (!shareScreen) {
      if (_engine != null) {
        await _engine.startScreenCaptureByDisplayId(0);

        setState(() {
          shareScreen = true;
        });
      }
    } else {
      if (_engine != null) {
        await _engine!.stopScreenCapture();
        // Potentially restart the camera feed here
        setState(() {
          shareScreen = false;
        });
      }
    }
  }

  Future<void> _initEngine() async {
    await html.window.navigator.getUserMedia(audio: true, video: true);
    //await <Permission>[Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channelName, int uid, int elapsed) {
          setState(() {
            isJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    _joinChannel();
  }

  Future<void> _joinChannel() async {
    log('joined channed: _engine.joinChannel(' ', ....., null, 0)');
    await _engine.joinChannel(_token, _channel!, null, int.parse(_crmv!));
  }

  Future<void> _toggleMicrophone() async {
    await _engine.enableLocalAudio(!enabledAudio);
    setState(() {
      enabledAudio = !enabledAudio;
    });
  }

  Future<void> _toggleCamera() async {
    await _engine.enableLocalVideo(!enableCamera);
    setState(() {
      enableCamera = !enableCamera;
    });
  }

  Future<void> _leaveChannel() async {
    await _engine.stopScreenCapture();
    await _engine.leaveChannel();
    //Navigator.of(context).pop();
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: '.......',
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 6, // 70% do espaço disponível
              child: Container(
                color: Colors.white, // Cor da coluna esquerda
                child: Column(
                  children: [
                    // Conteúdo da coluna esquerda
                    _videoConsultation(),
                  ],
                ),
              ),
            ),
            Container(
              width: 1, // Largura da linha divisória
              color: Colors.grey, // Cor da linha divisória
            ),
            Expanded(
              flex: 4, // 30% do espaço disponível
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white, // Cor da coluna direita
                child: Column(
                  children: [
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Ficha', // Texto no decoration
                      ),
                      value: selectedOption,
                      onChanged: (int? newCode) {
                        if (newCode != null) {
                          setState(() {
                            selectedOption = newCode;
                          });
                        }
                      },
                      items: consultaOptions.map((Map<int, String> option) {
                        final int code = option.keys.first;
                        final String description = option.values.first;
                        return DropdownMenuItem<int>(
                          value: code,
                          child: Text(description),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: PageView.builder(
                        itemCount: _pages.length,
                        controller:
                            PageController(initialPage: _currentPageIndex),
                        itemBuilder: (context, index) {
                          return _pages[_currentPageIndex];
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: _currentPageIndex == 0
                              ? false
                              : true, // Controla a visibilidade do botão
                          child: ElevatedButton(
                            onPressed: () {
                              // Lógica para ir para a página anterior
                              if (_currentPageIndex > 0) {
                                setState(() {
                                  _currentPageIndex--;
                                });
                              }
                            },
                            child: const Text('Anterior'),
                          ),
                        ),
                        Visibility(
                          visible: _currentPageIndex == 0
                              ? true
                              : false, // Controla a visibilidade do botão
                          child: const Text('           '),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '${_currentPageIndex + 1} de ${_pages.length}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _currentPageIndex == _pages.length - 1
                              ? false
                              : true, // Controla a visibilidade do botão
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPageIndex < _pages.length - 1) {
                                setState(() {
                                  _currentPageIndex++;
                                });
                              }
                            },
                            child: const Text('Próximo'),
                          ),
                        ),
                        Visibility(
                          visible: _currentPageIndex == _pages.length - 1
                              ? true
                              : false, // Controla a visibilidade do botão
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Finalizar'),
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
    );
  }

  Widget _videoConsultation() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Center(child: _remoteVideo()),
          ),
          Positioned(
            bottom: 70,
            right: 0,
            child: Container(
              height: 240,
              width: 400,
              color: Colors.black,
              child: isJoined
                  ? const RtcLocalView.SurfaceView()
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                color: Colors.black.withOpacity(0.3),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _toggleMicrophone();
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              enabledAudio ? Icons.mic : Icons.mic_off_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _leaveChannel();
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.call_end,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _toggleCamera();
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: <Widget>[
                              const Center(
                                child: Icon(
                                  Icons.video_camera_front_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              if (!enableCamera)
                                const Center(
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    size: 38,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    /*
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _startScreenShare();
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              shareScreen
                                  ? Icons.stop_circle
                                  : Icons.screen_share,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    */
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

/*
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
*/

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Boas Vindas",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}


class UpdateRegistrationDataPage extends StatelessWidget {
  const UpdateRegistrationDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Atualização dos Dados Cadastrais",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class VaccineRegistrationPage extends StatelessWidget {
  const VaccineRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Registro de Vácinas",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class ChronicHealthConditionPage extends StatelessWidget {
  const ChronicHealthConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Condições Crônicas de Saúde",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class SymptomPage extends StatelessWidget {
  const SymptomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Sintomas",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class AnamnesisPage extends StatelessWidget {
  const AnamnesisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Anamnese",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class Quiz3Page extends StatelessWidget {
  const Quiz3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Questionário 3",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class Quiz4Page extends StatelessWidget {
  const Quiz4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Questionário 4",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class IaPage extends StatelessWidget {
  const IaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Inteligência Artificial",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Orientações e Recomendações Finais",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class FinalClassificationPage extends StatelessWidget {
  const FinalClassificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Classificação de risco Final",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class HealthProgramPage extends StatelessWidget {
  const HealthProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Programa de Saúde Disponíveis",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class DocumentAvaliablePage extends StatelessWidget {
  const DocumentAvaliablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Aviso de Documentos Disponíveis",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
