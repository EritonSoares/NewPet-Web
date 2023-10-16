// ignore_for_file: library_private_types_in_public_api, library_prefixes, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'dart:html' as html;

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:petner_web/models/coatModel.dart';
import 'package:petner_web/models/raceModel.dart';
import 'package:petner_web/models/serviceQueueModel.dart';
import 'package:petner_web/shared/data/coatData.dart';
import 'package:petner_web/shared/data/environmentData.dart';
import 'package:petner_web/shared/data/genderData.dart';
import 'package:petner_web/shared/data/raceData.dart';
import 'package:petner_web/shared/data/sizeData.dart';
import 'package:petner_web/shared/data/specieData.dart';
import 'package:petner_web/shared/data/temperamentData.dart';
import 'package:petner_web/shared/data/userPreference.dart';

const appId = "a12600dd0e80435ca0a1efc4660cbe6b";
//const token = "006a12600dd0e80435ca0a1efc4660cbe6bIABA0Ug4bFpjYxdjWXx//De36mr93wxw9jsOjttA0Li+BEwKp+vpr4RpIgBOqzEBnUoEZQQAAQAtBwNlAgAtBwNlAwAtBwNlBAAtBwNl";
//const channel = "petner";
late ServiceQueueModel _serviceQueue;

// Variaveis e controlers
late final String _petPhoto;
late int? _temperamentId;
late bool _castrated;
late int? _environmentId;
late int _foodId;
late int _specieId;
late final String _bithDay;
late final String _age;
late final int _ageType;
String? _genderId;
int? _raceId;
int? _sizeId;
int? _coatId;
late final String _state;
late final String _city;
late final String _neighborhood;
late final int _bodyScoreId;
late final int _productId;
final TextEditingController _tutorNameController = TextEditingController();
final TextEditingController _petNameController = TextEditingController();
final TextEditingController _petNickNameController = TextEditingController();
final TextEditingController _raceController = TextEditingController();
final TextEditingController _specieController = TextEditingController();
final TextEditingController _genderController = TextEditingController();
final TextEditingController _screningController = TextEditingController();
final TextEditingController _productController = TextEditingController();
final TextEditingController _ageController = TextEditingController();
bool isWelcome = false;
bool isProduct = false;
bool isCompany = false;
bool isFaceToFaceConsultation = false;
bool isHealthProgram = false;
bool isAgeReal = false;
List<RaceModel> raceList = [];
List<CoatModel> coatList = [];
// Cor inicial

class ConsultationRoomPage extends StatefulWidget {
  const ConsultationRoomPage({super.key});

  @override
  _ConsultationRoomPageState createState() => _ConsultationRoomPageState();
}

class _ConsultationRoomPageState extends State<ConsultationRoomPage> {
  late final RtcEngine _engine;
  late final List<Map<int, String>> typeService;
  int _selectedTypeService = 1;
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
    _getQueue();

    consultaOptions = [
      {1: 'Consulta Boas Vindas'},
      {2: 'Consulta por Queixa'},
      {3: 'Consulta'},
      {4: 'Tele Orientação'},
      {5: 'Acompanhamento de Evolução'},
    ];

    _currentPageIndex = 0;
    if (_selectedTypeService == 1) {
      _pages = [
        WelcomePage(
          updateCheckboxWelcome: (bool newValue) {
            setState(() {
              isWelcome = newValue;
            });
          },
          updateCheckboxCompany: (bool newValue) {
            setState(() {
              isCompany = newValue;
            });
          },
          updateCheckboxProduct: (bool newValue) {
            setState(() {
              isProduct = newValue;
            });
          },
          updateCheckboxFaceToFaceConsultation: (bool newValue) {
            setState(() {
              isFaceToFaceConsultation = newValue;
            });
          },
          updateCheckboxHealthProgram: (bool newValue) {
            setState(() {
              isHealthProgram = newValue;
            });
          },
        ),
        const UpdateRegistrationDataPage(),
        const VaccineRegistrationPage(),
        const ChronicHealthConditionPage(),
        const SymptomPage(),
        const AnamnesisPage(),
        const Quiz3Page(),
        const Quiz4Page(),
        const IaPage(),
        const RecommendationPage(),
        const FinalClassificationPage(),
        const HealthProgramPage(),
        const DocumentAvaliablePage(),
      ];
    }

    //DESCOMENTAR PARA ATIVAR A CHAMADA DE VÍDEO
    //_initEngine();
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

