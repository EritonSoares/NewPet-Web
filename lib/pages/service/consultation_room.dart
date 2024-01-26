// ignore_for_file: library_private_types_in_public_api, library_prefixes, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:petner_web/custom/custom_appbar.dart';
import 'package:petner_web/custom/custom_drawer.dart';
import 'dart:html' as html;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:petner_web/models/cityModel.dart';
import 'package:petner_web/models/coatModel.dart';
import 'package:petner_web/models/consultChatGPTModel.dart';
import 'package:petner_web/models/consultationModel.dart';
import 'package:petner_web/models/diseaseModel.dart';
import 'package:petner_web/models/examModel.dart';
import 'package:petner_web/models/healthProgramModel.dart';
import 'package:petner_web/models/medicineModel.dart';
import 'package:petner_web/models/petAllergyModel.dart';
import 'package:petner_web/models/petDiseaseModel.dart';
import 'package:petner_web/models/petDiseaseServiceModel.dart';
import 'package:petner_web/models/petForwardingModel.dart';
import 'package:petner_web/models/petHealthProgramModel.dart';
import 'package:petner_web/models/petMedicineModel.dart';
import 'package:petner_web/models/petModel.dart';
import 'package:petner_web/models/petSericeHistoryModel.dart';
import 'package:petner_web/models/petSymptomModel.dart';
import 'package:petner_web/models/petVaccineCardModel.dart';
import 'package:petner_web/models/raceModel.dart';
import 'package:petner_web/models/serviceQueueModel.dart';
import 'package:petner_web/models/symptomModel.dart';
import 'package:petner_web/models/petVaccineDoseModel.dart';
import 'package:petner_web/models/vaccineDoseModel.dart';
import 'package:petner_web/models/vaccineModel.dart';
import 'package:petner_web/shared/data/anexoServiceHistoryData.dart';
import 'package:petner_web/shared/data/bodyScoreData.dart';
import 'package:petner_web/shared/data/cityData.dart';
import 'package:petner_web/shared/data/coatData.dart';
import 'package:petner_web/shared/data/consultChatGPTData.dart';
import 'package:petner_web/shared/data/consultationData.dart';
import 'package:petner_web/shared/data/diseaseData.dart';
import 'package:petner_web/shared/data/environmentData.dart';
import 'package:petner_web/shared/data/examData.dart';
import 'package:petner_web/shared/data/foodData.dart';
import 'package:petner_web/shared/data/genderData.dart';
import 'package:petner_web/shared/data/healthProgramData.dart';
import 'package:petner_web/shared/data/medicineData.dart';
import 'package:petner_web/shared/data/petAllergyData.dart';
import 'package:petner_web/shared/data/petData.dart';
import 'package:petner_web/shared/data/petDiseaseData.dart';
import 'package:petner_web/shared/data/petDiseaseServiceData.dart';
import 'package:petner_web/shared/data/petForwardingData.dart';
import 'package:petner_web/shared/data/petHealthProgramData.dart';
import 'package:petner_web/shared/data/petMedicineData.dart';
import 'package:petner_web/shared/data/petServiceHIstoryData.dart';
import 'package:petner_web/shared/data/petSymptomData.dart';
import 'package:petner_web/shared/data/petVaccinationCardData.dart';
import 'package:petner_web/shared/data/petVaccineData.dart';
import 'package:petner_web/shared/data/raceData.dart';
import 'package:petner_web/shared/data/sizeData.dart';
import 'package:petner_web/shared/data/specieData.dart';
import 'package:petner_web/shared/data/stateData.dart';
import 'package:petner_web/shared/data/symptomData.dart';
import 'package:petner_web/shared/data/temperamentData.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:petner_web/shared/data/vaccineData.dart';
import 'package:petner_web/shared/data/petVaccineDoseData.dart';
import 'package:petner_web/shared/data/vaccineDoseData.dart';
import 'package:petner_web/utils/functions.dart';
import 'package:petner_web/utils/functionsRest.dart';
import 'package:petner_web/utils/routes.dart';

const appId = "c1dc5ada18ed420a8fd3ef4b24ecc6c8";
//const token = "006a12600dd0e80435ca0a1efc4660cbe6bIABA0Ug4bFpjYxdjWXx//De36mr93wxw9jsOjttA0Li+BEwKp+vpr4RpIgBOqzEBnUoEZQQAAQAtBwNlAgAtBwNlAwAtBwNlBAAtBwNl";
//const channel = "petner";
late ServiceQueueModel _serviceQueue;

// Variaveis e controlers
int _selectedTypeService = 1;
bool _isLoading = false;
late final String _petPhoto;
late int? _temperamentId;
late bool _castrated;
late int? _environmentId;
late int? _foodId;
late int _specieId;
late final String _bithDay;
String? _age;
late final int _ageType;
String? _genderId;
int? _raceId;
int? _sizeId;
int? _coatId;
int? _petVaccineId;
int? _vaccineId;
int? _serviceHistoryId;
int? _petForwardingId;
String? _petVaccineDoseId;
String? _vaccineDoseId;
String? _diseaseId;
int? _petDiseaseId;
int? _petDiseaseServiceId;
int? _healthProgramId;
String? _medicineId;
int? _forwardingId;
int? _petMedicineId;
int? _petAllergyId;
int? _symptomId;
int? _petSymptomId;
String? _petHealthProgramId;
int? _chatGPTId;
bool? _complaint;
String? _veterinaryId;
String? _veterinary;
String? _crmv;
late String? _state;
late String? _city;
late final String _neighborhood;
late int? _bodyScoreId;
late final int _productId;
final TextEditingController _tutorNameController = TextEditingController();
final TextEditingController _petNameController = TextEditingController();
final TextEditingController _petPlanController = TextEditingController();
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
final TextEditingController _otherDiseaseController = TextEditingController();
final TextEditingController _otherMedicineController = TextEditingController();
final TextEditingController _otherSymptomController = TextEditingController();
final TextEditingController _allergyController = TextEditingController();
final TextEditingController _complaintController = TextEditingController();
final TextEditingController _amountMedicineController = TextEditingController();
final TextEditingController _dosageController = TextEditingController();
final TextEditingController _finalGuidelinesController =
    TextEditingController();
final TextEditingController _birthdayController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<FormState> _formKeyUpdateRegistrationDataPage =
    GlobalKey<FormState>();
String? _typeRegister;
bool isWelcome = false;
bool isProduct = false;
bool isCompany = false;
bool isRefusedHospital = false;
bool isFaceToFaceConsultation = false;
bool isHealthProgram = false;
bool _isAgeReal = false;
bool _continuousUse = false;
bool _isComplaint = false;
bool _isQuestionComplaintVisible = false;
bool _isCheckOut = false;
List<RaceModel> raceList = [];
List<CoatModel> coatList = [];
List<CityModel> listCity = [];
List<DiseaseModel> diseaseList = [];
List<MedicineModel> medicineList = [];
List<SymptomModel> symptomList = [];
List<VaccineModel> vaccineList = [];
List<VaccineDoseModel> vaccineDoseList = [];
List<ExamModel> examList = [];
List<ConsultationModel> consultationList = [];

//List<HealthProgramModel> healthProgramList = [];
int? appetitId;
int? typePrescriptionId;
int? typeForwardingId;
int? useTypeId;
int? waterIntakeId;
int? urineStainingId;
int? urineVolumeId;
int? stoolColoringId;
int? stoolConsistencyId;
int? noseTypeId;
int? noseTemperatureId;
int? hotEarId;
int? restlessId;
int? gasesId;
int? tightBellyId;
int? touchPainId;
int? walksBentOverId;
int? gumTongueId;
int? conjunctivaId;
int? hairLossId;
int? dullHairId;
int? abnormalPlacementId;
int? hairFailureId;
int? brittleHairId;
int? bodyStateId;
int? bodyScoreId;
int? finalClassificationId;
int? reasonRefusedHospitalId;
String _textValidation = '';
int seconds = 0;
int minutes = 0;
int hours = 0;
String? _option;
bool? validationEmergency;
bool _isEmergency = false;
bool _isHospitalAddress = false;
bool _isRemoteAudio = true;
int? hospitalId;
String? hospitalAddress = 'Teste';
int xteste = 0;

late TabController _tabController;
bool _isTabValid = true;

class ConsultationRoomPage extends StatefulWidget {
  const ConsultationRoomPage({super.key});

  @override
  _ConsultationRoomPageState createState() => _ConsultationRoomPageState();
}

class _ConsultationRoomPageState extends State<ConsultationRoomPage> {
  late RtcEngine _engine;
  late final List<Map<int, String>> typeService;
  late List<Map<int, String>> consultaOptions;
  List<Widget> _pages = [];
  late List<bool Function()> _validationFunctions;
  int _currentPageIndex = 0;
  late String? _token, _channel, _crmv;
  bool _isEnabledVirtualBackgroundImage = false;
  bool isJoined = false;
  bool enabledAudio = true, enableCamera = true, shareScreen = false;
  int? _remoteUid;
  String? formattedTime =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();

    _isEmergency = false;

    _resetVariable();

    _roomConfiguration();

    _getQueue().then((value) {
      validationEmergency = false;

      consultaOptions = [
        {1: 'Atendimento de Boas Vindas'},
        {2: 'Consulta por Queixa'},
        {3: 'Consulta'},
        {4: 'Tele Orientação'},
        {5: 'Acompanhamento de Evolução'},
        {6: 'Consulta de Rotina'},
        {7: 'Consulta Dominiciliar Inicial'},
        {8: 'Consulta Dominiciliar'},
        {100: 'Finalização'},
      ];

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            seconds++;
            if (seconds == 60) {
              seconds = 0;
              minutes++;
            }
            if (minutes == 60) {
              minutes = 0;
              hours++;
            }

            formattedTime =
                '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

/*
            if (seconds % 7 == 0 && !isJoined) {
              print(
                  'Não conectou no canal. tentando reconexão às $formattedTime');
              _dispose2().then((value) {
                print('____________ Camera _____________');
                html.window.navigator.getUserMedia(audio: true, video: true);
                print('____________ iniEngine _____________');
                _initEngine();
              });
              //print('____________ _joinChannel _____________');
              //_joinChannel();
              //print('____________ XXXXXX _____________');
            }
*/

          });

          //isJoined
        }
      });

