// ignore_for_file: library_private_types_in_public_api, library_prefixes, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'dart:html' as html;

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:petner_web/models/cityModel.dart';
import 'package:petner_web/models/coatModel.dart';
import 'package:petner_web/models/diseaseModel.dart';
import 'package:petner_web/models/petDiseaseModel.dart';
import 'package:petner_web/models/petVaccineCardModel.dart';
import 'package:petner_web/models/raceModel.dart';
import 'package:petner_web/models/serviceQueueModel.dart';
import 'package:petner_web/models/vaccineDoseModel.dart';
import 'package:petner_web/shared/data/bodyScoreData.dart';
import 'package:petner_web/shared/data/cityData.dart';
import 'package:petner_web/shared/data/coatData.dart';
import 'package:petner_web/shared/data/diseaseData.dart';
import 'package:petner_web/shared/data/environmentData.dart';
import 'package:petner_web/shared/data/foodData.dart';
import 'package:petner_web/shared/data/genderData.dart';
import 'package:petner_web/shared/data/petDiseaseData.dart';
import 'package:petner_web/shared/data/petVaccinationCardData.dart';
import 'package:petner_web/shared/data/petVaccineData.dart';
import 'package:petner_web/shared/data/raceData.dart';
import 'package:petner_web/shared/data/sizeData.dart';
import 'package:petner_web/shared/data/specieData.dart';
import 'package:petner_web/shared/data/stateData.dart';
import 'package:petner_web/shared/data/temperamentData.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:petner_web/shared/data/vaccineDoseData.dart';
import 'package:petner_web/utils/functions.dart';
import 'package:petner_web/utils/functionsRest.dart';

const appId = "a12600dd0e80435ca0a1efc4660cbe6b";
//const token = "006a12600dd0e80435ca0a1efc4660cbe6bIABA0Ug4bFpjYxdjWXx//De36mr93wxw9jsOjttA0Li+BEwKp+vpr4RpIgBOqzEBnUoEZQQAAQAtBwNlAgAtBwNlAwAtBwNlBAAtBwNl";
//const channel = "petner";
late ServiceQueueModel _serviceQueue;

// Variaveis e controlers
bool _isLoading = false;
late final String _petPhoto;
late int? _temperamentId;
late bool _castrated;
late int? _environmentId;
late int? _foodId;
late int _specieId;
late final String _bithDay;
late final String _age;
late final int _ageType;
String? _genderId;
int? _raceId;
int? _sizeId;
int? _coatId;
int? _petVaccineId;
int? _vaccineId;
String? _vaccineDoseId;
String? _diseaseId;
int? _petDiseaseId;
late String? _state;
late String? _city;
late final String _neighborhood;
late int? _bodyScoreId;
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
final TextEditingController _applicationDateController =
    TextEditingController();
final TextEditingController _brandController = TextEditingController();
final TextEditingController _veterinaryController = TextEditingController();
final TextEditingController _observationController = TextEditingController();
final TextEditingController _lotController = TextEditingController();
final TextEditingController _otherChronicDiseaseController =
    TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String? _typeRegister;