  Future<void> _getQueue() async {
    String? serviceQueue = await UserPreferences.getQueue();
    _serviceQueue = ServiceQueueModel.fromJson(jsonDecode(serviceQueue!));
    _tutorNameController.text = _serviceQueue.tutorName!;
    _petNameController.text = _serviceQueue.petName!;
    _petNickNameController.text = _serviceQueue.petNickName!;
    _raceController.text = _serviceQueue.raceName!;
    _specieController.text = _serviceQueue.specieName!;
    _genderController.text = _serviceQueue.genderName!;
    _productController.text = _serviceQueue.productName!;
    _ageController.text = _serviceQueue.age!;
    _genderId = _serviceQueue.genderId!;
    _foodId = _serviceQueue.foodId!;
    _sizeId = _serviceQueue.sizeId;
    _temperamentId = _serviceQueue.temperamentId;
    _castrated = _serviceQueue.castrated!;
    _environmentId = _serviceQueue.environmentId;
    _specieId = _serviceQueue.specieId!;
    _raceId = _serviceQueue.raceId!;
    _coatId = _serviceQueue.coatId;

    final jsonRace = await UserPreferences.getRace();
    RaceData().raceList = (jsonDecode(jsonRace!) as List<dynamic>)
        .map((e) => RaceModel.fromJson(e))
        .toList();
    raceList = RaceData()
        .raceList
        .where((races) => races.specieId == _specieId.toString())
        .toList();

    //_coatId = (_serviceQueue.coatId == null ? 1 : _serviceQueue.coatId!);
    final jsonCoat = await UserPreferences.getCoat();
    CoatData().coatList = (jsonDecode(jsonCoat!) as List<dynamic>)
        .map((e) => CoatModel.fromJson(e))
        .toList();
    coatList = CoatData()
        .coatList
        .where((coats) => coats.specieId == _specieId.toString())
        .toList();
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

  bool _validateFields() {
    if (!(isWelcome &&
        isCompany &&
        isProduct &&
        isFaceToFaceConsultation &&
        isHealthProgram)) {
      // Se algum campo estiver vazio ou nenhum dos checkboxes estiver marcado, a validação falha

      //return false;
    }
    // Todos os campos estão preenchidos e pelo menos um dos checkboxes está marcado, a validação é bem-sucedida
    return true;
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
                child: const Column(
                  children: [
                    // Descomentar para funcionar Vídeo
                    //_videoConsultation(),
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
                      value: _selectedTypeService,
                      onChanged: (int? newCode) {
                        if (newCode != null) {
                          setState(() {
                            _selectedTypeService = newCode;
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
                              if (_currentPageIndex == 0) {
                                if (_validateFields()) {
                                  if (_currentPageIndex < _pages.length - 1) {
                                    setState(() {
                                      _currentPageIndex++;
                                    });
                                  }
                                }
                              } else {
                                if (_currentPageIndex < _pages.length - 1) {
                                  setState(() {
                                    _currentPageIndex++;
                                  });
                                }
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

class WelcomePage extends StatefulWidget {
  final Function(bool) updateCheckboxWelcome;
  final Function(bool) updateCheckboxProduct;
  final Function(bool) updateCheckboxCompany;
  final Function(bool) updateCheckboxFaceToFaceConsultation;
  final Function(bool) updateCheckboxHealthProgram;

  const WelcomePage({
    Key? key,
    required this.updateCheckboxWelcome,
    required this.updateCheckboxProduct,
    required this.updateCheckboxCompany,
    required this.updateCheckboxFaceToFaceConsultation,
    required this.updateCheckboxHealthProgram,
  }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 15.0),
            enabled: false,
            controller: _tutorNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(8.0)), // Raio dos cantos da borda
                borderSide: BorderSide(
                    color: Colors.black, width: 1.0), // Cor e largura da borda
              ),
              labelText: 'Tutor',
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 15.0),
                  enabled: false,
                  controller: _petNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Pet',
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 15.0),
                  enabled: false,
                  controller: _petNickNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Apelido',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  style: const TextStyle(fontSize: 15.0),
                  enabled: false,
                  controller: _specieController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Espécie',
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 2,
                child: TextFormField(
                  style: const TextStyle(fontSize: 15.0),
                  enabled: false,
                  controller: _raceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Raça',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            style: const TextStyle(fontSize: 15.0),
            enabled: false,
            controller: _productController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(8.0)), // Raio dos cantos da borda
                borderSide: BorderSide(
                    color: Colors.black, width: 1.0), // Cor e largura da borda
              ),
              labelText: 'Produto Contratado',
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Checkbox(
                value: isWelcome,
                onChanged: (bool? newValue) {
                  setState(() {
                    isWelcome = newValue!;
                  });
                  widget.updateCheckboxWelcome(newValue!);
                },
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isWelcome = !isWelcome;
                  });
                  widget.updateCheckboxWelcome(isWelcome);
                },
                child: const Text('Mensagem de Boas-Vindas'),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Checkbox(
                value: isCompany,
                onChanged: (bool? newValue) {
                  setState(() {
                    isCompany = newValue!;
                  });
                  widget.updateCheckboxCompany(newValue ?? false);
                },
              ),
              const Text('Informações sobre a Petner'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Checkbox(
                value: isProduct,
                onChanged: (bool? newValue) {
                  setState(() {
                    isProduct = newValue!;
                  });
                  widget.updateCheckboxProduct(newValue ?? false);
                },
              ),
              const Text('Informações sobre o Prouto Contratado'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Checkbox(
                value: isFaceToFaceConsultation,
                onChanged: (bool? newValue) {
                  setState(() {
                    isFaceToFaceConsultation = newValue!;
                  });
                  widget
                      .updateCheckboxFaceToFaceConsultation(newValue ?? false);
                },
              ),
              const Text('Informações sobre a Consulta Presencial'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Checkbox(
                value: isHealthProgram,
                onChanged: (bool? newValue) {
                  setState(() {
                    isHealthProgram = newValue!;
                  });
                  widget.updateCheckboxHealthProgram(newValue ?? false);
                },
              ),
              const Text('Informações gerais sobre Programas de Saúde'),
            ],
          ),
        ],
      ),
    );
  }
}