/*
    if (_serviceQueue.queueTypeId == 1) {
      
    }
*/
      _selectedTypeService = _serviceQueue.queueTypeId;

      _validateTypeService();

      _isCheckOut = false;

      //Descomentar PARA ATIVAR A CHAMADA DE VÍDEO
      _initEngine();
    });
  }

  void _resetVariable() {
    _tutorNameController.text = '';
    _petNameController.text = '';
    _petPlanController.text = '';
    _petNickNameController.text = '';
    _raceController.text = '';
    _specieController.text = '';
    _genderController.text = '';
    _screningController.text = '';
    _productController.text = '';
    _ageController.text = '';
    _applicationDateController.text = '';
    _brandController.text = '';
    _veterinaryController.text = '';
    _observationController.text = '';
    _lotController.text = '';
    _otherChronicDiseaseController.text = '';
    _otherDiseaseController.text = '';
    _otherMedicineController.text = '';
    _otherSymptomController.text = '';
    _allergyController.text = '';
    _complaintController.text = '';
    _finalGuidelinesController.text = '';
    _birthdayController.text = '';

    _complaint = null;

    appetitId = null;
    waterIntakeId = null;
    urineStainingId = null;
    urineVolumeId = null;
    stoolColoringId = null;
    stoolConsistencyId = null;
    noseTypeId = null;
    noseTemperatureId = null;
    hotEarId = null;
    restlessId = null;
    gasesId = null;
    tightBellyId = null;
    touchPainId = null;
    walksBentOverId = null;
    gumTongueId = null;
    conjunctivaId = null;
    hairLossId = null;
    dullHairId = null;
    abnormalPlacementId = null;
    hairFailureId = null;
    brittleHairId = null;
    bodyStateId = null;
    bodyScoreId = null;
    finalClassificationId = null;

    seconds = 0;
    minutes = 0;
    hours = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  void _validateTypeService() {
    _currentPageIndex = 0;
    if (_selectedTypeService == 1) {
      _isQuestionComplaintVisible = true;
      _isComplaint = false;
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
        const AnamnesisPage(),
        const HealthProgramPage(),
        const FinalGuidelinesPage(),
        //const FinalClassificationPage(),
        //const DocumentAvaliablePage(),
      ];
      _validationFunctions = [
        _validateWelcome,
        _validateUpdateRegistrationData,
        _validateNothing,
        _validateNothing,
        _validateAnamnesisPage,
        _validateNothing,
        _validateFinalGuidelines,
      ];
    } else if (_selectedTypeService == 2) {
      _isQuestionComplaintVisible = false;
      _isComplaint = true;
      _pages = [
        const RiskClassificationPage(),
        const UpdateRegistrationDataPage(),
        const VaccineRegistrationPage(),
        const ChronicHealthConditionPage(),
        const ServiceHistoryPage(),
        const HealthProgramPagePet(),
        const AnamnesisPage(),
        const DiagnosticClosure(),
        const PrescriptionReferralPage(),
        const FinalGuidelinesPage(),
      ];

      _validationFunctions = [
        _validateNothing,
        _validateUpdateRegistrationData,
        _validateNothing,
        _validateNothing,
        _validateNothing,
        _validateNothing,
        _validateAnamnesisPage,
        _validateNothing,
        _validateNothing,
        _validateFinalGuidelines,
      ];

      if (_serviceQueue.screeningName != null) {
        _screningController.text = _serviceQueue.screeningName!;
      }
    } else if (_selectedTypeService == 4) {
      _isQuestionComplaintVisible = false;
      _isComplaint = true;
      _pages = [
        const RiskClassificationPage(),
        const UpdateRegistrationDataPage(),
        const VaccineRegistrationPage(),
        const ChronicHealthConditionPage(),
        const ServiceHistoryPage(),
        const HealthProgramPagePet(),
        const AnamnesisPage(),
        const FinalGuidelinesPage(),
      ];

      _validationFunctions = [
        _validateNothing,
        _validateUpdateRegistrationData,
        _validateNothing,
        _validateNothing,
        _validateNothing,
        _validateNothing,
        _validateAnamnesisPage,
        _validateFinalGuidelines,
      ];

      _screningController.text = _serviceQueue.screeningName!;
    } else if (_selectedTypeService == 100) {
      _pages = [
        const CheckoutPage(),
      ];

      _screningController.text = _serviceQueue.screeningName!;
    }
  }

  bool _validateNothing() {
    //print('nothing');
    return true;
  }

  bool _validateWelcome() {
    bool validation = true;

    _textValidation = '';

    if (!isWelcome) {
      _textValidation += 'Mensagem de Boas-Vindas\n';
      validation = false;
    }

    if (!isCompany) {
      _textValidation += 'Informações sobre a Petner\n';
      validation = false;
    }

    if (!isProduct) {
      _textValidation += 'Informações sobre o Prouto Contratado\n';
      validation = false;
    }

    if (!isFaceToFaceConsultation) {
      _textValidation += 'Informações sobre a Consulta Presencial\n';
      validation = false;
    }

    if (!isHealthProgram) {
      _textValidation += 'Informações gerais sobre Programas de Saúde\n';
      validation = false;
    }

    return validation;
  }

  bool _validateUpdateRegistrationData() {
    //print('sssssssssssssssssssssss');
    bool validation = true;

    _textValidation = '';

    if (_tutorNameController.text.isEmpty) {
      _textValidation += 'Nome Tutor\n';
      validation = false;
    }

    if (_petNameController.text.isEmpty) {
      _textValidation += 'Nome do Pet\n';
      validation = false;
    }

    if (_birthdayController.text.isEmpty) {
      _textValidation += 'Data de Nascimento\n';
      validation = false;
    }

    if (_sizeId == null) {
      _textValidation += 'Porte\n';
      validation = false;
    }

    if (_coatId == null) {
      _textValidation += 'Pelagem\n';
      validation = false;
    }

    if (_temperamentId == null) {
      _textValidation += 'Temperamento\n';
      validation = false;
    }

    if (_environmentId == null) {
      _textValidation += 'Ambiente que vive\n';
      validation = false;
    }

    if (_foodId == null) {
      _textValidation += 'Alimentação\n';
      validation = false;
    }

    if (_bodyScoreId == null) {
      _textValidation += 'Score Corporal\n';
      validation = false;
    }

    if (validation) {
      _fetchRegisterPet(
        _serviceQueue.petId,
        _petNameController.text,
        _petNickNameController.text,
        _specieId,
        _raceId!,
        _genderId!,
        _birthdayController.text,
        _sizeId!,
        _coatId!,
        _temperamentId!,
        _environmentId!,
        _foodId!,
        _bodyScoreId!,
        _isAgeReal,
        _castrated,
      );
    }

    return validation;
  }

  Future<void> _fetchRegisterPet(
    int? petId,
    String? petName,
    String? petNickName,
    int? specieId,
    int? raceId,
    String? genderId,
    String? birthday,
    int? sizeId,
    int? coatId,
    int? temperamentId,
    int? environmentId,
    int? foodId,
    int? bodyScore,
    bool? birthType,
    bool? castrated,
  ) async {
    Map<String, dynamic> responseData = await registerPetApi(
      'U',
      petId!,
      _serviceQueue.tutorId!,
      petName!.trim(),
      petNickName!.trim(),
      specieId.toString(),
      raceId.toString(),
      genderId!,
      birthday!,
      '',
      foodId.toString(),
      temperamentId.toString(),
      environmentId.toString(),
      '0',
      sizeId.toString(),
      coatId.toString(),
      bodyScore.toString(),
      birthType!,
      castrated!,
      '',
      '',
    );
  }

  bool _validateAnamnesisPage() {
    bool validation = true;

    if (_isComplaint) {
      _textValidation = '';

      if (_complaintController.text.isEmpty) {
        _textValidation += 'Informe a Queixa\n';
        validation = false;
      }

      if (appetitId == null) {
        _textValidation += 'Como está o Apetite e Alimentação?\n';
        validation = false;
      }

      if (waterIntakeId == null) {
        _textValidation += 'Como está a ingestão de água?\n';
        validation = false;
      }

      if (urineStainingId == null) {
        _textValidation += 'Qual a coloração da Urina?\n';
        validation = false;
      }

      if (urineVolumeId == null) {
        _textValidation += 'Qual o volume de urina?\n';
        validation = false;
      }

      if (stoolColoringId == null) {
        _textValidation += 'Qual a coloração das fezes?\n';
        validation = false;
      }

      if (stoolConsistencyId == null) {
        _textValidation += 'Qual é a consistência das fezes?\n';
        validation = false;
      }

      if (noseTypeId == null) {
        _textValidation += 'O nariz do PET está seco?\n';
        validation = false;
      }

      if (noseTemperatureId == null) {
        _textValidation += 'O nariz está quente ou frio?\n';
        validation = false;
      }

      if (hotEarId == null) {
        _textValidation += 'A orelha do pet está quente?\n';
        validation = false;
      }

      if (gasesId == null) {
        _textValidation += 'O pet está soltando muitos gases?\n';
        validation = false;
      }

      if (tightBellyId == null) {
        _textValidation += 'Apresenta barriga enrijecida?\n';
        validation = false;
      }

      if (touchPainId == null) {
        _textValidation += 'Apresenta dor ao toque?\n';
        validation = false;
      }

      if (walksBentOverId == null) {
        _textValidation += 'Apresenta andar curvado?\n';
        validation = false;
      }

      if (conjunctivaId == null) {
        _textValidation += 'Inspeção através da câmera: conjuntiva\n';
        validation = false;
      }

      if (gumTongueId == null) {
        _textValidation += 'Inspeção através da câmera: Língua, gengiva\n';
        validation = false;
      }

      if (hairLossId == null) {
        _textValidation += 'Apresenta queda de pelo fora do comum?\n';
        validation = false;
      }

      if (abnormalPlacementId == null) {
        _textValidation +=
            'Apresenta coloração de pele fora do normal em alguma área?\n';
        validation = false;
      }

      if (bodyStateId == null) {
        _textValidation +=
            'Qual a sua avaliação do estado corporal do seu pet?\n';
        validation = false;
      }

      if (bodyScoreId == null) {
        _textValidation += 'Inspeção através da câmera: Score corporal\n';
        validation = false;
      }

      if (PetSymptomData().petSymptomList.isEmpty) {
        _textValidation += 'Inserir possíveis Sintomas na aba SINTOMA\n';
        validation = false;
      }
    } else {
      _textValidation = '';
      if (_complaint == null) {
        _textValidation += 'Selecionar Sim ou Não na pergunta\n';
        validation = false;
      }
    }

    if (validation) {
      _fetchRegisterAnamnese(
        _serviceQueue.queueId,
        _complaint == true || _complaint == null
            ? _complaintController.text
            : '',
        appetitId,
        waterIntakeId,
        urineStainingId,
        urineVolumeId,
        stoolColoringId,
        stoolConsistencyId,
        noseTypeId,
        noseTemperatureId,
        hotEarId,
        gasesId,
        tightBellyId,
        touchPainId,
        walksBentOverId,
        conjunctivaId,
        gumTongueId,
        hairLossId,
        hairFailureId,
        abnormalPlacementId,
        bodyStateId,
        bodyScoreId,
        restlessId,
        dullHairId,
        brittleHairId,
      );
    }

    return validation;
  }

  Future<void> _fetchRegisterAnamnese(
    int? queueId,
    String? complaint,
    int? appetit,
    int? waterIntake,
    int? urineStaining,
    int? urineVolume,
    int? stoolColoring,
    int? stoolConsistency,
    int? noseType,
    int? noseTemperature,
    int? hotEar,
    int? gases,
    int? tightBelly,
    int? touchPain,
    int? walksBentOver,
    int? conjunctivaId,
    int? gumTongueId,
    int? hairLossId,
    int? hairFailureId,
    int? abnormalPlacementId,
    int? bodyStateId,
    int? bodyScoreId,
    int? restlessId,
    int? dullHairId,
    int? brittleHairId,
  ) async {
    Map<String, dynamic> responseData = await registerAnamneseApi(
      queueId,
      complaint,
      appetit,
      waterIntake,
      urineStaining,
      urineVolume,
      stoolColoring,
      stoolConsistency,
      noseType,
      noseTemperature,
      hotEar,
      gases,
      tightBelly,
      touchPain,
      walksBentOver,
      conjunctivaId,
      gumTongueId,
      hairLossId,
      hairFailureId,
      abnormalPlacementId,
      bodyStateId,
      bodyScoreId,
      restlessId,
      dullHairId,
      brittleHairId,
    );
  }

  bool _validateFinalGuidelines() {
    bool validation = true;

    _textValidation = '';

    //print(finalClassificationId);
    if (finalClassificationId == null) {
      _textValidation += 'Classificação Final\n';
      validation = false;
    }

    if (finalClassificationId == 2 &&
        _serviceQueue.emergencyReleased! == true &&
        hospitalId == null) {
      _textValidation += 'Hospital para Emergência\n';
      validation = false;
    }

    if (_finalGuidelinesController.text.isEmpty) {
      _textValidation += 'Orientações Finais\n';
      validation = false;
    }

    if (validation) {
      _fetchRegisterFinalGuidelines(
        _serviceQueue.queueId,
        finalClassificationId.toString(),
        _finalGuidelinesController.text,
        hospitalId,
      );
    }

    return validation;
  }

  Future<void> _fetchRegisterFinalGuidelines(
    int? queueId,
    String? finalClassificationId,
    String? finalGuideliness,
    int? hospitalId,
  ) async {
    Map<String, dynamic> responseData = await registerFinalGuidelinesApi(
        queueId,
        finalClassificationId,
        finalGuideliness,
        hospitalId,
        isRefusedHospital,
        reasonRefusedHospitalId);
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
    if (_serviceQueue.plan!.isNotEmpty) {
      _petPlanController.text = _serviceQueue.plan!;
    }

    _petNickNameController.text = _serviceQueue.petNickName!;
    _birthdayController.text = _serviceQueue.birthDay!;
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

    final jsonMedicine = await UserPreferences.getMedicine();
    MedicineData().medicineList = (jsonDecode(jsonMedicine!) as List<dynamic>)
        .map((e) => MedicineModel.fromJson(e))
        .toList();
    medicineList = MedicineData()
        .medicineList
        .where((medicines) => medicines.specieId == _specieId)
        .toList();

    final jsonSymptom = await UserPreferences.getSymptom();
    SymptomData().symptomList = (jsonDecode(jsonSymptom!) as List<dynamic>)
        .map((e) => SymptomModel.fromJson(e))
        .toList();
    symptomList = SymptomData().symptomList;

    final jsonVaccine = await UserPreferences.getVaccine();
    VaccineData().vaccineList = (jsonDecode(jsonVaccine!) as List<dynamic>)
        .map((e) => VaccineModel.fromJson(e))
        .toList();
    vaccineList = VaccineData()
        .vaccineList
        .where((vaccines) => vaccines.specieId == _specieId)
        .toList();

    final jsonVaccineDose = await UserPreferences.getVaccineDose();
    VaccineDoseData().vaccineDoseList =
        (jsonDecode(jsonVaccineDose!) as List<dynamic>)
            .map((e) => VaccineDoseModel.fromJson(e))
            .toList();
    vaccineDoseList = VaccineDoseData().vaccineDoseList.toList();

    final jsonExam = await UserPreferences.getExam();
    ExamData().examList = (jsonDecode(jsonExam!) as List<dynamic>)
        .map((e) => ExamModel.fromJson(e))
        .toList();
    examList = ExamData().examList.toList();

    final jsonConsultation = await UserPreferences.getConsultation();
    ConsultationData().consultationList =
        (jsonDecode(jsonConsultation!) as List<dynamic>)
            .map((e) => ConsultationModel.fromJson(e))
            .toList();
    consultationList = ConsultationData().consultationList.toList();

/*
    final jsonHealthProgram = await UserPreferences.getHealthProgram();
    HealthProgramData().healthProgramList =
        (jsonDecode(jsonHealthProgram!) as List<dynamic>)
            .map((e) => HealthProgramModel.fromJson(e))
            .toList();
    healthProgramList = HealthProgramData()
        .healthProgramList
        .where((healthPrograms) => healthPrograms.specieId == _specieId)
        .toList();
*/
  }

  Future<void> _dispose() async {
    try {
      print('___________________ Iniciou o Dispose');
      await _engine.stopScreenCapture();
      await _engine.stopPreview();
      await _engine.leaveChannel();
      await _engine.release();
      print('___________________ Finalizou o Dispose');
    } catch (e) {
      print(
          '------------------------------------------------ erro dispose ----------------------- ${e.toString()}');
    }
  }

  Future<void> _dispose2() async {
    try {
      print('___________________ Iniciou o Dispose2');
      await _engine.stopScreenCapture();
      await _engine.stopPreview();
      await _engine.leaveChannel();
      print('___________________ Finalizou o Dispose2');
    } catch (e) {
      print(
          '------------------------------------------------ erro dispose ----------------------- ${e.toString()}');
    }
  }

  Future<void> _enableVirtualBackground() async {
    //await _engine.enableVirtualBackground(enabled: true, backgroundSource: , segproperty: segproperty)
    /*
    //VirtualBackgroundSource virtualBackgroundSource;
    //virtualBackgroundSource = VirtualBackgroundSource(
    //    backgroundSourceType: VirtualBackgroundSourceType.Img,
    //    source: "shared/images/logo.jpg");
    virtualBackgroundSource = VirtualBackgroundSource(
        backgroundSourceType: VirtualBackgroundSourceType.Blur,
        blurDegree: VirtualBackgroundBlurDegree.High);

    //virtualBackgroundSource.backgroundSourceType =  VirtualBackgroundSourceType.Color;
    //virtualBackgroundSource.color = 0x0000FF;

    //await _engine.enableVirtualBackground(true, virtualBackgroundSource);
    /*
    await _engine.enableVirtualBackground(
        !_isEnabledVirtualBackgroundImage,
        VirtualBackgroundSource(
            backgroundSourceType: VirtualBackgroundSourceType.Img,
            source: 'shared/images/logo.jpg'));
    */

    await _engine.enableVirtualBackground(
        !_isEnabledVirtualBackgroundImage,
        VirtualBackgroundSource(
            backgroundSourceType: VirtualBackgroundSourceType.Blur,
            blurDegree: VirtualBackgroundBlurDegree.High));
    setState(() {
      _isEnabledVirtualBackgroundImage = !_isEnabledVirtualBackgroundImage;
    });
    */
  }

  Future<String> _sendRTCTokenTutor(int petId, int queueId) async {
    final roomToken = await sendRTCTokenTutorApi(petId, queueId);

    return roomToken;
  }

  Future<void> _initEngine() async {
      try {
        await html.window.navigator.getUserMedia(audio: true, video: true);
      } catch (e) {
        print('Erro ao verificar a câmera: $e');
      }

      //_engine = await RtcEngine.create(appId);
      _engine = createAgoraRtcEngine();
      await _engine.initialize(const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.startPreview();

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _sendRTCTokenTutor(_serviceQueue.petId, _serviceQueue.queueId);
          setState(() {
            print('Conectou no canal.');
            isJoined = true;
          });
        },
        onRemoteAudioStats: (connection, stats) {
            print('onRemoteAudioStats____ $stats');
        },
        onAudioDeviceStateChanged: (deviceId, deviceType, deviceState) {
            print('onAudioDeviceStateChanged____ $deviceState');          
        },
        /*
        onRemoteAudioStateChanged: (connection, remoteUid, state, reason, elapsed) {
          print('remoteAudioStateChanged____ ${state.toString()}');
          //print('remoteAudioStateChanged____ ${state.name}');

          if (state.name == 'Decoding') {
            _isRemoteAudio = true;
          } else {
            _isRemoteAudio = false;
          }

          print('_isRemoteAudio______ $_isRemoteAudio');
        },
        */
        onUserMuteAudio: (connection, remoteUid, muted) {
            print('onUserMuteAudio____ $muted');          
            if (!muted) {
              _isRemoteAudio = true;
            } else {
              _isRemoteAudio = false;
            }
        },
        onError: (err, msg) {
          print('__________________ error____ $err');
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          //print("remote user $uid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (connection, remoteUid, reason) {
          //print("remote user $uid left channel");
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
    await _engine.joinChannel(
      token: _token!, 
      channelId: _channel!, 
      uid: int.parse(_crmv!), 
      options: const ChannelMediaOptions()
    );
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
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: _channel),
        ),
      );
    } else {
      return Text(
        //'Please wait for remote user to join',
        'Por favor aguarde o Tutor entrar na sala. - $formattedTime',
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
                child: Column(
                  children: [
                    // Descomentar para funcionar Vídeo
                    _videoConsultation(context),
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
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13.0),
                              enabled: false,
                              controller: _tutorNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          8.0)), // Raio dos cantos da borda
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0), // Cor e largura da borda
                                ),
                                labelText: 'Tutor',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13.0),
                              enabled: false,
                              controller: _petNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          8.0)), // Raio dos cantos da borda
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0), // Cor e largura da borda
                                ),
                                labelText: 'Pet',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13.0),
                              enabled: false,
                              controller: _petPlanController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          8.0)), // Raio dos cantos da borda
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0), // Cor e largura da borda
                                ),
                                labelText: 'Plano',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              finalClassificationId = 2;
                              validationEmergency = !_isEmergency;
                              _isEmergency = !_isEmergency;

                              if (_isEmergency) {
                                if (_selectedTypeService == 1) {
                                  _currentPageIndex = 6;
                                } else if (_selectedTypeService == 2) {
                                  _currentPageIndex = 9;
                                } else if (_selectedTypeService == 4) {
                                  _currentPageIndex = 7;
                                }
                              } else {
                                _currentPageIndex = 0;
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: !_isEmergency
                                ? MaterialStateProperty.all<Color>(Colors.red)
                                : MaterialStateProperty.all<Color>(
                                    Colors.green),
                          ),
                          child: Text(
                            !_isEmergency
                                ? 'É Emergência?'
                                : 'Não é Emregência!',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    /*
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Ficha', // Texto no decoration
                      ),
                      value: _selectedTypeService,
                      onChanged: (int? newCode) {
                        if (newCode != null) {
                          setState(() {
                            _selectedTypeService = newCode;
                            _validateTypeService();
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
                    */
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
                    Visibility(
                      visible: !_isCheckOut, // Controla a visibilidade do botão
                      child: Row(
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
                                /*
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
                                }*/

                                if (_validationFunctions[_currentPageIndex]()) {
                                  if (_currentPageIndex < _pages.length - 1) {
                                    setState(() {
                                      _currentPageIndex++;
                                    });
                                  }
                                } else {
                                  _showInfoMessage(context);
                                }
                              },
                              child: const Text('Próximo'),
                            ),
                          ),
                          Visibility(
                            visible: (_currentPageIndex == _pages.length - 1 &&
                                    !_isCheckOut)
                                ? true
                                : false, // Controla a visibilidade do botão
                            child: ElevatedButton(
                              onPressed: () {
                                if (_validationFunctions[_currentPageIndex]()) {
                                  _showFinishService(context);
                                } else {
                                  _showInfoMessage(context);
                                }
                              },
                              child: const Text('Finalizar'),
                            ),
                          ),
                        ],
                      ),
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

  void _showFinishService(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Finalizar o Atendimento?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isCheckOut = false;
                        });
                        Navigator.of(context)
                            .pop(false); // Passa false se não finalizar
                      },
                      child: const Text('Não'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        setState(() {
                          _isCheckOut = true;
                          _selectedTypeService = 100;
                          _validateTypeService();
                        });
                        //Navigator.of(context)
                        //   .pop(true); // Passa true se finalizar
                      },
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInfoMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('O(s) campo(s) abaixo é(são) Obrigatório(s)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_textValidation ??
                  ''), // Use a variável _textValidation no Text
              const SizedBox(height: 20), // Espaçamento entre o texto e o botão
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _videoConsultation(BuildContext context) {
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
              height: 80,
              width: 130,
              color: Colors.black,
              child: isJoined
                  ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
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
              width: (MediaQuery.of(context).size.width * 60 / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Tutor desativou o Microfone',
                    style: TextStyle(
                        color:
                            !_isRemoteAudio ? Colors.red : Colors.transparent,
                        backgroundColor: !_isRemoteAudio
                            ? Colors.white
                            : Colors.transparent),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
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
                      //_startScreenShare();
                      _enableVirtualBackground();
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
                ),
                */
                ],
              ),
            ),
          ),
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
  void initState() {
    super.initState();

    isWelcome = false;
    isProduct = false;
    isCompany = false;
    isFaceToFaceConsultation = false;
    isHealthProgram = false;
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      //print(1);
    } else {
      //print(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always, // Autovalidação ativada
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Boas-Vindas', style: TextStyle(fontSize: 25)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13.0),
                          enabled: false,
                          controller: _tutorNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Raio dos cantos da borda
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0), // Cor e largura da borda
                            ),
                            labelText: 'Tutor',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13.0),
                          enabled: false,
                          controller: _petNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Raio dos cantos da borda
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0), // Cor e largura da borda
                            ),
                            labelText: 'Pet',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13.0),
                          enabled: false,
                          controller: _petNickNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Raio dos cantos da borda
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0), // Cor e largura da borda
                            ),
                            labelText: 'Apelido',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13.0),
                          enabled: false,
                          controller: _specieController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Raio dos cantos da borda
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0), // Cor e largura da borda
                            ),
                            labelText: 'Espécie',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 13.0),
                          enabled: false,
                          controller: _raceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Raio dos cantos da borda
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0), // Cor e largura da borda
                            ),
                            labelText: 'Raça',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 13.0),
                    enabled: false,
                    controller: _productController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8.0)), // Raio dos cantos da borda
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0), // Cor e largura da borda
                      ),
                      labelText: 'Produto Contratado',
                    ),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCompany = !isCompany;
                        });
                        widget.updateCheckboxCompany(isCompany);
                      },
                      child: const Text('Informações sobre a Petner'),
                    ),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          isProduct = !isProduct;
                        });
                        widget.updateCheckboxProduct(isProduct);
                      },
                      child:
                          const Text('Informações sobre o Produto Contratado'),
                    ),
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
                        widget.updateCheckboxFaceToFaceConsultation(
                            newValue ?? false);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isFaceToFaceConsultation = !isFaceToFaceConsultation;
                        });
                        widget.updateCheckboxFaceToFaceConsultation(
                            isFaceToFaceConsultation);
                      },
                      child:
                          const Text('Informações sobre a Consulta Presencial'),
                    ),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHealthProgram = !isHealthProgram;
                        });
                        widget.updateCheckboxHealthProgram(isHealthProgram);
                      },
                      child: const Text(
                          'Informações gerais sobre Programas de Saúde'),
                    ),
                  ],
                ),
              ],
            ),
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

  Future<void> _selectBirthDay(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdayController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        _ageController.text = calculateAge(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
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
              SizedBox(
                height: 40,
                child: TextFormField(
                  style: const TextStyle(fontSize: 13.0),
                  enabled: false,
                  controller: _tutorNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Raio dos cantos da borda
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Cor e largura da borda
                    ),
                    labelText: 'Tutor',
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13.0),
                        //enabled: false,
                        controller: _petNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                8.0)), // Raio dos cantos da borda
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0), // Cor e largura da borda
                          ),
                          labelText: 'Pet',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13.0),
                        //enabled: false,
                        controller: _petNickNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                8.0)), // Raio dos cantos da borda
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0), // Cor e largura da borda
                          ),
                          labelText: 'Apelido',
                        ),
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
                    child: SizedBox(
                      height: 40,
                      child: speciesDropdown(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 40,
                      child: racesDropdown(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: sizeDropdown(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: gendersDropDown(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13.0),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          8.0)), // Raio dos cantos da borda
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0), // Cor e largura da borda
                                ),
                                labelText: 'Data de Nascimento',
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => _selectBirthDay(context),
                                ),
                              ),
                              controller: _birthdayController,
                              readOnly: true,
                              onTap: () => _selectBirthDay(context),
                              validator: (input) => input?.isEmpty == true
                                  ? 'Por favor informar a Data de Nascimento'
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 13.0),
                              enabled: false,
                              controller: _ageController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          8.0)), // Raio dos cantos da borda
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0), // Cor e largura da borda
                                ),
                                labelText: 'Idade',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Row(
                            children: [
                              Checkbox(
                                value: _isAgeReal,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isAgeReal = newValue!;
                                  });
                                },
                              ),
                              const Text('Idade Real?',
                                  style: TextStyle(fontSize: 13.0)),
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
                        const Text('Castrado?',
                            style: TextStyle(fontSize: 13.0)),
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
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: const Text('Tele Orientação Liberado'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _serviceQueue.haveTeleConsultation! == true
                                ? 'Tele Consulta Liberado'
                                : 'Tele Consulta Bloqueado',
                            style: TextStyle(
                              color: (!_serviceQueue.haveTeleConsultation!
                                  ? Colors.red
                                  : Colors.black),
                            ),
                          ),
                          Visibility(
                            visible: !_serviceQueue.haveTeleConsultation!,
                            child: Text(_serviceQueue.productId! == 1
                                ? 'Motivo: Plano Contrato sem cobertura'
                                : ''),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _serviceQueue.emergencyReleased! == true
                                  ? 'Emergência Liberada'
                                  : 'Emergência Bloqueada',
                              style: TextStyle(
                                  color: (!_serviceQueue.emergencyReleased!
                                      ? Colors.red
                                      : Colors.black))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _serviceQueue.homeReleased! == true
                                  ? 'Consulta Domiciliar Liberada ${_serviceQueue.homeReleased}'
                                  : 'Consulta Domiciliar Bloqueada ${_serviceQueue.homeReleased}',
                              style: TextStyle(
                                  color: (!_serviceQueue.homeReleased!
                                      ? Colors.red
                                      : Colors.black))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: const Text('Tele Orientação Liberado'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _serviceQueue.haveTeleConsultation! == true
                                  ? 'Tele Consulta Liberado'
                                  : 'Tele Consulta Bloqueado',
                              style: TextStyle(
                                color: (!_serviceQueue.haveTeleConsultation!
                                    ? Colors.red
                                    : Colors.black),
                              ),
                            ),
                            Visibility(
                              visible: !_serviceQueue.haveTeleConsultation!,
                              child: Text(_serviceQueue.productId! == 1
                                  ? 'Motivo: Plano Contrato sem cobertura'
                                  : ''),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                _serviceQueue.emergencyReleased! == true
                                    ? 'Emergência Liberada'
                                    : 'Emergência Bloqueada',
                                style: TextStyle(
                                    color: (!_serviceQueue.emergencyReleased!
                                        ? Colors.red
                                        : Colors.black))),
                            /*
                            Visibility(
                              visible: !_serviceQueue.emergencyReleased!,
                              child: Text(
                                  'Motivo: ${_serviceQueue.emergencyMessage!}'),
                            ),
                            */
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Raio dos cantos da borda
                      ),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                _serviceQueue.homeReleased! == true
                                    ? 'Consulta Domiciliar Liberada'
                                    : 'Consulta Domiciliar Bloqueada',
                                style: TextStyle(
                                    color: (!_serviceQueue.homeReleased!
                                        ? Colors.red
                                        : Colors.black))),
                            /*
                            Visibility(
                              visible: !_serviceQueue.homeReleased!,
                              child:
                                  Text('Motivo: ${_serviceQueue.homeMessage!}'),
                            ),
                            */
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              */
            ],
          ),
        ),
      ],
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
          child: Text(
            species['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Espécie',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
          child: Text(
            size['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Porte',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      ),
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
          child: Text(
            races.name,
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Raça',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
          child: Text(
            gender['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
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
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
          child: Text(
            coats.name,
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Pelagem',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
          child: Text(
            size['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Temperamento',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
          child: Text(
            size['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Ambiente que vive',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
          child: Text(
            size['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Alimentação',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      ),
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
          child: Text(
            size['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Score Corporal',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      ),
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
          child: Text(
            size['name'],
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Estado',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      ),
      value: (_state == null ? null : _state.toString()),
    );
  }

  DropdownButtonFormField<String> cityDropDown() {
    return DropdownButtonFormField<String>(
      //validator: _validateDropDown,
      onChanged: (value) {
        //print('city: {$value}');
        setState(() {
          _city = value!;
        });
      },
      items: listCity.map((city) {
        return DropdownMenuItem<String>(
          value: city.name,
          child: Text(
            city.name.toString(),
            style: const TextStyle(fontSize: 13.0),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Cidade',
        labelStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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

  Future<int?> _registerPetVaccineDose(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerPetVaccineDoseApi(
        _typeRegister,
        _serviceQueue.queueId.toString(),
        '',
        _applicationDateController.text,
        true,
        _serviceQueue.petId.toString(),
        _petVaccineId.toString(),
        _petVaccineDoseId,
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
      return responseData['validateRegisterPetVaccineDose'];
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
                /*if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else */
                if (snapshot.hasError) {
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
                                  _showPetVaccineDoseList(context);
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
                                                    fontSize: 13,
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

  void _showPetVaccineDoseList(BuildContext context) {
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
                          /*if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else */
                          if (snapshot.hasError) {
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
                                  builder: (context) => RegisterPetVaccineDosePage(myPet: widget.myPet, vaccinePetId: widget.vaccinePetId, petVaccineDoseId: petVaccineCard.vaccineTypeId, typeRegister: 'U', vaccinationCardId: petVaccineCard.vaccinationCardId.toString()),
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
                                                          fontSize: 13),
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
                                                        //_selectedPetVaccineDoseId = petVaccineCard.vaccinationCardId.toString();
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
                                                                                                            _registerPetVaccineDose(context).then(
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
                              _showRegisterPetVaccineDose(context);
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

  void _showRegisterPetVaccineDose(BuildContext context) {
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
                              FutureBuilder<List<PetVaccineDoseModel>>(
                                future: petVaccineDoseListApi(
                                    _serviceQueue.petId.toString(),
                                    _vaccineId
                                        .toString()), // Função para buscar os dados da API VaccineType
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<PetVaccineDoseModel>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    List<PetVaccineDoseModel> petVaccineDose =
                                        snapshot.data!;
                                    return DropdownButtonFormField<String>(
                                      hint: const Text('Selecione uma Dose'),
                                      value: _petVaccineDoseId,
                                      validator: _validateDropDown,
                                      items:
                                          petVaccineDose.map((petVaccineDose) {
                                        return DropdownMenuItem<String>(
                                          value: petVaccineDose.petVaccineDoseId
                                              .toString(),
                                          child: Text(petVaccineDose.name),
                                        );
                                      }).toList(),
                                      onChanged: (String? selectedValue) {
                                        _petVaccineDoseId = selectedValue;
                                        // Ação a ser executada quando um item for selecionado no dropdown
                                        if (selectedValue != null) {
                                          // Faça algo com o valor selecionado
                                          //print(selectedValue);
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
                                    _petVaccineDoseId = null;
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
                                  _registerPetVaccineDose(context).then(
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
  bool _isotherMedicineVisible = false;

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
        _petDiseaseId.toString(),
        _otherChronicDiseaseController.text,
        true,
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      if (responseData['validateRegisterChronicDisease'] != null) {
        return responseData['validateRegisterChronicDisease'];
      } else {
        return responseData['validateRegisterDisease'];
      }
    }
  }

  Future<List<dynamic>> _fetchPetMedicines() async {
    List<PetMedicineModel> petMedicineList;
    petMedicineList =
        await petMedicineListApi(1, _serviceQueue.petId.toString(), '0');

    return petMedicineList;
  }

  Future<int?> _registerMedicine(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerMedicineApi(
        1,
        _typeRegister,
        _serviceQueue.petId.toString(),
        '0',
        _medicineId,
        _petMedicineId.toString(),
        _otherMedicineController.text,
        true,
        0,
        '',
        '',
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterMedicine'];
    }

    setState(() {
      _isLoading = false;
    });

    return 4;
  }

  Future<List<dynamic>> _fetchPetAllergies() async {
    List<PetAllergyModel> petAllergyList;
    petAllergyList = await petAllergyListApi(_serviceQueue.petId.toString());

    return petAllergyList;
  }

  Future<int?> _registerAllergy(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerAllergyApi(
        _typeRegister,
        _serviceQueue.petId.toString(),
        _allergyController.text,
        _petAllergyId.toString(),
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterAllergy'];
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
                                  /*if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else */
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            itemCount: PetDiseaseData()
                                                .petDiseaseList
                                                .length,
                                            itemBuilder: (context, index) {
                                              final petDisease =
                                                  PetDiseaseData()
                                                      .petDiseaseList[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height:
                                                      70, // Defina a altura desejada para o card
                                                  width: double
                                                      .infinity, // Defina a largura desejada para o card

                                                  // Estilize o card com o BoxDecoration ou o Card widget
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                      _petDiseaseId = petDisease
                                                          .petDiseaseId;
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
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                petDisease
                                                                    .name!,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete),
                                                                color:
                                                                    Colors.red,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _petDiseaseId =
                                                                        petDisease
                                                                            .petDiseaseId;
                                                                  });
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Form(
                                                                        key:
                                                                            _formKey,
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              const Text('Excluir Doença Crônica?'),
                                                                          content:
                                                                              const Text('A Doença será Excluída. Confirma?'),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              child: const Text('Não'),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: const Text('Sim'),
                                                                              onPressed: () {
                                                                                _typeRegister = 'D';
                                                                                _registerChronicDisease(context).then(
                                                                                  (value) {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                );
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
                            setState(() {
                              _isotherChronicDiseaseVisible = false;
                            });
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
                            FutureBuilder<List<dynamic>>(
                                future: _fetchPetMedicines(),
                                builder: (context, snapshot) {
                                  /*if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else */
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            itemCount: PetMedicineData()
                                                .petMedicineList
                                                .length,
                                            itemBuilder: (context, index) {
                                              final petMedicine =
                                                  PetMedicineData()
                                                      .petMedicineList[index];
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                      _petMedicineId =
                                                          petMedicine
                                                              .petMedicineId;
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            petMedicine.name!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              setState(() {
                                                                _petMedicineId =
                                                                    petMedicine
                                                                        .petMedicineId;
                                                              });
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          'Excluir Medicamento?'),
                                                                      content:
                                                                          const Text(
                                                                              'O medicamento será excluído. Confirma?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Não'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Sim'),
                                                                          onPressed:
                                                                              () {
                                                                            _typeRegister =
                                                                                'D';
                                                                            _registerMedicine(context).then(
                                                                              (value) {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            );
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                            // Adicionar ação de "Adicionar" aqui
                            setState(() {
                              _isotherMedicineVisible = false;
                            });
                            _showMedicine(context);
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
                            FutureBuilder<List<dynamic>>(
                                future: _fetchPetAllergies(),
                                builder: (context, snapshot) {
                                  /*if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else */
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          itemCount: PetAllergyData()
                                              .petAllergyList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final petAllergy = PetAllergyData()
                                                .petAllergyList[index];
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
                                                    _petAllergyId =
                                                        petAllergy.petAllergyId;
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          petAllergy.name!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            setState(() {
                                                              _petAllergyId =
                                                                  petAllergy
                                                                      .petAllergyId;
                                                            });
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Form(
                                                                  key: _formKey,
                                                                  child:
                                                                      AlertDialog(
                                                                    title: const Text(
                                                                        'Excluir Alergia?'),
                                                                    content:
                                                                        const Text(
                                                                            'A alergia será excluída. Confirma?'),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        child: const Text(
                                                                            'Não'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: const Text(
                                                                            'Sim'),
                                                                        onPressed:
                                                                            () {
                                                                          _typeRegister =
                                                                              'D';
                                                                          _registerAllergy(context)
                                                                              .then(
                                                                            (value) {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          );
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
                            // Adicionar ação de "Adicionar" aqui
                            _showAllergies(context);
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
                height: 250,
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
                              DropdownSearch<DiseaseModel>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Doenças",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                items: DiseaseData()
                                    .diseaseList
                                    .where((diseases) =>
                                        (diseases.chronic == true ||
                                            diseases.id == '171') &&
                                        diseases.specieId ==
                                            _serviceQueue.specieId)
                                    .toList(),
                                itemAsString: (DiseaseModel disease) =>
                                    disease.name,
                                onChanged: (value) {
                                  if (value != null) {
                                    _diseaseId = value.id;
                                  } else {
                                    _diseaseId = null;
                                  }
                                  if (_diseaseId == '171') {
                                    setState(() {
                                      _isotherChronicDiseaseVisible = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isotherChronicDiseaseVisible = false;
                                    });
                                  }
                                },
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

  void _showMedicine(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateMedicine) {
            return Dialog(
              child: Container(
                width: 450,
                height: 250,
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
                              'Medicamentos',
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
                              DropdownSearch<MedicineModel>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Medicamentos",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                items: MedicineData().medicineList,
                                itemAsString: (MedicineModel medicine) =>
                                    medicine.name,
                                onChanged: (value) {
                                  //print(value.id);
                                  if (value != null) {
                                    _medicineId = value.id;
                                  } else {
                                    _medicineId = null;
                                  }

                                  if (_medicineId == '941') {
                                    setStateMedicine(() {
                                      _isotherMedicineVisible = true;
                                    });
                                  } else {
                                    setStateMedicine(() {
                                      _isotherMedicineVisible = false;
                                    });
                                  }

                                  //print(_isotherMedicineVisible);
                                },
                                //decoration: BoxDecoration(
                                //    border: Border.all(color: Colors.blue)),
                              ),
                              const SizedBox(height: 10.0),
                              Visibility(
                                visible: _isotherMedicineVisible,
                                child: TextFormField(
                                  controller: _otherMedicineController,
                                  decoration: const InputDecoration(
                                    labelText: 'Outro Medicameneto',
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
                                setStateMedicine(() {
                                  _typeRegister = 'C';
                                  _registerMedicine(context).then((value) {});
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

  void _showAllergies(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 450,
                height: 250,
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
                              'Alergias',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _allergyController,
                          decoration: const InputDecoration(
                            labelText: 'Qual Alergia?',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  8.0)), // Raio dos cantos da borda
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
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
                                  _registerAllergy(context).then((value) {});
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

class AnamnesisPage extends StatefulWidget {
  const AnamnesisPage({
    Key? key,
  }) : super(key: key);

  @override
  _AnamnesisPage createState() => _AnamnesisPage();
}

class _AnamnesisPage extends State<AnamnesisPage>
    with TickerProviderStateMixin {
  bool _isotherSimptomVisible = false;
  int _currentIndex = 0;
  bool _firstConsultation = true;

  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    // Adiciona um ouvinte para detectar mudanças de tab
    _tabController.addListener(() {
      //print('$_currentIndex - ${_tabController.index}');

      //Descomentar para validar os Campos preenchidos
      if (_currentIndex != _tabController.index) {
        if (_currentIndex == 0) {
          if (_validateQuestionry()) {
            _tabController.animateTo(_tabController.index);
            _currentIndex = _tabController.index;
          } else {
            _tabController.previousIndex;
            _tabController.animateTo(0);
            _showInfoMessage(context);
          }
        } else if (_currentIndex == 1) {
          if (_validateSymptom()) {
            _tabController.animateTo(_tabController.index);
            _currentIndex = _tabController.index;
          } else {
            _tabController.animateTo(1);
            _showInfoMessage(context);
          }
        }
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  bool _isCurrentTabValid(int _currentIndex) {
    if (_currentIndex == 0) {
      return _validateQuestionry();
    } else if (_currentIndex == 1) {
      return _validateSymptom();
    }
    return true;
  }

  bool _validateQuestionry() {
    bool validation = true;

    _textValidation = '';

    if (_complaintController.text.isEmpty) {
      _textValidation += 'Informe a Queixa\n';
      validation = false;
    }

    if (appetitId == null) {
      _textValidation += 'Como está o Apetite e Alimentação?\n';
      validation = false;
    }

    if (waterIntakeId == null) {
      _textValidation += 'Como está a ingestão de água?\n';
      validation = false;
    }

    if (urineStainingId == null) {
      _textValidation += 'Qual a coloração da Urina?\n';
      validation = false;
    }

    if (urineVolumeId == null) {
      _textValidation += 'Qual o volume de urina?\n';
      validation = false;
    }

    if (stoolColoringId == null) {
      _textValidation += 'Qual a coloração das fezes?\n';
      validation = false;
    }

    if (stoolConsistencyId == null) {
      _textValidation += 'Qual é a consistência das fezes?\n';
      validation = false;
    }

    if (noseTypeId == null) {
      _textValidation += 'O nariz do PET está seco?\n';
      validation = false;
    }

    if (noseTemperatureId == null) {
      _textValidation += 'O nariz está quente ou frio?\n';
      validation = false;
    }

    if (hotEarId == null) {
      _textValidation += 'A orelha do pet está quente?\n';
      validation = false;
    }

    if (gasesId == null) {
      _textValidation += 'O pet está soltando muitos gases?\n';
      validation = false;
    }

    if (tightBellyId == null) {
      _textValidation += 'Apresenta barriga enrijecida?\n';
      validation = false;
    }

    if (touchPainId == null) {
      _textValidation += 'Apresenta dor ao toque?\n';
      validation = false;
    }

    if (walksBentOverId == null) {
      _textValidation += 'Apresenta andar curvado?\n';
      validation = false;
    }

    if (conjunctivaId == null) {
      _textValidation += 'Inspeção através da câmera: conjuntiva\n';
      validation = false;
    }

    if (gumTongueId == null) {
      _textValidation += 'Inspeção através da câmera: Língua, gengiva\n';
      validation = false;
    }

    if (hairLossId == null) {
      _textValidation += 'Apresenta queda de pelo fora do comum?\n';
      validation = false;
    }

    if (abnormalPlacementId == null) {
      _textValidation +=
          'Apresenta coloração de pele fora do normal em alguma área?\n';
      validation = false;
    }

    if (bodyStateId == null) {
      _textValidation +=
          'Qual a sua avaliação do estado corporal do seu pet?\n';
      validation = false;
    }

    if (bodyScoreId == null) {
      _textValidation += 'Inspeção através da câmera: Score corporal\n';
      validation = false;
    }

    return validation;
  }

  bool _validateSymptom() {
    bool validation = true;
    _textValidation = '';

    if (PetSymptomData().petSymptomList.isEmpty) {
      _textValidation += 'Inserir possíveis Sintomas na aba SINTOMA\n';
      validation = false;
    }
    return validation;
  }

  final Map<String, String> appetiteList = {
    '1': 'Abaixo do Normal',
    '2': 'Normal',
    '3': 'Acima do Normal',
  };

  final Map<String, String> waterIntakeList = {
    '1': 'Normal',
    '2': 'Pouca',
    '3': 'Excessiva',
  };

  final Map<String, String> urineStainingList = {
    '1': 'Normal',
    '2': 'Concentrada',
  };

  final Map<String, String> urineVolumeList = {
    '1': 'Abaixo do Normal',
    '2': 'Normal',
    '3': 'Acima do Normal',
  };

  final Map<String, String> stoolColoringList = {
    '1': 'Marrom',
    '2': 'Preta',
    '3': 'Amarela',
    '4': 'Avermelhada',
  };

  final Map<String, String> stoolConsistencyList = {
    '1': 'Líquida',
    '2': 'Pastosa sem Formato',
    '3': 'Pastosa com Formato',
    '4': 'Seca',
  };

  final Map<String, String> noseTypeList = {
    '1': 'Seco',
    '2': 'Úmido',
  };

  final Map<String, String> noseTemperatureList = {
    '1': 'Quente',
    '2': 'Frio',
  };

  final Map<String, String> hotEarList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> restlessList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> gasesList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> tightBellyList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> touchPainList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> walksBentOverList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> gumTongueList = {
    '1': 'Pálida',
    '2': 'Vermelha',
    '3': 'Azul',
  };

  final Map<String, String> conjunctivaList = {
    '1': 'Hipocorada',
    '2': 'Normocorada',
    '3': 'Hipercorada',
  };

  final Map<String, String> hairLossList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> dullHairList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> abnormalPlacementList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> hairFailureList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> brittleHairList = {
    '1': 'Sim',
    '2': 'Não',
  };

  final Map<String, String> bodyStateList = {
    '1': 'Excessivamente Magro',
    '2': 'Magro',
    '3': 'Normal',
    '4': 'Sobrepeso',
    '5': 'Muito Sobrepeso',
  };

  final Map<String, String> bodyScoreList = {
    '1': 'Emaciado',
    '2': 'Muito Magro',
    '3': 'Magro',
    '4': 'Ideal',
    '5': 'Sobrepeso',
    '6': 'Obesidade',
    '7': 'Obesidade Grave',
  };

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  Future<List<dynamic>> _fetchPetSymptoms() async {
    List<PetSymptomModel> petSymptomList;
    petSymptomList = await petSymptomListApi(
        _serviceQueue.petId.toString(), _serviceQueue.queueId.toString());

    return petSymptomList;
  }

  Future<int?> _registerSymptom(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerSymptomApi(
          _typeRegister,
          _serviceQueue.petId.toString(),
          _serviceQueue.queueId.toString(),
          _symptomId.toString(),
          _petSymptomId.toString(),
          _otherSymptomController.text);

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterSymptom'];
    }

    setState(() {
      _isLoading = false;
    });

    return 4;
  }

  Future<void> _fetchRegisterDiseaseConsultChatGPT(
      int chatGPTId, bool selected) async {
    await registerDiseaseConsultChatGPTApi(chatGPTId, selected);
  }

  Future<List<dynamic>> _fetchListConsultChatGPT() async {
    List<ConsultChatGPTModel> consultChatGPTList;
    consultChatGPTList = await listConsultChatGPTApi(1, _serviceQueue.queueId);

    return consultChatGPTList;
  }

  Future<void> _fetchConsultChatGPT() async {
    List<ConsultChatGPTModel> consultChatGPTList;
    consultChatGPTList = await consultChatGPTApi(1, _serviceQueue.queueId);
    setState(() {
      _isLoading = false;
    });
  }

  Future<int?> _registerSymptomQuestion(String type, int symptomId) async {
    //final form = _formKey.currentState;
    //if (form!.validate()) {
    Map<String, dynamic> responseData = await registerSymptomApi(
        type,
        _serviceQueue.petId.toString(),
        _serviceQueue.queueId.toString(),
        symptomId.toString(),
        symptomId.toString(),
        '');

    setState(() {
      _isLoading = false;
    });

    //return 1;
    return responseData['validateRegisterSymptom'];
    //}

    setState(() {
      _isLoading = false;
    });

    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Anamnese Clínica',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 30)),
                ],
              ),
              Visibility(
                visible: _isQuestionComplaintVisible,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10.0),
                        const Expanded(
                          flex: 2,
                          child: Text('Alguma queixa no momento?',
                              style: TextStyle(fontSize: 13)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isComplaint = true;
                              _complaint = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (_complaint != null && _complaint!) {
                                  return Colors.green; // Cor quando ativo
                                }
                                return Colors.blue; // Cor padrão
                              },
                            ),
                          ),
                          child: const Text('Sim'),
                        ),
                        const SizedBox(width: 5.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isComplaint = false;
                              _complaint = false;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (_complaint != null && !_complaint!) {
                                  return Colors.red; // Cor quando ativo
                                }
                                return Colors.blue; // Cor padrão
                              },
                            ),
                          ),
                          child: const Text('Não'),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Visibility(
                visible: _isComplaint,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 13.0),
                            controller: _complaintController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    8.0)), // Raio dos cantos da borda
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0), // Cor e largura da borda
                              ),
                              labelText: 'Informe a Queixa(*)',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: double.maxFinite,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 206, 205, 205)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
                        child: Scaffold(
                          appBar: AppBar(
                            toolbarHeight: 0,
                            bottom: TabBar(
                              controller: _tabController,
                              tabs: const [
                                Tab(text: 'Questionário'),
                                Tab(text: 'Sintoma'),
                                Tab(text: 'Dr. VetBot (Doença(s))'),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            controller: _tabController,
                            children: [
                              _questionaryTab(),
                              _symptomTab(),
                              _drVetBotDiseaseTab(context),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text('* são campos obrigatórios'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _questionaryTab() {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 10, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              appetitId = int.parse(value!);
                              if (appetitId == 1) {
                                _registerSymptomQuestion('C', 46);
                                _registerSymptomQuestion('E', 120);
                              } else if (appetitId == 3) {
                                _registerSymptomQuestion('C', 120);
                                _registerSymptomQuestion('E', 46);
                              } else {
                                _registerSymptomQuestion('E', 46);
                                _registerSymptomQuestion('E', 120);
                              }
                            });
                          },
                          items: appetiteList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                appetiteList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Como está o Apetite e Alimentação?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value:
                              (appetitId == null ? null : appetitId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              waterIntakeId = int.parse(value!);
                              if (waterIntakeId == 3) {
                                _registerSymptomQuestion('C', 52);
                              } else {
                                _registerSymptomQuestion('E', 52);
                              }
                            });
                          },
                          items: waterIntakeList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                waterIntakeList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Como está a ingestão de água?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (waterIntakeId == null
                              ? null
                              : waterIntakeId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              urineStainingId = int.parse(value!);
                            });
                          },
                          items: urineStainingList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                urineStainingList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Qual a coloração da Urina?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (urineStainingId == null
                              ? null
                              : urineStainingId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              urineVolumeId = int.parse(value!);
                              if (urineVolumeId == 1) {
                                _registerSymptomQuestion('C', 53);
                                _registerSymptomQuestion('E', 51);
                              } else if (urineVolumeId == 3) {
                                _registerSymptomQuestion('C', 51);
                                _registerSymptomQuestion('E', 53);
                              } else {
                                _registerSymptomQuestion('E', 51);
                                _registerSymptomQuestion('E', 53);
                              }
                            });
                          },
                          items: urineVolumeList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                urineVolumeList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Qual o volume de urina?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (urineVolumeId == null
                              ? null
                              : urineVolumeId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              stoolColoringId = int.parse(value!);
                              if (stoolColoringId == 4) {
                                _registerSymptomQuestion('C', 64);
                              } else {
                                _registerSymptomQuestion('E', 64);
                              }
                            });
                          },
                          items: stoolColoringList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                stoolColoringList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Qual a coloração das fezes?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (stoolColoringId == null
                              ? null
                              : stoolColoringId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              stoolConsistencyId = int.parse(value!);
                              if (stoolConsistencyId == 1) {
                                _registerSymptomQuestion('C', 17);
                              } else {
                                _registerSymptomQuestion('E', 17);
                              }
                            });
                          },
                          items: stoolConsistencyList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                stoolConsistencyList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Qual é a consistência das fezes?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (stoolConsistencyId == null
                              ? null
                              : stoolConsistencyId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              noseTypeId = int.parse(value!);

                              if (noseTypeId == 1 &&
                                  noseTemperatureId == 1 &&
                                  hotEarId == 1) {
                                _registerSymptomQuestion('C', 78);
                              } else {
                                _registerSymptomQuestion('E', 78);
                              }
                            });
                          },
                          items: noseTypeList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                noseTypeList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'O nariz do PET está seco?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (noseTypeId == null
                              ? null
                              : noseTypeId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              noseTemperatureId = int.parse(value!);

                              if (noseTypeId == 1 &&
                                  noseTemperatureId == 1 &&
                                  hotEarId == 1) {
                                _registerSymptomQuestion('C', 78);
                              } else {
                                _registerSymptomQuestion('E', 78);
                              }
                            });
                          },
                          items: noseTemperatureList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                noseTemperatureList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'O nariz está quente ou frio?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (noseTemperatureId == null
                              ? null
                              : noseTemperatureId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              hotEarId = int.parse(value!);

                              if (noseTypeId == 1 &&
                                  noseTemperatureId == 1 &&
                                  hotEarId == 1) {
                                _registerSymptomQuestion('C', 78);
                              } else {
                                _registerSymptomQuestion('E', 78);
                              }
                            });
                          },
                          items: hotEarList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                hotEarList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'A orelha do pet está quente?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value:
                              (hotEarId == null ? null : hotEarId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              restlessId = int.parse(value!);
                            });
                          },
                          items: restlessList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                restlessList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'O pet está irrequieto?',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (restlessId == null
                              ? null
                              : restlessId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              gasesId = int.parse(value!);
                            });
                          },
                          items: gasesList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                gasesList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'O pet está soltando muitos gases?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (gasesId == null ? null : gasesId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              tightBellyId = int.parse(value!);
                              print('tightBellyId___ $tightBellyId');
                              if (tightBellyId == 1) {
                                _registerSymptomQuestion('C', 12);
                              } else {
                                _registerSymptomQuestion('E', 12);
                              }
                            });
                          },
                          items: tightBellyList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                tightBellyList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Apresenta barriga enrijecida?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (tightBellyId == null
                              ? null
                              : tightBellyId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              touchPainId = int.parse(value!);
                              if (touchPainId == 1) {
                                _registerSymptomQuestion('C', 12);
                              } else {
                                _registerSymptomQuestion('E', 12);
                              }
                            });
                          },
                          items: touchPainList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                touchPainList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Apresenta dor ao toque Abdominal?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (touchPainId == null
                              ? null
                              : touchPainId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              walksBentOverId = int.parse(value!);
                              if (walksBentOverId == 1) {
                                _registerSymptomQuestion('C', 3);
                              } else {
                                _registerSymptomQuestion('E', 3);
                              }
                            });
                          },
                          items: walksBentOverList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                walksBentOverList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Apresenta andar curvado?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (walksBentOverId == null
                              ? null
                              : walksBentOverId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              gumTongueId = int.parse(value!);
                              if (gumTongueId == 1) {
                                _registerSymptomQuestion('C', 36);
                                _registerSymptomQuestion('E', 143);
                              } else if (gumTongueId == 3) {
                                _registerSymptomQuestion('C', 143);
                                _registerSymptomQuestion('E', 36);
                              } else {
                                _registerSymptomQuestion('E', 36);
                                _registerSymptomQuestion('E', 143);
                              }
                            });
                          },
                          items: gumTongueList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                gumTongueList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText:
                                'Inspeção através da câmera: Língua, gengiva(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (gumTongueId == null
                              ? null
                              : gumTongueId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              conjunctivaId = int.parse(value!);
                            });
                          },
                          items: conjunctivaList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                conjunctivaList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText:
                                'Inspeção através da câmera: conjuntiva(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (conjunctivaId == null
                              ? null
                              : conjunctivaId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              hairLossId = int.parse(value!);
                            });
                          },
                          items: hairLossList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                hairLossList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText:
                                'Apresenta queda de pelo fora do comum?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (hairLossId == null
                              ? null
                              : hairLossId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              dullHairId = int.parse(value!);
                            });
                          },
                          items: dullHairList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                dullHairList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Apresenta pelo sem brilho?',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (dullHairId == null
                              ? null
                              : dullHairId.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              hairFailureId = int.parse(value!);
                              if (hairFailureId == 1) {
                                _registerSymptomQuestion('C', 65);
                              } else {
                                _registerSymptomQuestion('E', 65);
                              }
                            });
                          },
                          items: hairFailureList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                hairFailureList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Apresenta alguma falha no pelo?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (hairFailureId == null
                              ? null
                              : hairFailureId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              brittleHairId = int.parse(value!);
                            });
                          },
                          items: brittleHairList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                brittleHairList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Apresenta pelo quebradiço?',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (brittleHairId == null
                              ? null
                              : brittleHairId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              abnormalPlacementId = int.parse(value!);
                              if (abnormalPlacementId == 1) {
                                _registerSymptomQuestion('C', 80);
                              } else {
                                _registerSymptomQuestion('E', 80);
                              }
                            });
                          },
                          items: abnormalPlacementList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                abnormalPlacementList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText:
                                'Apresenta coloração de pele fora do normal em alguma área?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (abnormalPlacementId == null
                              ? null
                              : abnormalPlacementId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              bodyStateId = int.parse(value!);
                            });
                          },
                          items: bodyStateList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                bodyStateList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText:
                                'Qual a sua avaliação do estado corporal do seu pet?(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (bodyStateId == null
                              ? null
                              : bodyStateId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      // Use o Expanded para limitar a largura do DropdownButtonFormField
                      child: SizedBox(
                        height: 40,
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              bodyScoreId = int.parse(value!);

                              if (bodyScoreId == 1 || bodyScoreId == 2) {
                                _registerSymptomQuestion('C', 24);
                                _registerSymptomQuestion('E', 45);
                              } else if (bodyScoreId == 6 || bodyScoreId == 7) {
                                _registerSymptomQuestion('C', 45);
                                _registerSymptomQuestion('E', 24);
                              } else {
                                _registerSymptomQuestion('E', 24);
                                _registerSymptomQuestion('E', 45);
                              }
                            });
                          },
                          items: bodyScoreList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(
                                bodyScoreList[key]!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText:
                                'Inspeção através da câmera: Score corporal(*)',
                            labelStyle: const TextStyle(fontSize: 13.0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          ),
                          value: (bodyScoreId == null
                              ? null
                              : bodyScoreId.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
                // proximas perguntas
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _symptomTab() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 206, 205, 205)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
          child: Column(
            children: [
              const SizedBox(width: 10.0),
              FutureBuilder<List<dynamic>>(
                  future: _fetchPetSymptoms(),
                  builder: (context, snapshot) {
                    /*if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else */
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      // final List<dynamic> data = snapshot.data!;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: PetSymptomData().petSymptomList.length,
                            itemBuilder: (context, index) {
                              final petSymptom =
                                  PetSymptomData().petSymptomList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:
                                      60, // Defina a altura desejada para o card
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
                                      _petSymptomId = petSymptom.petSymptomId;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                petSymptom.name!,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Colors.red,
                                                onPressed: () {
                                                  setState(() {
                                                    _petSymptomId =
                                                        petSymptom.petSymptomId;
                                                  });
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Form(
                                                        key: _formKey,
                                                        child: AlertDialog(
                                                          title: const Text(
                                                              'Excluir Sintoma?'),
                                                          content: const Text(
                                                              'O sintoma será excluído. Confirma?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                  'Não'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  'Sim'),
                                                              onPressed: () {
                                                                _typeRegister =
                                                                    'D';
                                                                _registerSymptom(
                                                                        context)
                                                                    .then(
                                                                  (value) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                );
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
          bottom: 10, // Define a posição do botão a partir do fundo
          right: 10, // Define a posição do botão a partir da direita
          child: ElevatedButton(
            onPressed: () {
              // Adicionar ação de "Adicionar" aqui
              setState(() {
                _isotherSimptomVisible = false;
              });
              _showSymptom(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _showSymptom(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateMedicine) {
            return Dialog(
              child: Container(
                width: 450,
                height: 250,
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
                              'Sintomas',
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
                              DropdownSearch<SymptomModel>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Sintomas",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                items: SymptomData().symptomList,
                                itemAsString: (SymptomModel symptom) =>
                                    symptom.name,
                                onChanged: (value) {
                                  //print(value.id);
                                  if (value != null) {
                                    _symptomId = int.parse(value.id);
                                  } else {
                                    _symptomId = null;
                                  }
                                  if (_symptomId == 93) {
                                    setStateMedicine(() {
                                      _isotherSimptomVisible = true;
                                    });
                                  } else {
                                    setStateMedicine(() {
                                      _isotherSimptomVisible = false;
                                    });
                                  }

                                  //print(_isotherSimptomVisible);
                                },
                              ),
                              const SizedBox(height: 10.0),
                              Visibility(
                                visible: _isotherSimptomVisible,
                                child: TextFormField(
                                  controller: _otherSymptomController,
                                  decoration: const InputDecoration(
                                    labelText: 'Outro Sintoma',
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
                                setStateMedicine(() {
                                  _typeRegister = 'C';
                                  _registerSymptom(context).then((value) {});
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

  Widget _drVetBotDiseaseTab(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 206, 205, 205)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
          child: Column(
            children: [
              const SizedBox(width: 10.0),
              FutureBuilder<List<dynamic>>(
                  future: _fetchListConsultChatGPT(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(''),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemCount: ConsultChatGPTData()
                                  .consultChatGPTList
                                  .length,
                              itemBuilder: (context, index) {
                                final chatGPT = ConsultChatGPTData()
                                    .consultChatGPTList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:
                                        60, // Defina a altura desejada para o card
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
                                        _chatGPTId = chatGPT.chatGPTId;
                                        _showInfoDesease(chatGPT.description!);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          chatGPT.diseaseName!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Selecionar',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    Switch(
                                                      value: chatGPT.selected,
                                                      onChanged: (bool value) {
                                                        //print(_chatGPTId);
                                                        setState(() {
                                                          _fetchRegisterDiseaseConsultChatGPT(
                                                              chatGPT.chatGPTId,
                                                              value);
                                                        });
                                                      },
                                                      activeTrackColor:
                                                          Colors.lightGreen,
                                                      activeColor: Colors.green,
                                                    ),
                                                  ],
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
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
        Positioned(
          bottom: 10, // Define a posição do botão a partir do fundo
          right: 10, // Define a posição do botão a partir da direita
          child: Stack(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Adicionar ação de "Adicionar" aqui
                  if (PetSymptomData().petSymptomList.isEmpty) {
                    _showMessageErroIA(
                        'Deve ser informador pelo menos um Sintoma para efeturar a Consulta.');
                  } else {
                    setState(() {
                      _firstConsultation = false;
                      _isLoading = true;
                      _fetchConsultChatGPT();

                      _fetchListConsultChatGPT();
                    });
                  }
                },
                child: const Text('Efetuar Consulta Dr. VetBot'),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.5), // Fundo escuro semitransparente
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showInfoDesease(String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Descrição'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description,
                softWrap: true,
              ), // Use a variável _textValidation no Text
              const SizedBox(height: 20), // Espaçamento entre o texto e o botão
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMessageErroIA(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                softWrap: true,
              ), // Use a variável _textValidation no Text
              const SizedBox(height: 20), // Espaçamento entre o texto e o botão
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInfoMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('O(s) campo(s) abaixo é(são) Obrigatório(s)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_textValidation ??
                  ''), // Use a variável _textValidation no Text
              const SizedBox(height: 20), // Espaçamento entre o texto e o botão
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
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
  void initState() {
    super.initState();

    _getVeterinaryCrmv();
  }

  Future<List<dynamic>> _fetchHealthProgram() async {
    List<HealthProgramModel> healthProgramList;
    healthProgramList =
        await healthProgramListApi(_serviceQueue.queueId.toString());

    return healthProgramList;
  }

  Future<List<dynamic>> _fetchPetHealthProgram() async {
    List<PetHealthProgramModel> petHealthProgramList;
    petHealthProgramList =
        await petHealthProgramListApi(_serviceQueue.petId.toString());

    return petHealthProgramList;
  }

  Future<void> _getVeterinaryCrmv() async {
    _veterinaryId = (await UserPreferences.getVeterinaryUserId())!;
    _veterinary = (await UserPreferences.getVeterinaryName())!;
    _crmv = (await UserPreferences.getVeterinaryCrmv())!;
  }

  Future<int?> _fetchRegisterHealtProgram(BuildContext context) async {
    //await _getVeterinaryCrmv();
    await registerHealthProgramApi(
      _typeRegister,
      _serviceQueue.queueId,
      _healthProgramId,
      _petHealthProgramId,
      _veterinaryId,
    );
    return 1;
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
              Text('Programas de Saúde',
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
                  Container(
                    width: double.infinity,
                    height: 400,
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
                          width:
                              double.infinity, // Ocupa todo o espaço horizontal
                          child: const Text(
                            'Disponíveis',
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
                            future: _fetchHealthProgram(),
                            builder: (context, snapshot) {
                              /*if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else */
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                // final List<dynamic> data = snapshot.data!;

                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                        itemCount: HealthProgramData()
                                            .healthProgramList
                                            .length,
                                        itemBuilder: (context, index) {
                                          final healthProgram =
                                              HealthProgramData()
                                                  .healthProgramList[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  //print(petVaccine.);
                                                  _healthProgramId =
                                                      healthProgram
                                                          .healthProgramId;

                                                  _showInfoHealthProgram(
                                                      healthProgram
                                                          .description);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Text(
                                                          healthProgram.action,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
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
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
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
                                'Adicionado(s) ao Pet',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.white, // Cor do texto em branco
                                ),
                              ),
                            ),
                            FutureBuilder<List<dynamic>>(
                                future: _fetchPetHealthProgram(),
                                builder: (context, snapshot) {
                                  /*if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else */
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            itemCount: PetHealthProgramData()
                                                .petHealthProgramList
                                                .length,
                                            itemBuilder: (context, index) {
                                              final petHealthProgram =
                                                  PetHealthProgramData()
                                                          .petHealthProgramList[
                                                      index];
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                      _petHealthProgramId =
                                                          petHealthProgram
                                                              .petHealthProgramId;
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            petHealthProgram
                                                                .action,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              _petHealthProgramId =
                                                                  petHealthProgram
                                                                      .petHealthProgramId;
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          'Excluir Programa de Saúde?'),
                                                                      content:
                                                                          const Text(
                                                                              'O programa de saúde será excluído. Confirma?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Não'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Sim'),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _typeRegister = 'D';
                                                                              _fetchRegisterHealtProgram(context).then(
                                                                                (value) {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              );
                                                                            });
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ],
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

  void _showInfoHealthProgram(String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Descrição'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description,
                softWrap: true,
              ), // Use a variável _textValidation no Text
              const SizedBox(height: 20), // Espaçamento entre o texto e o botão
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                    child: const Text('Fechar'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _typeRegister = 'C';
                        _fetchRegisterHealtProgram(context).then((value) {});
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class RiskClassificationPage extends StatefulWidget {
  const RiskClassificationPage({
    Key? key,
  }) : super(key: key);

  @override
  _RiskClassificationPage createState() => _RiskClassificationPage();
}

class _RiskClassificationPage extends State<RiskClassificationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _serviceQueue.queueOrder == 0
                        ? 'Emergência'
                        : ((_serviceQueue.queueOrder == 1 &&
                                _selectedTypeService != 4)
                            ? 'Consulta Agendada'
                            : _selectedTypeService == 4
                                ? 'Tele Orientação'
                                : 'Consulta'),
                    style: TextStyle(
                        fontSize: 30,
                        color: _serviceQueue.queueOrder == 0
                            ? Colors.red
                            : ((_serviceQueue.queueOrder == 1 &&
                                    _selectedTypeService != 4)
                                ? Colors.yellow
                                : Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Classificação de Risco Preliminar',
                      style: TextStyle(fontSize: 30)),
                ],
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                style: const TextStyle(fontSize: 15.0),
                enabled: false,
                controller: _screningController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(8.0)), // Raio dos cantos da borda
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0), // Cor e largura da borda
                  ),
                  labelText: 'Sintoma',
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Triagem',
                style: TextStyle(color: Colors.grey),
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _serviceQueue.screeningList!.length,
                      itemBuilder: (context, subindex) {
                        return Padding(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.all(1),
                          child: SizedBox(
                            height: 55, // Defina a altura desejada para o card
                            width: double.infinity,
                            child: ListTile(
                              title: Text(
                                  '${subindex + 1}- ${_serviceQueue.screeningList![subindex].question!}'),
                              subtitle: Text(
                                  'R: ${_serviceQueue.screeningList![subindex].answer!}'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ServiceHistoryPage extends StatefulWidget {
  const ServiceHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  _ServiceHistoryPage createState() => _ServiceHistoryPage();
}

class _ServiceHistoryPage extends State<ServiceHistoryPage> {
  @override
  void initState() {
    super.initState();

    _fetchPetServiceHistory();
  }

  Future<List<dynamic>> _fetchPetServiceHistory() async {
    List<PetServiceHistoryModel> petServiceHistoryList;
    petServiceHistoryList =
        await petServiceHistoryListApi(_serviceQueue.petId.toString());

    return petServiceHistoryList;
  }

  Future<List<dynamic>> _fetchAnexoServiceHistory() async {
    return AnexoServiceHistoryData().anexoServiceHistoryList =
        PetServiceHistoryData().getAnexodByServiceFormId(_serviceHistoryId!);
  }

  void _openAnexo(String url) {
    html.AnchorElement(href: url)
      ..target = 'blank'
      ..click();
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
              Text('Histórico de Atendimentos', style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(width: 10.0),
          FutureBuilder<List<dynamic>>(
              future: _fetchPetServiceHistory(),
              builder: (context, snapshot) {
                /*if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else */
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // final List<dynamic> data = snapshot.data!;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: PetServiceHistoryData()
                            .petServiceHistoryList
                            .length,
                        itemBuilder: (context, index) {
                          final petServiceHistory = PetServiceHistoryData()
                              .petServiceHistoryList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  250, // Defina a altura desejada para o card
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
                                  //_petServiceFormId = petServiceHistory.serviceFormId;
                                  //_vaccineId = petVaccine.vaccineId;
                                  //_showPetVaccineDoseList(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                petServiceHistory
                                                        .servicedByPetner
                                                    ? '(Relalizado Pela Petner)'
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 13,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Data: ${petServiceHistory.serviceFormDate}',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            petServiceHistory.servicedByPetner
                                                ? 'Queixa Inicial: ${petServiceHistory.screeningName}'
                                                : 'Tipo do Evento: ${petServiceHistory.typeServiceForm}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Visibility(
                                        visible:
                                            petServiceHistory.servicedByPetner,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Tipo Ficha: ${petServiceHistory.typeServiceForm}'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Veterinário: ${petServiceHistory.veterinary}'),
                                          const SizedBox(width: 10.0),
                                          Text(
                                              'Crmv: ${petServiceHistory.crmv}'),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Visibility(
                                        visible:
                                            petServiceHistory.servicedByPetner,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Diagnóstico: ${petServiceHistory.diagnostic}'),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(petServiceHistory
                                                        .exameList!.isEmpty
                                                    ? 'Nenhum Exame Solicitado'
                                                    : 'Foram Solicitados Exames'),
                                                const SizedBox(width: 10.0),
                                                Text(petServiceHistory
                                                        .medicineList!.isEmpty
                                                    ? 'Sem Prescrição de Medicamento'
                                                    : 'Com Prescrição de Medicamento'),
                                              ],
                                            ),
                                            const SizedBox(height: 10.0),
                                            Text(
                                                'Classificação Final: ${petServiceHistory.riskRating}'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _serviceHistoryId =
                                                  petServiceHistory
                                                      .serviceFormId;
                                              _showAnexo(context);
                                              //print('Texto clicado!');
                                            },
                                            child: Text(
                                              petServiceHistory.attachment
                                                  ? 'Existem Anexos (clique aqui)'
                                                  : '',
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blue,
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
    );
  }

  void _showAnexo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 600.0,
            height: 300.0,
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
                        'Anexo(s)',
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
                    future: _fetchAnexoServiceHistory(),
                    builder: (context, snapshot) {
                      /*if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else */
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: AnexoServiceHistoryData()
                                  .anexoServiceHistoryList
                                  .length,
                              itemBuilder: (context, index) {
                                final anexo = AnexoServiceHistoryData()
                                    .anexoServiceHistoryList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  _openAnexo(anexo.url);
                                                },
                                                child: Text(
                                                  'Arquivo: ${anexo.fileName}',
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                          Navigator.of(context).pop();
                        },
                        child: const Text('Fechar'),
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
  }
}

class HealthProgramPagePet extends StatefulWidget {
  const HealthProgramPagePet({
    Key? key,
  }) : super(key: key);

  @override
  _HealthProgramPagePet createState() => _HealthProgramPagePet();
}

class _HealthProgramPagePet extends State<HealthProgramPagePet> {
  @override
  void initState() {
    super.initState();

    _fetchPetHealthProgram();
  }

  Future<List<dynamic>> _fetchPetHealthProgram() async {
    List<PetHealthProgramModel> petHealthProgramList;
    petHealthProgramList =
        await petHealthProgramListApi(_serviceQueue.petId.toString());

    return petHealthProgramList;
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
              Text('Programas de Saúde do Pet', style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(width: 10.0),
          FutureBuilder<List<dynamic>>(
              future: _fetchPetHealthProgram(),
              builder: (context, snapshot) {
                /*if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else */
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // final List<dynamic> data = snapshot.data!;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount:
                            PetHealthProgramData().petHealthProgramList.length,
                        itemBuilder: (context, index) {
                          final petHealthProgram = PetHealthProgramData()
                              .petHealthProgramList[index];
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
                                  //_petServiceFormId = petHealthProgram.serviceFormId;
                                  //_vaccineId = petVaccine.vaccineId;
                                  //_showPetVaccineDoseList(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Descrição: ${petHealthProgram.name}',
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                ),
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
    );
  }
}

class FinalGuidelinesPage extends StatefulWidget {
  const FinalGuidelinesPage({
    Key? key,
  }) : super(key: key);

  @override
  _FinalGuidelinesPage createState() => _FinalGuidelinesPage();
}

class _FinalGuidelinesPage extends State<FinalGuidelinesPage> {
  final Map<String, String> finalClassificationList = {
    '1': 'Baixo Risco',
    '2': 'Emergência',
  };

  final Map<String, String> reasonRefusedHospitalList = {
    '1': 'Tutor fora da Área de Cobertura',
    '2': 'Tutor recusou Hospitais Disponíveis',
  };

  @override
  void initState() {
    super.initState();

    _fetchPetHealthProgram();
  }

  Future<List<dynamic>> _fetchPetHealthProgram() async {
    List<PetHealthProgramModel> petHealthProgramList;
    petHealthProgramList =
        await petHealthProgramListApi(_serviceQueue.petId.toString());

    return petHealthProgramList;
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
              Text('Orientações Finais', style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            height: 40,
            child: DropdownButtonFormField<String>(
              //validator: _validateDropDown,
              isDense: true,
              onChanged: (value) {
                setState(() {
                  finalClassificationId = int.parse(value!);

                  if (finalClassificationId == 2) {
                    validationEmergency = true;
                  } else {
                    hospitalId = null;
                    validationEmergency = false;
                  }
                });
              },
              items: finalClassificationList.keys.map((key) {
                return DropdownMenuItem<String>(
                  enabled: !_isEmergency,
                  value: key,
                  child: Text(
                    finalClassificationList[key]!,
                    style: const TextStyle(fontSize: 13.0),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Classificação Final?',
                labelStyle: const TextStyle(fontSize: 13.0),
                contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              ),
              value: (finalClassificationId == null
                  ? null
                  : finalClassificationId.toString()),
            ),
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: validationEmergency!,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              height: _serviceQueue.emergencyReleased! == true ? 40.0 : 80.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Cor da borda
                  width: 1.0, // Largura da borda
                ),
                borderRadius:
                    BorderRadius.circular(8.0), // Raio dos cantos da borda
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      _serviceQueue.emergencyReleased! == true
                          ? 'Emergência Liberada'
                          : 'Emergência Bloqueada - ${_serviceQueue.emergencyMessage!}',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: (!_serviceQueue.emergencyReleased!
                              ? Colors.red
                              : Colors.black))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: validationEmergency! &&
                _serviceQueue.emergencyReleased! == true,
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<String>(
                //validator: _validateDropDown,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    hospitalId = int.parse(value!);
                    HospitalListModel? hospitalModel =
                        _serviceQueue.hospitalList.firstWhere(
                            (hospital) => hospital.hospitalId == hospitalId);
                    hospitalAddress = hospitalModel.hospitalAddress;
                    _isHospitalAddress = true;
                  });
                },
                items: _serviceQueue.hospitalList.map((hospital) {
                  return DropdownMenuItem<String>(
                    value: hospital.hospitalId.toString(),
                    child: Text(
                      hospital.hospitalName,
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Selecione um Hospital para a Emergência',
                  labelStyle: const TextStyle(fontSize: 13.0),
                  contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                ),
                value: (hospitalId == null ? null : hospitalId.toString()),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: _isHospitalAddress,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              height: _serviceQueue.emergencyReleased! == true ? 40.0 : 80.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Cor da borda
                  width: 1.0, // Largura da borda
                ),
                borderRadius:
                    BorderRadius.circular(8.0), // Raio dos cantos da borda
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Endereço: $hospitalAddress!',
                      style: const TextStyle(fontSize: 13.0)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: validationEmergency! &&
                _serviceQueue.emergencyReleased! == true,
            child: Row(
              children: [
                Checkbox(
                  value: isRefusedHospital,
                  onChanged: (bool? newValue) {
                    setState(() {
                      isRefusedHospital = newValue!;
                    });
                  },
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isRefusedHospital = !isRefusedHospital;
                    });
                  },
                  child: const Text('Tutor não irá encaminhar PET ao Hospital.',
                      style: const TextStyle(fontSize: 13.0)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: isRefusedHospital,
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<String>(
                //validator: _validateDropDown,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    reasonRefusedHospitalId = int.parse(value!);
                  });
                },
                items: reasonRefusedHospitalList.keys.map((key) {
                  return DropdownMenuItem<String>(
                    enabled: true,
                    value: key,
                    child: Text(
                      reasonRefusedHospitalList[key]!,
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Motivo do não encaminhamento do PET ao Hospital?',
                  labelStyle: const TextStyle(fontSize: 13.0),
                  contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                ),
                value: (reasonRefusedHospitalId == null
                    ? null
                    : reasonRefusedHospitalId.toString()),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 13.0),
              controller: _finalGuidelinesController,
              decoration: const InputDecoration(
                border:
                    InputBorder.none, // Remova a borda padrão do TextFormField
                labelText: 'Orientações Finais',
                labelStyle: const TextStyle(fontSize: 13.0),
                contentPadding: EdgeInsets.all(8.0), // Adicione espaço interno
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiagnosticClosure extends StatefulWidget {
  const DiagnosticClosure({
    Key? key,
  }) : super(key: key);

  @override
  _DiagnosticClosure createState() => _DiagnosticClosure();
}

class _DiagnosticClosure extends State<DiagnosticClosure> {
  bool _isotherDiseaseVisible = false;

  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
  }

  Future<List<dynamic>> _fetchPetDiseaesService() async {
    List<PetDiseaseServiceModel> petDiseaseServiceList;
    petDiseaseServiceList =
        await petDiseaseServiceListApi(_serviceQueue.queueId);

    return petDiseaseServiceList;
  }

  Future<int?> _registerDiseaseService(BuildContext context) async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerDiseaseServiceApi(
        _typeRegister,
        _serviceQueue.queueId,
        _diseaseId!,
        _otherDiseaseController.text,
        _petDiseaseServiceId,
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      if (responseData['validateRegisterChronicDisease'] != null) {
        return responseData['validateRegisterChronicDisease'];
      } else {
        return responseData['validateRegisterDisease'];
      }
    }
  }

  Future<List<dynamic>> _fetchListConsultChatGPT() async {
    List<ConsultChatGPTModel> consultChatGPTList;
    consultChatGPTList = await listConsultChatGPTApi(2, _serviceQueue.queueId);

    return consultChatGPTList;
  }

  Future<void> _fetchConsultChatGPT() async {
    List<ConsultChatGPTModel> consultChatGPTList;
    consultChatGPTList = await consultChatGPTApi(2, _serviceQueue.queueId);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchRegisterPrescriptionConsultChatGPT(
      int chatGPTId, bool selected) async {
    await registerPrescriptionConsultChatGPTApi(chatGPTId, selected);
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
              Text('Fechamento de Diagnóstico',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(fontSize: 30)),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.maxFinite,
            height: 452,
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color.fromARGB(255, 206, 205, 205)),
              borderRadius: BorderRadius.circular(5.0),
            ),
            //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
            child: DefaultTabController(
              length: 2, // Número de abas
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0,
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Possível(eis) Diagnóstico(s)'),
                      Tab(text: 'Dr. VetBot (Prescrição(ões))'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _diseaseTab(), //Text('Teste'), ////SintomaTab(),
                    _drVetBotPrescriptionTab(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _diseaseTab() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 390,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 206, 205, 205)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                  future: _fetchPetDiseaesService(),
                  builder: (context, snapshot) {
                    /*if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else */
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      // final List<dynamic> data = snapshot.data!;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemCount: PetDiseaseServiceData()
                                  .petDiseaseServiceList
                                  .length,
                              itemBuilder: (context, index) {
                                final petDiseaseService =
                                    PetDiseaseServiceData()
                                        .petDiseaseServiceList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:
                                        70, // Defina a altura desejada para o card
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
                                        _petDiseaseServiceId = petDiseaseService
                                            .petDiseaseServiceId;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  petDiseaseService.name!,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    //setState(() {
                                                    _diseaseId = '0';
                                                    _petDiseaseServiceId =
                                                        petDiseaseService
                                                            .petDiseaseServiceId;
                                                    //});
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Form(
                                                          key: _formKey,
                                                          child: AlertDialog(
                                                            title: const Text(
                                                                'Excluir Doença?'),
                                                            content: const Text(
                                                                'A Doença será Excluída. Confirma?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Não'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Sim'),
                                                                onPressed: () {
                                                                  _typeRegister =
                                                                      'D';
                                                                  _registerDiseaseService(
                                                                          context)
                                                                      .then(
                                                                    (value) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  );
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
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
        Positioned(
          bottom: 10, // Define a posição do botão a partir do fundo
          right: 10, // Define a posição do botão a partir da direita
          child: ElevatedButton(
            onPressed: () {
              //setState(() {
              _isotherDiseaseVisible = false;
              //});
              _showDisease(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _showDisease(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 450,
                height: 250,
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
                              'Lista de Doenças',
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
                              DropdownSearch<DiseaseModel>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Doenças",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                items: DiseaseData()
                                    .diseaseList
                                    .where((diseases) =>
                                        diseases.specieId ==
                                        _serviceQueue.specieId)
                                    .toList(),
                                itemAsString: (DiseaseModel disease) =>
                                    disease.name,
                                onChanged: (value) {
                                  if (value != null) {
                                    _diseaseId = value.id;
                                  } else {
                                    _diseaseId = null;
                                  }
                                  if (_diseaseId == '171') {
                                    setState(() {
                                      _isotherDiseaseVisible = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isotherDiseaseVisible = false;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 10.0),
                              Visibility(
                                visible: _isotherDiseaseVisible,
                                child: TextFormField(
                                  controller: _otherDiseaseController,
                                  decoration: const InputDecoration(
                                    labelText: 'Outra Doença',
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
                                  _registerDiseaseService(context)
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

  Widget _drVetBotPrescriptionTab(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 206, 205, 205)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          //padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento para espaçamento interno
          child: Column(
            children: [
              const SizedBox(width: 10.0),
              FutureBuilder<List<dynamic>>(
                  future: _fetchListConsultChatGPT(),
                  builder: (context, snapshot) {
                    /*if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else */
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      // final List<dynamic> data = snapshot.data!;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemCount: ConsultChatGPTData()
                                  .consultChatGPTList
                                  .length,
                              itemBuilder: (context, index) {
                                final chatGPT = ConsultChatGPTData()
                                    .consultChatGPTList[index];
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
                                        _chatGPTId = chatGPT.chatGPTId;
                                        //_showInfoDesease(chatGPT.description!);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Medicamento: ${chatGPT.medicineName!}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(
                                                    'Uso Humano: ${chatGPT.humanUse! == true ? "Sim" : "Não"}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                    maxLines: 3,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(
                                                    'Quantidade: ${chatGPT.amount!}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(
                                                    'Tipo Uso: ${chatGPT.useType!}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Text(
                                                    'Posologia: ${chatGPT.dosage!}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Text(
                                                  'Selecionar',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                Switch(
                                                  value: chatGPT.selected,
                                                  onChanged: (bool value) {
                                                    //print(chatGPT.chatGPTId);
                                                    setState(() {
                                                      _fetchRegisterPrescriptionConsultChatGPT(
                                                          chatGPT.chatGPTId,
                                                          value);
                                                    });
                                                  },
                                                  activeTrackColor:
                                                      Colors.lightGreen,
                                                  activeColor: Colors.green,
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
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
        Positioned(
          bottom: 10, // Define a posição do botão a partir do fundo
          right: 10, // Define a posição do botão a partir da direita
          child: Stack(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Adicionar ação de "Adicionar" aqui
                  if (DiseaseData().diseaseList.isEmpty) {
                    _showMessageErroIA(
                        'Deve ser informador pelo menos uma Doença para efeturar a Consulta.');
                  } else {
                    setState(() {
                      _isLoading = true;
                      _fetchConsultChatGPT();

                      _fetchListConsultChatGPT();
                    });
                  }
                },
                child: const Text('Efetuar Consulta Dr. VetBot'),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.5), // Fundo escuro semitransparente
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMessageErroIA(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                softWrap: true,
              ), // Use a variável _textValidation no Text
              const SizedBox(height: 20), // Espaçamento entre o texto e o botão
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PrescriptionReferralPage extends StatefulWidget {
  const PrescriptionReferralPage({
    Key? key,
  }) : super(key: key);

  @override
  _PrescriptionReferralPage createState() => _PrescriptionReferralPage();
}

class _PrescriptionReferralPage extends State<PrescriptionReferralPage> {
  double _heigthShowMedicineVaccine = 200;
  bool _isotherMedicineVisible = false;
  bool veterinaryUse = false;

  final Map<String, String> medicineVaccineList = {
    '1': 'Medicamento',
    '2': 'Vacina',
  };

  final Map<String, String> examConsultationList = {
    '1': 'Exame',
    '2': 'Consulta',
  };

  final Map<String, String> useTypeList = {
    '1': 'Cutâneo',
    '2': 'Injetável',
    '3': 'Intranasal',
    '4': 'Oftálmico',
    '5': 'Oral',
    '6': 'Otológico',
    '7': 'Retal',
    '8': 'Tópico',
    '9': 'Vaginal',
    '10': 'Outro',
  };

  String? _validateDropDownModel(VaccineModel? value) {
    if (value == null || value.name.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opção';
    }
    return null;
  }

  Future<List<dynamic>> _fetchPetMedicines() async {
    List<PetMedicineModel> petMedicineList;
    petMedicineList = await petMedicineListApi(
      2,
      _serviceQueue.petId.toString(),
      _serviceQueue.queueId.toString(),
    );

    return petMedicineList;
  }

  Future<int?> _registerMedicine(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerMedicineApi(
        2,
        _typeRegister,
        _serviceQueue.petId.toString(),
        _serviceQueue.queueId.toString(),
        _medicineId,
        _petMedicineId.toString(),
        _otherMedicineController.text,
        false,
        useTypeId,
        _amountMedicineController.text,
        _dosageController.text,
        veterinaryUse,
        typePrescriptionId,
        _vaccineId.toString(),
        _petVaccineId.toString(),
        _vaccineDoseId,
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterMedicine'];
    }

    setState(() {
      _isLoading = false;
    });

    return 4;
  }

  Future<List<dynamic>> _fetchPetForwarding() async {
    List<PetForwardingModel> petForwardingList;
    petForwardingList = await petForwardingListApi(_serviceQueue.queueId);

    return petForwardingList;
  }

  Future<int?> _registerForwarding(BuildContext context) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> responseData = await registerForwardingApi(
        _typeRegister,
        _serviceQueue.queueId,
        _forwardingId,
        _petForwardingId,
      );

      setState(() {
        _isLoading = false;
      });

      //return 1;
      return responseData['validateRegisterMedicine'];
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
              Text('Prescrição/Encaminhamento',
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
                        height: 300,
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
                                'Prescrição Medicamento/Vacina',
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
                                future: _fetchPetMedicines(),
                                builder: (context, snapshot) {
                                  /*if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child:
                                      null, //CircularProgressIndicator(),
                                );
                              } else */
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            itemCount: PetMedicineData()
                                                .petMedicineList
                                                .length,
                                            itemBuilder: (context, index) {
                                              final petMedicine =
                                                  PetMedicineData()
                                                      .petMedicineList[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height:
                                                      150, // Defina a altura desejada para o card
                                                  width: double
                                                      .infinity, // Defina a largura desejada para o card

                                                  // Estilize o card com o BoxDecoration ou o Card widget
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                      if (petMedicine
                                                              .petMedicineId !=
                                                          0) {
                                                        _petMedicineId =
                                                            petMedicine
                                                                .petMedicineId;
                                                      } else {
                                                        _petVaccineId =
                                                            petMedicine
                                                                .petVaccineId;
                                                      }
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
                                                          if (petMedicine
                                                                  .petMedicineId !=
                                                              0) ...[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Medicamento: ${petMedicine.name!}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10.0),
                                                                      Text(
                                                                        'Uso Humano: ${petMedicine.veterinaryUse! == true ? "Não" : "Sim"}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                        maxLines:
                                                                            3,
                                                                        softWrap:
                                                                            true,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10.0),
                                                                      Text(
                                                                        'Quantidade: ${petMedicine.amountMedicine!}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10.0),
                                                                      Text(
                                                                        'Tipo Uso: ${useTypeList.values.elementAt(int.parse(petMedicine.useTypeId!) - 1)}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10.0),
                                                                      Text(
                                                                        'Posologia: ${petMedicine.dosage!}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete),
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _petMedicineId =
                                                                          petMedicine
                                                                              .petMedicineId;
                                                                    });
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              AlertDialog(
                                                                            title:
                                                                                const Text('Excluir Prescrição?'),
                                                                            content:
                                                                                const Text('A Prescrição será Excluída. Confirma?'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                child: const Text('Não'),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                child: const Text('Sim'),
                                                                                onPressed: () {
                                                                                  _typeRegister = 'D';
                                                                                  _registerMedicine(context).then(
                                                                                    (value) {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  );
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
                                                              ],
                                                            ),
                                                          ],
                                                          if (petMedicine
                                                                  .petVaccineId !=
                                                              0) ...[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Vacina: ${petMedicine.name!}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10.0),
                                                                      Text(
                                                                        'Tipo Dose: ${petMedicine.doseName}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                        maxLines:
                                                                            3,
                                                                        softWrap:
                                                                            true,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete),
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _petVaccineId =
                                                                          petMedicine
                                                                              .petVaccineId;
                                                                      _petMedicineId =
                                                                          0;
                                                                    });
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              AlertDialog(
                                                                            title:
                                                                                const Text('Excluir Prescrição?'),
                                                                            content:
                                                                                const Text('A Prescrição será Excluída. Confirma?'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                child: const Text('Não'),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                child: const Text('Sim'),
                                                                                onPressed: () {
                                                                                  _typeRegister = 'D';
                                                                                  _registerMedicine(context).then(
                                                                                    (value) {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  );
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
                                                              ],
                                                            ),
                                                          ],
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                            //setState(() {
                            _isotherMedicineVisible = false;
                            typePrescriptionId = null;
                            _vaccineId = null;
                            _heigthShowMedicineVaccine = 200;
                            //});

                            _showMedicneVaccine(context);
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
                        height: 300,
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
                                'Encaminhamento',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.white, // Cor do texto em branco
                                ),
                              ),
                            ),
                            FutureBuilder<List<dynamic>>(
                                future: _fetchPetForwarding(),
                                builder: (context, snapshot) {
                                  /*if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else */
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    // final List<dynamic> data = snapshot.data!;

                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            itemCount: PetForwardingData()
                                                .petForwardingList
                                                .length,
                                            itemBuilder: (context, index) {
                                              final petForwordnig =
                                                  PetForwardingData()
                                                      .petForwardingList[index];
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                      _petForwardingId =
                                                          petForwordnig
                                                              .petForwardingId;
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${petForwordnig.forwardingType!}: ${petForwordnig.forwardingName!}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              setState(() {
                                                                _petForwardingId =
                                                                    petForwordnig
                                                                        .petForwardingId;
                                                              });
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          'Excluir Encaminhamento?'),
                                                                      content:
                                                                          const Text(
                                                                              'O encaminhamento será excluído. Confirma?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Não'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Sim'),
                                                                          onPressed:
                                                                              () {
                                                                            _typeRegister =
                                                                                'D';

                                                                            _registerForwarding(context).then(
                                                                              (value) {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            );
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                            // Adicionar ação de "Adicionar" aqui
                            /*
                        setState(() {
                          _isotherMedicineVisible = false;
                        });
                        */
                            typeForwardingId = null;
                            _forwardingId = null;
                            _heigthShowMedicineVaccine = 200;
                            _showExamConsultation(context);
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

  void _showMedicneVaccine(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 800,
                height: _heigthShowMedicineVaccine,
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
                              'Medicamentos/Vacinas',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            //print(value);
                            setState(() {
                              typePrescriptionId = int.parse(value!);
                              if (value == '1') {
                                _heigthShowMedicineVaccine = 550;
                              } else {
                                _heigthShowMedicineVaccine = 350;
                              }
                            });
                          },
                          items: medicineVaccineList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(medicineVaccineList[key]!),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Medicamento ou Vacina?'),
                          value: (typePrescriptionId == null
                              ? null
                              : typePrescriptionId.toString()),
                        ),
                      ),
                      if (typePrescriptionId == 1) ...[
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                DropdownSearch<MedicineModel>(
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: "Selecinar Medicamento",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  items: MedicineData()
                                      .medicineList
                                      .where((medicines) =>
                                          medicines.id == '941' ||
                                          medicines.specieId ==
                                              _serviceQueue.specieId)
                                      .toList(),
                                  itemAsString: (MedicineModel medicine) =>
                                      medicine.name,
                                  onChanged: (value) {
                                    if (value != null) {
                                      _medicineId = value.id;
                                    } else {
                                      _medicineId = null;
                                    }
                                    setState(() {
                                      veterinaryUse = value!.veterinaryUse;
                                    });

                                    if (_medicineId == '941') {
                                      setState(() {
                                        _isotherMedicineVisible = true;
                                      });
                                    } else {
                                      setState(() {
                                        _isotherMedicineVisible = false;
                                      });
                                    }
                                  },
                                ),
                                Visibility(
                                  visible: _isotherMedicineVisible,
                                  child: const SizedBox(height: 10.0),
                                ),
                                Visibility(
                                  visible: _isotherMedicineVisible,
                                  child: TextFormField(
                                    controller: _otherMedicineController,
                                    decoration: const InputDecoration(
                                      labelText: 'Outro Medicamento',
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
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButtonFormField<String>(
                                        validator: _validateDropDown,
                                        isDense: true,
                                        onChanged: (value) {
                                          //print(value);
                                          setState(() {
                                            useTypeId = int.parse(value!);
                                          });
                                        },
                                        items: useTypeList.keys.map((key) {
                                          return DropdownMenuItem<String>(
                                            value: key,
                                            child: Text(useTypeList[key]!),
                                          );
                                        }).toList(),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: 'Tipo de Uso?'),
                                        value: (useTypeId == null
                                            ? null
                                            : useTypeId.toString()),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Uso Veterinário?',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              veterinaryUse ? 'Sim' : 'Não',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            Switch(
                                              value: veterinaryUse,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  veterinaryUse = value;
                                                });
                                              },
                                              activeTrackColor:
                                                  Colors.lightGreen,
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 15.0),
                                        controller: _amountMedicineController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    8.0)), // Raio dos cantos da borda
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width:
                                                    1.0), // Cor e largura da borda
                                          ),
                                          labelText: 'Quantidade',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: const TextStyle(fontSize: 15.0),
                                    controller: _dosageController,
                                    decoration: const InputDecoration(
                                      border: InputBorder
                                          .none, // Remova a borda padrão do TextFormField
                                      labelText: 'Posologia',
                                      contentPadding: EdgeInsets.all(
                                          8.0), // Adicione espaço interno
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (typePrescriptionId == 2) ...[
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<VaccineModel>(
                            validator: (value) =>
                                value == null ? 'Campo obrigatório' : null,
                            isDense: true,
                            onChanged: (value) {
                              //print(value);
                              setState(() {
                                _vaccineId = value!.vaccineId;
                              });
                            },
                            items: VaccineData()
                                .vaccineList
                                .where((vaccines) =>
                                    vaccines.specieId == _specieId)
                                .map((vaccine) {
                              return DropdownMenuItem<VaccineModel>(
                                value: vaccine,
                                child: Text(vaccine.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Selecione uma Vacina'),
                            value: _vaccineId != null
                                ? VaccineData().vaccineList.firstWhere(
                                    (vaccine) =>
                                        vaccine.vaccineId == _vaccineId)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<VaccineDoseModel>(
                            validator: (value) =>
                                value == null ? 'Campo obrigatório' : null,
                            isDense: true,
                            onChanged: (value) {
                              //print(value!.vaccineDoseId);
                              setState(() {
                                _vaccineDoseId =
                                    value!.vaccineDoseId.toString();
                              });
                            },
                            items: VaccineDoseData()
                                .vaccineDoseList
                                .where((vaccinesDose) =>
                                    vaccinesDose.vaccineId == _vaccineId)
                                .map((vaccineDose) {
                              return DropdownMenuItem<VaccineDoseModel>(
                                value: vaccineDose,
                                child: Text(vaccineDose.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Selecione uma Dose'),
                            /*
                            value: _vaccineDoseId != null
                                ? VaccineDoseData().vaccineDoseList.firstWhere(
                                    (vaccineDose) =>
                                        vaccineDose.vaccineDoseId ==
                                        _vaccineDoseId)
                                : null, */
                          ),
                        ),
                      ],
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
                                  _registerMedicine(context).then((value) {});
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

  void _showExamConsultation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 800,
                height: _heigthShowMedicineVaccine,
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
                              'Exames/Consultas',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          validator: _validateDropDown,
                          isDense: true,
                          onChanged: (value) {
                            //print(value);
                            setState(() {
                              typeForwardingId = int.parse(value!);
                              _forwardingId = null;
                              if (value == '1') {
                                _heigthShowMedicineVaccine = 280;
                              } else {
                                _heigthShowMedicineVaccine = 280;
                              }
                            });
                          },
                          items: examConsultationList.keys.map((key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(examConsultationList[key]!),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Exame ou Consulta?'),
                          value: (typeForwardingId == null
                              ? null
                              : typeForwardingId.toString()),
                        ),
                      ),
                      if (typeForwardingId == 1) ...[
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              DropdownSearch<ExamModel>(
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Selecinar Exame",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                items: ExamData()
                                    .examList
                                    .where((exam) =>
                                        (exam.dog == true &&
                                            _serviceQueue.specieId == 1) ||
                                        (exam.cat == true &&
                                            _serviceQueue.specieId == 2))
                                    .toList(),
                                itemAsString: (ExamModel exam) => exam.name,
                                onChanged: (value) {
                                  if (value != null) {
                                    _forwardingId = value.id;
                                  } else {
                                    _forwardingId = null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (typeForwardingId == 2) ...[
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<ConsultationModel>(
                            validator: (value) =>
                                value == null ? 'Campo obrigatório' : null,
                            isDense: true,
                            onChanged: (value) {
                              //print(value);
                              setState(() {
                                _forwardingId = value!.id;
                              });
                            },
                            items: ConsultationData()
                                .consultationList
                                .map((consultation) {
                              return DropdownMenuItem<ConsultationModel>(
                                value: consultation,
                                child: Text(consultation.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Selecione uma Consutla'),
                            value: _forwardingId != null
                                ? ConsultationData()
                                    .consultationList
                                    .firstWhere((consultation) =>
                                        consultation.id == _forwardingId)
                                : null,
                          ),
                        ),
                      ],
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
                                  _registerForwarding(context).then((value) {});
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

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutPage createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              Navigator.of(Routes.navigatorKey!.currentContext!)
                  .pushReplacementNamed('/serviceQuery');
            });
          },
          child: const Text('Voltar a Fila de Atendimento')),
    );
  }
}