bool isWelcome = false;
bool isProduct = false;
bool isCompany = false;
bool isFaceToFaceConsultation = false;
bool isHealthProgram = false;
bool isAgeReal = false;
List<RaceModel> raceList = [];
List<CoatModel> coatList = [];
List<CityModel> listCity = [];
List<DiseaseModel> diseaseList = [];
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
    _bodyScoreId = _serviceQueue.bodyScoreId;
    _state = _serviceQueue.state;
    _city = _serviceQueue.city;

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

    final jsonDisease = await UserPreferences.getDisease();
    DiseaseData().diseaseList = (jsonDecode(jsonDisease!) as List<dynamic>)
        .map((e) => DiseaseModel.fromJson(e))
        .toList();
    diseaseList = DiseaseData()
        .diseaseList
        .where((diseases) => diseases.specieId == _specieId)
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
        await _engine.stopScreenCapture();
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
    print(
        'joined channed: _engine.joinChannel($_token, $_channel, null, ${int.parse(_crmv!)})');
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Boas-Vindas', style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(height: 10.0),
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

    _fetchCity(_state);
  }

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  Future<void> _fetchCity([String? uf]) async {
    _isLoading = true;

    List<CityModel> cityList;

    cityList = await cityListApi(uf);
    setState(() {
      CityData().cityList = cityList;
      listCity = cityList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Conferência e Atualização de Dados',
                  style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(height: 10.0),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: environmentDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: foodDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: bodyScoreDropdown(),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: stateDropdown(),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: cityDropDown(),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
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

          _foodId = null;
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

  DropdownButtonFormField<String> foodDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _foodId = int.parse(value!);
        });
      },
      items: FoodData().getFoodBySpecie(_specieId).map((size) {
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
          labelText: 'Alimentação'),
      value: (_foodId == null ? null : _foodId.toString()),
    );
  }

  DropdownButtonFormField<String> bodyScoreDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _bodyScoreId = int.parse(value!);
        });
      },
      items: BodyScoreData().bodyScoreList.map((size) {
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
          labelText: 'Score Corporal'),
      value: (_bodyScoreId == null ? null : _bodyScoreId.toString()),
    );
  }

  DropdownButtonFormField<String> stateDropdown() {
    return DropdownButtonFormField<String>(
      validator: _validateDropDown,
      isDense: true,
      onChanged: (value) {
        setState(() {
          _state = value!;

          _fetchCity(value);
          _city = null;
        });
      },
      items: StateData().getStateList().map((size) {
        return DropdownMenuItem<String>(
          value: size['uf'],
          child: Text(size['name']),
        );
      }).toList(),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Estado'),
      value: (_state == null ? null : _state.toString()),
    );
  }

  DropdownButtonFormField<String> cityDropDown() {
    return DropdownButtonFormField<String>(
      //validator: _validateDropDown,
      onChanged: (value) {
        print('city: {$value}');
        setState(() {
          _city = value!;
        });
      },
      items: listCity.map((city) {
        return DropdownMenuItem<String>(
          value: city.name,
          child: Text(city.name.toString()),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Cidade',
      ),
      value: _city,
    );
  }
}

class VaccineRegistrationPage extends StatefulWidget {
  const VaccineRegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  _VaccineRegistrationPage createState() => _VaccineRegistrationPage();
}

class _VaccineRegistrationPage extends State<VaccineRegistrationPage> {
  /*
  @override
  void initState() {
    super.initState();
  }
  */

  StateSetter? _setState;

  Future<List<dynamic>> _fetchPetVaccines() async {
    List<PetVaccineCardModel> petVaccineList;
    petVaccineList =
        await petVaccineCardListApi(_serviceQueue.petId.toString());

    return petVaccineList;
  }

  Future<List<dynamic>> _fetchPetVaccinationCard() async {
    return PetVaccinationCardData().petVaccinationCardList = PetVaccineData()
        .getVaccinationCardByVaccineId(_petVaccineId.toString());
  }

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  Future<void> _selectApplicationDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _applicationDateController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<int?> _registerVaccineDose(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerVaccineDoseApi(
        _typeRegister,
        '',
        _applicationDateController.text,
        true,
        _serviceQueue.petId.toString(),
        _petVaccineId.toString(),
        _vaccineDoseId,
        _brandController.text,
        _lotController.text,
        _veterinaryController.text,
        _observationController.text,
        '',
        '',
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterVaccineDose'];
    }

    setState(() {
      _isLoading = false;
    });

    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Vacinas', style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(width: 10.0),
          FutureBuilder<List<dynamic>>(
              future: _fetchPetVaccines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // final List<dynamic> data = snapshot.data!;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: PetVaccineData().petVaccineList.length,
                        itemBuilder: (context, index) {
                          final petVaccine =
                              PetVaccineData().petVaccineList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  150, // Defina a altura desejada para o card
                              width: double
                                  .infinity, // Defina a largura desejada para o card

                              // Estilize o card com o BoxDecoration ou o Card widget
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  //print(petVaccine.);
                                  _petVaccineId = petVaccine.petVaccineId;
                                  _vaccineId = petVaccine.vaccineId;
                                  _showVaccineDoseList(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                petVaccine.mandatory
                                                    ? '(Obrigatória)'
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: const Icon(Icons.vaccines,
                                                color: Colors.black, size: 50),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                petVaccine.vaccineName,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            if (petVaccine.totalDose == 0)
                                              Expanded(
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 241, 161, 161),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              241,
                                                              161,
                                                              161),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                      'Nenhuma Dose Aplicada'),
                                                ),
                                              )
                                            else
                                              Expanded(
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 172, 211, 243),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              81,
                                                              166,
                                                              235),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                                'Última Dose:'),
                                                            Text(petVaccine
                                                                .lastDose),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                                'Próxima Dose:'),
                                                            Text(petVaccine
                                                                .nextDose),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  void _showVaccineDoseList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            _setState = setState;
            return Dialog(
              child: Container(
                width: 600.0,
                height: 600.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.5),
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              5.0), // Arredonda apenas o canto superior esquerdo
                          topRight: Radius.circular(
                              5.0), // Arredonda apenas o canto superior direito
                        ),
                      ),
                      height: 40, // Altura desejada
                      width: double.infinity, // Ocupa todo o espaço horizontal
                      child: Row(
                        children: [
                          IconButton(
                            iconSize: 16,
                            icon: const Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            'Doses Aplicadas',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              //fontWeight: FontWeight.w600,
                              color: Colors.white, // Cor do texto em branco
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    FutureBuilder<List<dynamic>>(
                        future: _fetchPetVaccinationCard(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: PetVaccinationCardData()
                                      .petVaccinationCardList
                                      .length,
                                  itemBuilder: (context, index) {
                                    final petVaccineCard =
                                        PetVaccinationCardData()
                                            .petVaccinationCardList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            100, // Defina a altura desejada para o card
                                        width: double
                                            .infinity, // Defina a largura desejada para o card

                                        // Estilize o card com o BoxDecoration ou o Card widget
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterVaccineDosePage(myPet: widget.myPet, vaccinePetId: widget.vaccinePetId, vaccineDoseId: petVaccineCard.vaccineTypeId, typeRegister: 'U', vaccinationCardId: petVaccineCard.vaccinationCardId.toString()),
                                ),
                              ).whenComplete(() {
                                updatePetData(PetData().getPetById(myPet.id.toString()));
                              });
                              */
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      petVaccineCard
                                                          .applicationDate,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      petVaccineCard
                                                          .vaccineType,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      setState(() {
                                                        //_selectedVaccineDoseId = petVaccineCard.vaccinationCardId.toString();
                                                      });
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Form(
                                                            //key: _formKey,
                                                            child: AlertDialog(
                                                              title: const Text(
                                                                  'Excluir Dose da Vacina?'),
                                                              content: const SizedBox(
                                                                  width: double
                                                                      .maxFinite,
                                                                  child: Text(
                                                                      'A Dose será Excluída. Confirma?')),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                          'Não'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                          'Sim'),
                                                                  onPressed:
                                                                      () {
                                                                    /*
                                                                                                            _option = 'D';
                                                                                                            _registerVaccineDose(context).then(
                                                        (value) {
                                                          switch (value) {
                                                            case 0:
                                                              break;
                                                            case 1:
                                                              Navigator.of(context).pop();
                                                              break;
                                                            case 2:
                                                              showAlertDialog(context, 'Erro ao Consultar API', 0);
                                                              break;
                                                            case 3:
                                                              showAlertDialog(context, 'Erro ao chamar função API', 0);
                                                              break;
                                                            case 4:
                                                              showAlertDialog(context, 'Erro na função API', 0);
                                                              break;
                                                            default:
                                                              showAlertDialog(context, 'Erro ao Excluir Vacina', 0);
                                                              break;
                                                          }
                                                        },
                                                                                                            );
                                                                                                            */
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      // Ação ao pressionar o botão de lixeira
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        }),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              //_fetchVaccineType(_petVaccineId.toString());
                              _applicationDateController.text = '';
                              _brandController.text = '';
                              _lotController.text = '';
                              _veterinaryController.text = '';
                              _observationController.text = '';
                              _showRegisterVaccineDose(context);
                            },
                            child: const Text('Adicionar Dose'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showRegisterVaccineDose(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 450,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.5),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                5.0), // Arredonda apenas o canto superior esquerdo
                            topRight: Radius.circular(
                                5.0), // Arredonda apenas o canto superior direito
                          ),
                        ),
                        height: 40, // Altura desejada
                        width:
                            double.infinity, // Ocupa todo o espaço horizontal
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: 16,
                              icon: const Icon(Icons.close),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const Text(
                              'Cadastrar Dose',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                //fontWeight: FontWeight.w600,
                                color: Colors.white, // Cor do texto em branco
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: <Widget>[
                              FutureBuilder<List<VaccineDoseModel>>(
                                future: vaccineDoseListApi(
                                    _serviceQueue.petId.toString(),
                                    _vaccineId
                                        .toString()), // Função para buscar os dados da API VaccineType
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<VaccineDoseModel>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    List<VaccineDoseModel> vaccineDose =
                                        snapshot.data!;
                                    return DropdownButtonFormField<String>(
                                      hint: const Text('Selecione uma Dose'),
                                      value: _vaccineDoseId,
                                      validator: _validateDropDown,
                                      items: vaccineDose.map((vaccineDose) {
                                        return DropdownMenuItem<String>(
                                          value: vaccineDose.vaccineDoseId
                                              .toString(),
                                          child: Text(vaccineDose.name),
                                        );
                                      }).toList(),
                                      onChanged: (String? selectedValue) {
                                        _vaccineDoseId = selectedValue;
                                        // Ação a ser executada quando um item for selecionado no dropdown
                                        if (selectedValue != null) {
                                          // Faça algo com o valor selecionado
                                          print(selectedValue);
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Vacina',
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Erro ao carregar os dados');
                                  } else {
                                    _vaccineDoseId = null;
                                    return Container(
                                      width: 5,
                                      color: Colors.black.withOpacity(0.5),
                                      child: const Center(
                                        heightFactor: 1,
                                        widthFactor: 1,
                                        child: CircularProgressIndicator(
                                            color: Colors.black),
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Data Aplicação',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () =>
                                        _selectApplicationDate(context),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8.0)), // Raio dos cantos da borda
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                ),
                                controller: _applicationDateController,
                                readOnly: true,
                                onTap: () => _selectApplicationDate(context),
                                validator: (input) => input?.isEmpty == true
                                    ? 'Informar a Data da Aplicação'
                                    : null,
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _brandController,
                                decoration: const InputDecoration(
                                  labelText: 'Marca da Vacina',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8.0)), // Raio dos cantos da borda
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _lotController,
                                decoration: const InputDecoration(
                                  labelText: 'Lote da Vacina',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8.0)), // Raio dos cantos da borda
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _veterinaryController,
                                decoration: const InputDecoration(
                                  labelText: 'Veterinário que Aplicou',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8.0)), // Raio dos cantos da borda
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                maxLines: null,
                                controller: _observationController,
                                decoration: const InputDecoration(
                                  labelText: 'Observação',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8.0)), // Raio dos cantos da borda
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _setState!(() {
                                  _fetchPetVaccinationCard();
                                  print(
                                      'y ${PetVaccinationCardData().petVaccinationCardList.length}');
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                            const SizedBox(width: 10.0),
                            ElevatedButton(
                              onPressed: () {
                                _typeRegister = 'C';
                                if (_formKey.currentState!.validate()) {
                                  _registerVaccineDose(context).then(
                                    (value) {
                                      switch (value) {
                                        case 0:
                                          break;
                                        case 1:
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          break;
                                        case 2:
                                          showAlertDialog(context,
                                              'Erro ao Consultar API', 0);
                                          break;
                                        case 3:
                                          showAlertDialog(context,
                                              'Erro ao chamar função API', 0);
                                          break;
                                        case 4:
                                          showAlertDialog(
                                              context, 'Erro na função API', 0);
                                          break;
                                        default:
                                          showAlertDialog(context,
                                              'Erro ao Adicionar Vacina', 0);
                                          break;
                                      }
                                    },
                                  );
                                } else {
                                  print('Falta informação');
                                }
                              },
                              child: const Text('Cadastrar'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ChronicHealthConditionPage extends StatefulWidget {
  const ChronicHealthConditionPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChronicHealthConditionPage createState() => _ChronicHealthConditionPage();
}

class _ChronicHealthConditionPage extends State<ChronicHealthConditionPage> {
  bool _isotherChronicDiseaseVisible = false;

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  Future<List<dynamic>> _fetchPetDiseaes() async {
    List<PetDiseaseModel> petDiseaseList;
    petDiseaseList =
        await petDiseaseListApi(_serviceQueue.petId.toString(), true);

    return petDiseaseList;
  }

  Future<int?> _registerChronicDisease(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerDiseaseApi(
        _typeRegister,
        _serviceQueue.petId.toString(),
        _diseaseId,
        _otherChronicDiseaseController.text,
        true,
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterChronicDisease'];
    }

    setState(() {
      _isLoading = false;
    });

    return 4;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Condições Crônicas de Saúde',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 206, 205, 205)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.5),
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      5.0), // Arredonda apenas o canto superior esquerdo
                                  topRight: Radius.circular(
                                      5.0), // Arredonda apenas o canto superior direito
                                ),
                              ),
                              height: 40, // Altura desejada
                              width: double
                                  .infinity, // Ocupa todo o espaço horizontal
                              child: const Text(
                                'Doenças Crônicas',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.white, // Cor do texto em branco
                                ),
                              ),
                            ),
                            // colocar lista

                            FutureBuilder<List<dynamic>>(
                                future: _fetchPetDiseaes(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          itemCount: PetDiseaseData()
                                              .petDiseaseList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final petDisease = PetDiseaseData()
                                                .petDiseaseList[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height:
                                                    50, // Defina a altura desejada para o card
                                                width: double
                                                    .infinity, // Defina a largura desejada para o card

                                                // Estilize o card com o BoxDecoration ou o Card widget
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    //print(petVaccine.);
                                                    _petDiseaseId =
                                                        petDisease.petDiseaseId;
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            /*
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: const Icon(
                                                                  Icons
                                                                      .health_and_safety,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 50),
                                                            ),
                                                            */
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        0.0),
                                                                child: Text(
                                                                  petDisease
                                                                      .name!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom:
                            10, // Define a posição do botão a partir do fundo
                        right:
                            10, // Define a posição do botão a partir da direita
                        child: ElevatedButton(
                          onPressed: () {
                            _showChronicDisease(context);
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 206, 205, 205)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.5),
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      5.0), // Arredonda apenas o canto superior esquerdo
                                  topRight: Radius.circular(
                                      5.0), // Arredonda apenas o canto superior direito
                                ),
                              ),
                              height: 40, // Altura desejada
                              width: double
                                  .infinity, // Ocupa todo o espaço horizontal
                              child: const Text(
                                'Medicamentos de Uso Contínuo',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.white, // Cor do texto em branco
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom:
                            10, // Define a posição do botão a partir do fundo
                        right:
                            10, // Define a posição do botão a partir da direita
                        child: ElevatedButton(
                          onPressed: () {
                            // Adicionar ação de "Adicionar" aqui
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 206, 205, 205)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.5),
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      5.0), // Arredonda apenas o canto superior esquerdo
                                  topRight: Radius.circular(
                                      5.0), // Arredonda apenas o canto superior direito
                                ),
                              ),
                              height: 40, // Altura desejada
                              width: double
                                  .infinity, // Ocupa todo o espaço horizontal
                              child: const Text(
                                'Alergias',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.white, // Cor do texto em branco
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom:
                            10, // Define a posição do botão a partir do fundo
                        right:
                            10, // Define a posição do botão a partir da direita
                        child: ElevatedButton(
                          onPressed: () {
                            // Adicionar ação de "Adicionar" aqui
                          },
                          child: const Icon(Icons.add),
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
    );
  }

  void _showChronicDisease(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 450,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.5),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                5.0), // Arredonda apenas o canto superior esquerdo
                            topRight: Radius.circular(
                                5.0), // Arredonda apenas o canto superior direito
                          ),
                        ),
                        height: 40, // Altura desejada
                        width:
                            double.infinity, // Ocupa todo o espaço horizontal
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: 16,
                              icon: const Icon(Icons.close),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const Text(
                              'Doenças Crônicas',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                //fontWeight: FontWeight.w600,
                                color: Colors.white, // Cor do texto em branco
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: <Widget>[
                              
                              CustomSearchableDropDown(
                                dropdownHintText: 'Procurar uma Doença',
                                label: 'Selecione uma Doença',
                                hint: 'Selecione uma Doença',
                                prefixIcon: Icon(Icons.search),
                                //value: _diseaseId,
                                //validator: _validateDropDown,
                                items: diseaseList
                                    .where((diseases) =>
                                        diseases.chronic == true ||
                                        diseases.id == '171')
                                    .toList(),
                                dropDownMenuItems: diseaseList
                                    .where((diseases) =>
                                        diseases.chronic == true ||
                                        diseases.id == '171')
                                    .map((item) {
                                  return item.name;
                                }).toList(),
                                menuMode: true,
                                onChanged: (value) {
                                  print(value.name);
                                  if (value != null) {
                                    _diseaseId = value.id;
                                  } else {
                                    _diseaseId = null;
                                  }
                                  
                                  if (_diseaseId == '171') {
                                    setState(() {
                                      _isotherChronicDiseaseVisible = true;
                                    });
                                  }else{
                                    setState(() {
                                      _isotherChronicDiseaseVisible = false;
                                    });
                                  }
                                },
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                              ),
                              const SizedBox(height: 10.0),
                              Visibility(
                                visible: _isotherChronicDiseaseVisible,
                                child: TextFormField(
                                  controller: _otherChronicDiseaseController,
                                  decoration: const InputDecoration(
                                    labelText: 'Outra Doença Crônica',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              8.0)), // Raio dos cantos da borda
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                            const SizedBox(width: 10.0),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _typeRegister = 'C';
                                  _registerChronicDisease(context)
                                      .then((value) {});
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text('Cadastrar'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SymptomPage extends StatefulWidget {
  const SymptomPage({
    Key? key,
  }) : super(key: key);

  @override
  _SymptomPage createState() => _SymptomPage();
}

class _SymptomPage extends State<SymptomPage> {
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

class AnamnesisPage extends StatefulWidget {
  const AnamnesisPage({
    Key? key,
  }) : super(key: key);

  @override
  _AnamnesisPage createState() => _AnamnesisPage();
}

class _AnamnesisPage extends State<AnamnesisPage> {
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

class Quiz3Page extends StatefulWidget {
  const Quiz3Page({
    Key? key,
  }) : super(key: key);

  @override
  _Quiz3Page createState() => _Quiz3Page();
}

class _Quiz3Page extends State<Quiz3Page> {
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

class Quiz4Page extends StatefulWidget {
  const Quiz4Page({
    Key? key,
  }) : super(key: key);

  @override
  _Quiz4Page createState() => _Quiz4Page();
}

class _Quiz4Page extends State<Quiz4Page> {
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

class IaPage extends StatefulWidget {
  const IaPage({
    Key? key,
  }) : super(key: key);

  @override
  _IaPage createState() => _IaPage();
}

class _IaPage extends State<IaPage> {
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

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({
    Key? key,
  }) : super(key: key);

  @override
  _RecommendationPage createState() => _RecommendationPage();
}

class _RecommendationPage extends State<RecommendationPage> {
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

class FinalClassificationPage extends StatefulWidget {
  const FinalClassificationPage({
    Key? key,
  }) : super(key: key);

  @override
  _FinalClassificationPage createState() => _FinalClassificationPage();
}

class _FinalClassificationPage extends State<FinalClassificationPage> {
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

class HealthProgramPage extends StatefulWidget {
  const HealthProgramPage({
    Key? key,
  }) : super(key: key);

  @override
  _HealthProgramPage createState() => _HealthProgramPage();
}

class _HealthProgramPage extends State<HealthProgramPage> {
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

class DocumentAvaliablePage extends StatefulWidget {
  const DocumentAvaliablePage({
    Key? key,
  }) : super(key: key);

  @override
  _DocumentAvaliablePage createState() => _DocumentAvaliablePage();
}

class _DocumentAvaliablePage extends State<DocumentAvaliablePage> {
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