class UpdateRegistrationDataPage extends StatefulWidget {
  const UpdateRegistrationDataPage({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateRegistrationDataPage createState() => _UpdateRegistrationDataPage();
}

class _UpdateRegistrationDataPage extends State<UpdateRegistrationDataPage> {
  @override
  void initState() {
    super.initState();
  }

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 15.0),
            //enabled: false,
            controller: _tutorNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(8.0)), // Raio dos cantos da borda
                borderSide: BorderSide(
                    color: Colors.black, width: 1.0), // Cor e largura da borda
              ),
              labelText: 'Tutor',
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 15.0),
                  //enabled: false,
                  controller: _petNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Pet',
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 15.0),
                  //enabled: false,
                  controller: _petNickNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Apelido',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: speciesDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 3,
                child: racesDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: sizeDropdown(),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: gendersDropDown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 15.0),
                        //enabled: false,
                        controller: _ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                8.0)), // Raio dos cantos da borda
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0), // Cor e largura da borda
                          ),
                          labelText: 'Idade',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Row(
                        children: [
                          Checkbox(
                            value: isAgeReal,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isAgeReal = newValue!;
                              });
                            },
                          ),
                          const Text('Idade Real?'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: coatsDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: temperamentDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 0,
                child: Row(
                  children: [
                    Checkbox(
                      value: _castrated,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _castrated = newValue!;
                        });
                      },
                    ),
                    const Text('Castrado?'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: environmentDropdown(),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> speciesDropdown() {
    return DropdownButtonFormField<String>(
      value: _specieId.toString(),
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _specieId = int.parse(value!);
          raceList = RaceData()
              .raceList
              .where((races) => races.specieId == _specieId.toString())
              .toList();
          _raceId = int.parse(raceList.first.id);

          coatList = CoatData()
              .coatList
              .where((coats) => coats.specieId == _specieId.toString())
              .toList();
          _coatId = int.parse(coatList.first.id);

          //foodSpecie = FoodData().getFoodBySpecie(int.parse(value!));
        });
      },
      items: SpecieData().specieList.map((species) {
        return DropdownMenuItem<String>(
          value: species['id'],
          child: Text(species['name']),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Espécie',
      ),
    );
  }

  DropdownButtonFormField<String> sizeDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _sizeId = int.parse(value!);
        });
      },
      items: SizeData().sizeList.map((size) {
        return DropdownMenuItem<String>(
          value: size['id'],
          child: Text(size['name']),
        );
      }).toList(),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Porte'),
      value: (_sizeId == null ? null : _sizeId.toString()),
    );
  }

  DropdownButtonFormField<String> racesDropdown() {
    return DropdownButtonFormField<String>(
      value: _raceId.toString(),
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        _raceId = int.parse(value!);
      },
      items: raceList.map((races) {
        return DropdownMenuItem<String>(
          value: races.id.toString(),
          child: Text(races.name),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Raça',
      ),
    );
  }

  DropdownButtonFormField<String> gendersDropDown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      onChanged: (value) {
        setState(() {
          _genderId = value!;
        });
      },
      items: GenderData().genderList.map((gender) {
        return DropdownMenuItem<String>(
          value: gender['id'],
          child: Text(gender['name']),
        );
      }).toList(),
      value: _genderId,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Gênero',
      ),
    );
  }

  DropdownButtonFormField<String> coatsDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        _coatId = int.parse(value!);
      },
      items: coatList.map((coats) {
        return DropdownMenuItem<String>(
          value: coats.id.toString(),
          child: Text(coats.name),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Pelagem',
      ),
      value: (_coatId == null ? null : _coatId.toString()),
    );
  }

  DropdownButtonFormField<String> temperamentDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _temperamentId = int.parse(value!);
        });
      },
      items: TemperamentData().temperamentList.map((size) {
        return DropdownMenuItem<String>(
          value: size['id'],
          child: Text(size['name']),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Temperamento',
      ),
      value: (_temperamentId == null ? null : _temperamentId.toString()),
    );
  }

  DropdownButtonFormField<String> environmentDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _environmentId = int.parse(value!);
        });
      },
      items: EnvironmentData().environmentList.map((size) {
        return DropdownMenuItem<String>(
          value: size['id'],
          child: Text(size['name']),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Ambiente que vive',
      ),
      value: (_environmentId == null ? null : _environmentId.toString()),
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
