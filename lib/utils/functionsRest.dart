// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petner_web/models/ActivityTypeModel.dart';
import 'package:petner_web/models/coatModel.dart';
import 'package:petner_web/models/diseaseModel.dart';
import 'package:petner_web/models/fileTypeModel.dart';
import 'package:petner_web/models/healthEventFileTypeModel.dart';
import 'package:petner_web/models/healthEventTypeModel.dart';
import 'package:petner_web/models/petActivityModel.dart';
import 'package:petner_web/models/petAllergyModel.dart';
import 'package:petner_web/models/petDiseaseModel.dart';
import 'package:petner_web/models/petHealthProgramModel.dart';
import 'package:petner_web/models/petMedicineModel.dart';
import 'package:petner_web/models/petSericeHistoryModel.dart';
import 'package:petner_web/models/petShceduleActivityModel.dart';
import 'package:petner_web/models/petSymptomModel.dart';
import 'package:petner_web/models/questionAnswerModel.dart';
import 'package:petner_web/models/screeningQuestionListModel.dart';
import 'package:petner_web/models/screeningReasonmodel.dart';
import 'package:petner_web/models/serviceQueueModel.dart';
import 'package:petner_web/models/speciedModel.dart';
import 'package:petner_web/shared/data/PetActivityData.dart';
import 'package:petner_web/shared/data/petAllergyData.dart';
import 'package:petner_web/shared/data/petDiseaseData.dart';
import 'package:petner_web/shared/data/petHealthProgramData.dart';
import 'package:petner_web/shared/data/petMedicineData.dart';
import 'package:petner_web/shared/data/petScheduleActivityData.dart';
import 'package:petner_web/shared/data/petServiceHIstoryData.dart';
import 'package:petner_web/shared/data/petSymptomData.dart';
import 'package:petner_web/shared/data/userData.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:http/http.dart' as http;
import 'package:petner_web/models/cityModel.dart';
import 'package:petner_web/models/fileListModel.dart';
import 'package:petner_web/models/petModel.dart';
import 'package:petner_web/models/petShceduleTreatmentModel.dart';
import 'package:petner_web/models/petTreatmentModel.dart';
import 'package:petner_web/models/petVaccineCardModel.dart';
import 'package:petner_web/models/raceModel.dart';
import 'package:petner_web/models/speciedModel.dart';
import 'package:petner_web/models/vaccineBrandModel.dart';
import 'package:petner_web/models/vaccineDoseModel.dart';
import 'package:petner_web/models/vaccineModel.dart';
import 'package:petner_web/shared/data/petData.dart';
import 'package:petner_web/shared/data/petFileListData.dart';
import 'package:petner_web/shared/data/petScheduleTreatmentData.dart';
import 'package:petner_web/shared/data/petTreatmentData.dart';
import 'package:petner_web/shared/data/petVaccineData.dart';
import 'package:petner_web/shared/data/raceData.dart';
import 'package:petner_web/shared/data/specieData.dart';
import 'package:petner_web/shared/data/tutorData.dart';
import 'package:petner_web/shared/data/userPreference.dart';
import 'package:petner_web/shared/data/vaccineBrandData.dart';
import 'package:petner_web/shared/data/vaccineData.dart';
import 'package:petner_web/shared/data/vaccineDoseData.dart';
import 'package:petner_web/utils/functions.dart';

const headerBasic = 'Basic BZpR465EewtRd795gfh\$_dyRE34*%';

Future<Map<String, dynamic>> validateUserApi(
    String email, String password, int typeLogin) async {
  const url = 'https://adm.petner.com.br/ValidateUser';
  String passwordMD5;
  if (typeLogin == 0) {
    passwordMD5 = md5.convert(utf8.encode(password)).toString();
  } else {
    passwordMD5 = password;
  }
  String userType = '2';

  Map<String, dynamic> validateUser = {
    'email': email,
    'password': passwordMD5,
    'userType': userType
  };

  print(jsonEncode(validateUser));
  Map<String, dynamic> responseData;

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(validateUser),
    );

    if (response.statusCode == 200) {
      // O usuário foi criado com sucesso
      //final responseData = response.body;
      //return responseData;

      responseData = jsonDecode(response.body);

      if (responseData['validateUser'] == 2) {
        if (typeLogin == 0) {
          await UserPreferences.saveCredentials(
              validateUser['email'], validateUser['password']);
        }

        await UserPreferences.saveVeterinary(
          responseData['userId'].toString(),
          responseData['name'],
          responseData['crmv'].toString(),
        );

        await raceListApi();
        await specieListApi();
        await coatListApi();
        await diseaseListApi();
        await medicineListApi();
        await symptomListApi();
        await healthProgramListApi();

        /*
        print('==================================');
        print(RaceData().raceList[0].id);
        print(RaceData().raceList[0].name);
        print('==================================');
        */

        /*
        TutorData().setId(responseData['tutorId']);
        TutorData().setName(responseData['name']);
        TutorData().setEmail(responseData['email']);
        SpecieData().specieList = await specieListApi();
        RaceData().raceList = await raceListApi();
        PetData().petList = await petListApi(TutorData().getId().toString());
        //PetVaccineData().petVaccineList = await petVaccineListApi('12');
        ScreeningReasonData().screeningReasonList = await screeningReasonApi();
        ScreeningQuestionData().screeningQuestionList =
            await screeningQuestionApi();
        QuestionAnswerData().questionAnswerList = await questionAnswerApi();

        HealthEventTypeData().healthEventTypeList = await healthEventTypeApi();
        HealthEventFileTypeData().healthEventFileTypeList =
            await healthEventFileTypeApi();
            */
      }
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST validateUserApi: ${response.statusCode}');
      responseData = {
        'validateUser': 4,
      };
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('xErro na solicitação POST validateUserApi: $e');
    responseData = {
      'validateUser': 4,
    };
  }
  return responseData;
}

Future<Map<String, dynamic>> createUserApi(
    String name,
    String surname,
    String email,
    String cellPhone,
    String birthday,
    String gender,
    String state,
    String city,
    String password) async {
  const url = 'https://adm.petner.com.br/CreateUser';
  String passwordMD5 = md5.convert(utf8.encode(password)).toString();

  /*
  String userType = 'cliente';
  if (kIsWeb) {
    userType = 'funcionario';
  }
  */

  Map<String, dynamic> newUser = {
    'name': '$name $surname',
    'email': email,
    'password': passwordMD5,
    'cellphone': cellPhone,
    'birthday': birthday,
    'gender': gender,
    'state': state,
    'city': city,
  };

  Map<String, dynamic> responseData;

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(newUser),
    );

    if (response.statusCode == 200) {
      // O usuário foi criado com sucesso
      //final responseData = response.body;
      //return responseData;
      responseData = jsonDecode(response.body);
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST: ${response.statusCode}');
      responseData = {
        'validateUser': 4,
      };
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('xErro na solicitação POST: $e');
    responseData = {
      'validateUser': 4,
    };
  }

  return responseData;
}

Future<void> specieListApi() async {
  const url = 'https://adm.petner.com.br/SpecieList';
  List<SpecieModel> specieList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      UserPreferences.saveSpecie(response.body);

      /*
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        SpecieModel specie = SpecieModel.fromJson(item);
        specieList.add(specie);
      }
      */
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET specieList: $e');
  }
}

Future<void> raceListApi([String? specie]) async {
  const url = 'https://adm.petner.com.br/RaceList';
  List<RaceModel> raceList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      UserPreferences.saveRace(response.body);

      /*
        print('-------------------------------------------');
        print('JSON Raça: ${await UserPreferences.getRace()}');
        print('-------------------------------------------');
        */
      final jsonData = await UserPreferences.getRace();

      //raceList = (jsonDecode(jsonData!) as List<dynamic>).map((e) => RaceModel.fromJson(e)).toList();

      RaceData().raceList = (jsonDecode(jsonData!) as List<dynamic>)
          .map((e) => RaceModel.fromJson(e))
          .toList();
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST raceList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET raceList: $e');
  }
}

Future<void> coatListApi([String? specie]) async {
  const url = 'https://adm.petner.com.br/CoatList';
  List<CoatModel> coatList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      UserPreferences.saveCoat(response.body);
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST coatList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET coatList: $e');
  }
}

Future<Map<String, dynamic>> registerPetApi(
  String option,
  int petId,
  int tutorId,
  String name,
  String nickname,
  String specie,
  String race,
  String gender,
  String birthday,
  String age,
  String food,
  String environment,
  String weight,
  String imageFileName,
  String base64Image,
) async {
  const url = 'https://adm.petner.com.br/RegisterPet';
  String directoryPath = (await getApplicationDocumentsDirectory()).path;

  if (base64Image.isEmpty) {
    ByteData byteData = await rootBundle.load('lib/shared/images/logo.jpg');
    List<int> imageData = byteData.buffer.asUint8List();
    base64Image = base64Encode(imageData);
    imageFileName = 'padrao.jpg';
  }

  Map<String, dynamic> petner = {
    'option': option,
    'petId': petId,
    'tutorId': tutorId,
    'name': name,
    'nickname': nickname,
    'specie': specie,
    'race': race,
    'gender': gender,
    'birthday': birthday,
    'food': food,
    'environment': environment,
    'weight': weight,
    'imageFileName': imageFileName,
    'base64Image': base64Image,
  };

  Map<String, dynamic> responseData;

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petner),
    );

    if (response.statusCode == 200) {
      // O usuário foi criado com sucesso
      //final responseData = response.body;
      //return responseData;
      responseData = jsonDecode(response.body);

      if (option == 'C') {
        //Criar lista de Pet
        PetModel petner = PetModel(
          tutorId: tutorId,
          id: responseData['petId'],
          name: name,
          nickname: nickname,
          specie: specie,
          race: race,
          gender: gender,
          birthday: birthday,
          age: age,
          food: food,
          environment: environment,
          weight: weight,
          photoName: '$directoryPath/${responseData['petId']}.jpg',
          imageUrl: '',
        );
        PetData().petList.add(petner);

        saveBase64Image(base64Image, petner.photoName);
      }

      if (option == 'U') {
        //Criar lista de Pet

        PetData().petList = await petListApi(TutorData().getId().toString());

        PetModel petner = PetData().getPetById(petId.toString());

        saveBase64Image(base64Image, petner.photoName);
      }
    } else {
      // A resposta não foi bem-sucedida
      responseData = {
        'validatePet': 4,
      };
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST: $e');
    responseData = {
      'validatePet': 4,
    };
  }

  return responseData;
}

Future<List<PetModel>> petListApi([String? tutorId]) async {
  const url = 'https://adm.petner.com.br/PetList';
  List<PetModel> petList = [];

  if (tutorId == null) {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': headerBasic
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData) {
          PetModel pet = PetModel.fromJson(item);
          petList.add(pet);
        }
        PetData().petList = jsonData;
      } else {
        // A resposta não foi bem-sucedida
        print('_Erro na solicitação POST: ${response.statusCode}');
      }
    } catch (e) {
      // Ocorreu um erro durante a solicitação
      print('Erro na solicitação GET petList: $e');
    }
  } else {
    Map<String, dynamic> petCode = {'tutorId': tutorId};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': headerBasic
        },
        body: jsonEncode(petCode),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData) {
          String filePath = 'lib/shared/images/logo.jpg';
          String directoryPath =
              (await getApplicationDocumentsDirectory()).path;
          filePath = '$directoryPath/${item['photoName']}';

          /*if (item['photoName'].toString().isNotEmpty) {
            File(filePath).exists().then((value) => value ? print('$filePath Arquivo Existe') : saveBase64Image(item['photo'], filePath));
          }*/

          PetModel pet = PetModel.fromJson(item);
          pet.setPhotoName = filePath;
          petList.add(pet);
        }
        PetData().petList = petList;
      } else {
        // A resposta não foi bem-sucedida
        print('_Erro na solicitação POST: ${response.statusCode}');
      }
    } catch (e) {
      // Ocorreu um erro durante a solicitação
      print('Erro na solicitação POST petList: $e');
    }
  }

  return petList;
}

Future<List<PetVaccineCardModel>> petVaccineCardListApi([String? petId]) async {
  const url = 'https://adm.petner.com.br/VaccineCardList';
  List<PetVaccineCardModel> petVaccineList = [];

  Map<String, dynamic> petCode = {'petId': petId};
  print(petCode);
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        PetVaccineCardModel petVaccine = PetVaccineCardModel.fromJson(item);
        petVaccineList.add(petVaccine);
      }
      PetVaccineData().petVaccineList = petVaccineList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST vaccineCardList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST vaccineCardList: $e');
  }

  return petVaccineList;
}

Future<List<VaccineBrandModel>> vaccineBrandListApi(
    [String? vaccineId, String? specie]) async {
  const url = 'https://adm.petner.com.br/VaccineBranList';
  List<VaccineBrandModel> vaccineBrandList = [];

  Map<String, dynamic> jsonSend = {'vaccineId': vaccineId, 'specir': specie};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        VaccineBrandModel vaccineBrand = VaccineBrandModel.fromJson(item);
        vaccineBrandList.add(vaccineBrand);
      }
      VaccineBrandData().vaccineBrandList = vaccineBrandList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST vaccineBrandList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST vaccineBrandList: $e');
  }

  return vaccineBrandList;
}

Future<List<VaccineModel>> vaccineListApi(
    [String? petId, String? specie]) async {
  const url = 'https://adm.petner.com.br/VaccineList';
  List<VaccineModel> vaccineList = [];

  Map<String, dynamic> jsonSend = {'petId': petId, 'specie': specie};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        VaccineModel vaccine = VaccineModel.fromJson(item);
        vaccineList.add(vaccine);
      }
      VaccineData().vaccineList = vaccineList;
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST vaccineList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST vaccineList: $e');
  }

  return vaccineList;
}

Future<Map<String, dynamic>> registerVaccineApi(
    [String? option, String? petId, String? vaccineId]) async {
  const url = 'https://adm.petner.com.br/RegisterVaccine';
  Map<String, dynamic> responseData;

  Map<String, dynamic> jsonSend = {
    'option': option,
    'petId': petId,
    'vaccineId': vaccineId
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
      PetVaccineData().petVaccineList = await petVaccineCardListApi(petId);
    } else {
      responseData = {'validateRegisterVaccine': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerVaccine: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'validateRegisterVaccine': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerVaccine: $e');
  }

  return responseData;
}

Future<List<VaccineDoseModel>> vaccineDoseListApi(
    [String? petId, String? vaccineId]) async {
  const url = 'https://adm.petner.com.br/VaccineDoseList';
  List<VaccineDoseModel> vaccineDoseList = [];

  Map<String, dynamic> jsonSend = {'petId': petId, 'vaccineId': vaccineId};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        VaccineDoseModel vaccineDose = VaccineDoseModel.fromJson(item);
        vaccineDoseList.add(vaccineDose);
      }
      VaccineDoseData().vaccineDoseList = vaccineDoseList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST vaccineDoseList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST vaccineDoseList: $e');
  }

  return vaccineDoseList;
}

Future<Map<String, dynamic>> registerVaccineDoseApi([
  String? option,
  String? vaccineCardId,
  String? applicationDate,
  bool? applied,
  String? petId,
  String? vaccinePetId,
  String? vaccineDoseId,
  String? brand,
  String? lot,
  String? veterinary,
  String? observation,
  String? imageFile,
  String? base64Image,
]) async {
  String directoryPath = '';
  const url = 'https://adm.petner.com.br/RegisterVaccineDose';
  Map<String, dynamic>? responseData;
  Map<String, dynamic>? jsonSend;

  if (option == 'D') {
    jsonSend = {'option': option, 'vaccineCardId': vaccineCardId};
  }

  if (option == 'C' || option == 'U') {
    jsonSend = {
      'option': option,
      'petId': petId,
      'vaccineCardId': vaccineCardId,
      'applicationDate': applicationDate,
      'applied': applied,
      'vaccinePetId': vaccinePetId,
      'vaccineDoseId': vaccineDoseId,
      'brand': brand,
      'lot': lot,
      'veterinary': veterinary,
      'observation': observation,
      'imageFile': imageFile,
      'base64Image': base64Image,
      'imageFileApp': '$directoryPath/$imageFile',
    };
  }

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      saveBase64Image(base64Image!, '$directoryPath/$imageFile');

      /*
      if (option == 'C') {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData) {
          PetVaccinationCardModel vaccineDose =
              PetVaccinationCardModel.fromJson(item);

          PetVaccineData().addVaccinationCardByVaccineId(
            PetVaccineData()
                .getVaccineCardById(vaccinePetId.toString())
                .petVaccineId
                .toString(),
            vaccineDose,
          );
        }
      }
      */

      responseData = {'validateRegisterVaccineDose': 1};

      //PetVaccineData().petVaccineList = await petVaccineCardListApi(petId);
    } else {
      responseData = {'validateRegisterVaccineDose': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerVaccineDose: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'validateRegisterVaccineDose': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerVaccineDose: $e');
  }

  return responseData;
}

Future<List<PetTreatmentModel>> petTreatmentListApi([String? petId]) async {
  const url = 'https://adm.petner.com.br/TreatmentList';
  List<PetTreatmentModel> petTreatmentList = [];

  Map<String, dynamic> petCode = {'petId': petId};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        PetTreatmentModel petTreatment = PetTreatmentModel.fromJson(item);
        petTreatmentList.add(petTreatment);
      }
      PetTreatmentData().petTreatmentList = petTreatmentList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petTreatmentListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petTreatmentListApi: $e');
  }

  return petTreatmentList;
}

Future<Map<String, dynamic>> registerTreatmentApi([
  String? option,
  String? petId,
  String? treatmentId,
  String? description,
  String? medicine,
  String? amount,
  bool? continuous,
  bool? finished,
  String? howManyDays,
  String? quantityBox,
  String? startDate,
  String? startTime,
  String? endDate,
  String? endTime,
  String? every,
  String? unit,
  String? interval,
  String? reminder,
]) async {
  String directoryPath = (await getApplicationDocumentsDirectory()).path;
  const url = 'https://adm.petner.com.br/RegisterTreatment';
  Map<String, dynamic>? responseData;
  Map<String, dynamic>? jsonSend;

  if (option == 'D') {
    jsonSend = {'option': option, 'treatmentId': treatmentId};
  }

  if (option == 'C' || option == 'U') {
    jsonSend = {
      'option': option,
      'petId': petId,
      'treatmentId': treatmentId,
      'description': description,
      'medicine': medicine,
      'amount': amount,
      'continuous': continuous,
      'finished': finished,
      'howManyDays': howManyDays,
      'quantityBox': quantityBox,
      'startDate': startDate,
      'startTime': startTime,
      'endDate': endDate,
      'endTime': endTime,
      'every': every,
      'unit': unit,
      'interval': interval,
      'reminder': reminder,
    };
  }

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      responseData = {'validateRegisterTreatment': 1};
    } else {
      responseData = {'validateRegisterTreatment': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerTreatment: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'validateRegisterTreatment': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerTreatment: $e');
  }

  return responseData;
}

Future<List<PetScheduleTreatmentModel>> petScheduleTreatmentListApi(
    [String? treatmentId]) async {
  const url = 'https://adm.petner.com.br/ScheduleTreatmentList';
  List<PetScheduleTreatmentModel> petScheduleTreatmentList = [];

  Map<String, dynamic> petCode = {'treatmentId': treatmentId};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        PetScheduleTreatmentModel petScheduleTreatment =
            PetScheduleTreatmentModel.fromJson(item);
        petScheduleTreatmentList.add(petScheduleTreatment);
      }
      PetScheduleTreatmentData().petScheduleTreatmentList =
          petScheduleTreatmentList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST PetScheduleTreatmentList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST PetScheduleTreatmentList: $e');
  }

  return petScheduleTreatmentList;
}

Future<Map<String, dynamic>> petRegisterScheduleTreatmentApi([
  String? option,
  String? scheduleId,
  String? timeTable,
  bool? performed,
]) async {
  const url = 'https://adm.petner.com.br/RegisterScheduleTreatment';

  Map<String, dynamic>? responseData;
  Map<String, dynamic> petCode = {
    'option': option,
    'scheduleId': scheduleId,
    'timeTable': timeTable,
    'performed': performed,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      responseData = {
        'validateRegisterScheduleTreatment': 1,
      };
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST PetScheduleTreatmentList: ${response.statusCode}');
      responseData = {
        'validateRegisterScheduleTreatment': 2,
      };
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST PetScheduleTreatmentList: $e');
    responseData = {
      'validateRegisterScheduleTreatment': 3,
    };
  }

  return responseData;
}

//////////////
Future<List<CityModel>> cityListApi([String? uf]) async {
  String url =
      'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios';

  List<CityModel> cityList = [];

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        CityModel city = CityModel.fromJson(item);
        cityList.add(city);
      }
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET stateApi: $e');
  }

  return cityList;
}

/////////////////////// activity list
Future<List<ActivityTypeModel>> activityTypeListApi([String? petId]) async {
  const url = 'https://adm.petner.com.br/ActivityTypeList';
  List<ActivityTypeModel> activityTypeList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        ActivityTypeModel activity = ActivityTypeModel.fromJson(item);
        activityTypeList.add(activity);
      }
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação GET: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET ActivityTypeListModel: $e');
  }

  return activityTypeList;
}

////////////////  create activity
///
///
/*
{
    "option": "C",
    "petId":1,
    "activityDate": "19/07/2023",
    "endDate": "30/09/2025",
    "activityTypeId": 1,
    "otherType": "",
    "intervalType": 5,
    "timeTable": "15:00",
    "repeatEach": 2,
    "monday": true,
    "tuesday": false,
    "wednesday": false,
    "thursday": true,
    "friday": false,
    "saturday": true,
    "sunday": false,
    "neverEnds": false,
    "sendNotice": false,
    "repeatDayOfMonth": false,
    "repeatDayOfWeek": true
}
*/
Future<Map<String, dynamic>> petRegisterActivityApi([
  String? option,
  String? petId,
  String? activityDate,
  String? endDate,
  String? activityTypeId,
  String? otherType,
  String? intervalType,
  String? timeTable,
  String? repeatEach,
  bool? monday,
  bool? tuesday,
  bool? wednesday,
  bool? thursday,
  bool? friday,
  bool? saturday,
  bool? sunday,
  bool? neverEnds,
  bool? sendNotice,
  bool? repeatDayOfMonth,
  bool? repeatDayOfWeek,
]) async {
  const url = 'https://adm.petner.com.br/RegisterActivity';

  Map<String, dynamic>? responseData;
  Map<String, dynamic> petCode = {
    'option': option,
    'petId': petId,
    'activityDate': activityDate,
    'endDate': endDate,
    'activityTypeId': activityTypeId,
    'otherType': otherType,
    'intervalType': intervalType,
    'timeTable': timeTable,
    'repeatEach': repeatEach,
    'monday': monday,
    'tuesday': tuesday,
    'wednesday': wednesday,
    'thursday': thursday,
    'friday': friday,
    'saturday': saturday,
    'sunday': sunday,
    'neverEnds': neverEnds,
    'sendNotice': sendNotice,
    'repeatDayOfMonth': repeatDayOfMonth,
    'repeatDayOfWeek': repeatDayOfWeek,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      responseData = {
        'validateRegisterActivity': 1,
      };
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST RegisterActivity: ${response.statusCode}');
      responseData = {
        'validateRegisterActivity': 2,
      };
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST RegisterActivity: $e');
    responseData = {
      'validateRegisterActivity': 3,
    };
  }

  return responseData;
}

///////////////////////////////
Future<Map<String, dynamic>> registerMedicalScreeningApi([
  String? petId,
  String? screeningReasonId,
  List<Map<String, dynamic>>? answer,
]) async {
  const url = 'https://adm.petner.com.br/RegisterAppointment';
  Map<String, dynamic>? responseData;

  Map<String, dynamic> petCode = {
    'petId': petId,
    'screeningReasonId': screeningReasonId,
    'answer': answer,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      responseData = {
        'registerAppointmentId': 1,
      };
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST RegisterActivity: ${response.statusCode}');
      responseData = {
        'registerAppointmentId': 2,
      };
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST RegisterActivity: $e');
    responseData = {
      'validateRegisterActivity': 3,
    };
  }

  return responseData;
}

///////////////////////////////
///////////////////////// PetActivityModel
Future<List<PetActivityModel>> petActivityModelApi([String? petId]) async {
  const url = 'https://adm.petner.com.br/ActivityList';
  List<PetActivityModel> petActivityList = [];

  Map<String, dynamic> petCode = {'petId': petId};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        List<ActivityTypeModel> activityTypeList =
            await activityTypeListApi(item['activityId'].toString());

        PetActivityModel petTreatment = PetActivityModel.fromJson(item);
        petActivityList.add(petTreatment);
      }
      PetActivityData().petActivityList = petActivityList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petActivityModelApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petActivityModelApi: $e');
  }

  return petActivityList;
}

///////
////////////////////////// file Type List

Future<List<FileTypeModel>> fileTypeListApi() async {
  const url = 'https://adm.petner.com.br/FileTypeList';

  List<FileTypeModel> fileTypeList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        FileTypeModel fileType = FileTypeModel.fromJson(item);
        fileTypeList.add(fileType);
      }
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação GET: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET fileTypeListApi: $e');
  }

  return fileTypeList;
}

Future<List<PetFileModel>> petFileModelApi([String? petId]) async {
  const url = 'https://adm.petner.com.br/FileList';
  List<PetFileModel> petFileList = [];

  Map<String, dynamic> petCode = {'petId': petId};

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        List<PetFileModel> petFileList =
            await petFileModelApi(item['fileId'].toString());

        PetFileModel petTreatment = PetFileModel.fromJson(item);
        petFileList.add(petTreatment);
      }
      PetFileData().petFileList = petFileList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST PetTreatmentList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petFileModelApi: $e');
  }

  return petFileList;
}

/*

 "activityId" : 7,
    "activityStartDate": "01/09/2023",
    "activityEndDate": "30/09/2023"
*/

Future<List<PetScheduleActivityModel>> petScheduleActivityListApi([
  String? activityId,
  String? activityStartDate,
  String? activityEndDate,
]) async {
  const url = 'https://adm.petner.com.br/ScheduleActivityList';
  List<PetScheduleActivityModel> petScheduleTreatmentList = [];

  Map<String, dynamic> petCode = {
    'activityId': activityId,
    'activityStartDate': activityStartDate,
    'activityEndDate': activityEndDate,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(petCode),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        PetScheduleActivityModel petScheduleTreatment =
            PetScheduleActivityModel.fromJson(item);

        petScheduleTreatmentList.add(petScheduleTreatment);
      }
      PetScheduleActivityData().petScheduleTreatmentList =
          petScheduleTreatmentList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST PetScheduleTreatmentList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST PetScheduleTreatmentList: $e');
  }

  return petScheduleTreatmentList;
}

Future<List<ScreeningReasonModel>> screeningReasonApi() async {
  const url = 'https://adm.petner.com.br/ScreeningReasonList';
  List<ScreeningReasonModel> screeningReasonList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        ScreeningReasonModel screeningReason =
            ScreeningReasonModel.fromJson(item);
        screeningReasonList.add(screeningReason);
      }
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET screeningReason: $e');
  }

  return screeningReasonList;
}

Future<List<ScreeningQuestionModel>> screeningQuestionApi() async {
  const url = 'https://adm.petner.com.br/ScreeningQuestionList';
  List<ScreeningQuestionModel> screeningQuestionList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        ScreeningQuestionModel screeningReason =
            ScreeningQuestionModel.fromJson(item);
        screeningQuestionList.add(screeningReason);
      }
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST ScreeningQuestionModel: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET ScreeningQuestionModel: $e');
  }

  return screeningQuestionList;
}

Future<List<QuestionAnswerModel>> questionAnswerApi() async {
  const url = 'https://adm.petner.com.br/QuestionAnswerList';
  List<QuestionAnswerModel> questionAnswerList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        QuestionAnswerModel questionAnswer = QuestionAnswerModel.fromJson(item);
        questionAnswerList.add(questionAnswer);
      }
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST ScreeningQuestionModel: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET ScreeningQuestionModel: $e');
  }

  return questionAnswerList;
}

/////////////// file and event type

Future<List<HealthEventTypeModel>> healthEventTypeApi() async {
  const url = 'https://adm.petner.com.br/HealthEventTypeList';
  List<HealthEventTypeModel> healthEventTypeModelList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        HealthEventTypeModel healthEventType =
            HealthEventTypeModel.fromJson(item);
        healthEventTypeModelList.add(healthEventType);
      }
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST HealthEventTypeModel: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET HealthEventTypeModel: $e');
  }

  return healthEventTypeModelList;
}

Future<List<HealthEventFileTypeModel>> healthEventFileTypeApi() async {
  const url = 'https://adm.petner.com.br/HealthEventFileTypeList';
  List<HealthEventFileTypeModel> healthEventTypeFileList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        HealthEventFileTypeModel healthEventFileType =
            HealthEventFileTypeModel.fromJson(item);
        healthEventTypeFileList.add(healthEventFileType);
      }
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST HealthEventFileTypeModel: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET HealthEventFileTypeModel: $e');
  }

  return healthEventTypeFileList;
}

Future<List<ServiceQueueModel>> serviceQueueApi() async {
  const url = 'https://adm.petner.com.br/ServiceQueueList';
  List<ServiceQueueModel> serviceQueueList = [];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(response.body);

      for (var item in jsonData) {
        print(item);
        ServiceQueueModel healthEventFileType =
            ServiceQueueModel.fromJson(item);
        serviceQueueList.add(healthEventFileType);
      }
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST ServiceQueueModel: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET ServiceQueueModel: $e');
  }

  return serviceQueueList;
}

Future<String> getRTCTokenApi(int petId, int roomNameId, int crmv) async {
  const url = 'https://adm.petner.com.br/GetRTCToken';
  String token = '0';

  Map<String, dynamic> getRoom = {
    'petId': petId,
    'roomNameId': roomNameId,
    'crmv': crmv
  };

  print(getRoom);

  print(jsonEncode(getRoom));

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(getRoom),
    );
    if (response.statusCode == 200) {
      token = jsonDecode(response.body);
    } else {
      token = '-1';
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST getRTCTokenApi: ${response.statusCode}');
    }
  } catch (e) {
    token = '-2';
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET getRTCTokenApi: $e');
  }

  return token;
}

Future<Map<String, dynamic>> registerDiseaseApi([
  String? option,
  String? petId,
  String? diseaseId,
  String? otherDisease,
  bool? chronic,
]) async {
  const url = 'https://adm.petner.com.br/RegisterDisease';
  Map<String, dynamic> responseData;

  Map<String, dynamic> jsonSend = {
    'option': option,
    'petId': petId,
    'diseaseId': diseaseId,
    'otherDisease': otherDisease,
    'chronic': chronic,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
    } else {
      responseData = {'registerDisease': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerDisease: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'registerDiseaseApi': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerDisease: $e');
  }

  return responseData;
}

Future<void> diseaseListApi() async {
  const url = 'https://adm.petner.com.br/DiseaseList';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );
    if (response.statusCode == 200) {
      UserPreferences.saveDisease(response.body);
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST diseaseList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET diseaseList: $e');
  }
}

Future<List<PetDiseaseModel>> petDiseaseListApi([
  String? petId,
  bool? chronic,
]) async {
  const url = 'https://adm.petner.com.br/PetDiseaseList';
  List<PetDiseaseModel> petDiseaseList = [];

  Map<String, dynamic> jsonSend = {
    'petId': petId,
    'chronic': chronic,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      for (var item in jsonData) {
        PetDiseaseModel petDiseaseModel = PetDiseaseModel.fromJson(item);
        petDiseaseList.add(petDiseaseModel);
      }
      PetDiseaseData().petDiseaseList = petDiseaseList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petDiseaseListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petDiseaseListApi: $e');
  }

  return petDiseaseList;
}

Future<Map<String, dynamic>> registerMedicineApi([
  String? option,
  String? petId,
  String? medicineId,
  String? otherMedicine,
  bool? continuousUser,
]) async {
  const url = 'https://adm.petner.com.br/RegisterMedicine';
  Map<String, dynamic> responseData;

  Map<String, dynamic> jsonSend = {
    'option': option,
    'petId': petId,
    'medicineId': medicineId,
    'otherMedicine': otherMedicine,
    'continuousUser': continuousUser,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
    } else {
      responseData = {'registerDisease': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerMedicine: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'registerDiseaseApi': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerMedicine: $e');
  }

  return responseData;
}

Future<Map<String, int>> registerSymptomApi([
  String? option,
  String? petId,
  String? queueId,
  String? symptomId,
  String? otherSymptom,
]) async {
  const url = 'https://adm.petner.com.br/RegisterSymptom';
  Map<String, int> responseData;

  Map<String, dynamic> jsonSend = {
    'option': option,
    'petId': petId,
    'queueId': queueId,
    'symptomId': symptomId,
    'otherSymptom': otherSymptom,
  };

  print(jsonEncode(jsonSend));

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
    } else {
      responseData = {'registerSymptom': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerSymptom: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'registerSymtptom': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerSymptom: $e');
  }

  return responseData;
}

Future<void> medicineListApi() async {
  const url = 'https://adm.petner.com.br/MedicineList';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );
    if (response.statusCode == 200) {
      UserPreferences.saveMedicine(response.body);
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST diseaseList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET diseaseList: $e');
  }
}

Future<List<PetMedicineModel>> petMedicineListApi([
  String? petId,
]) async {
  const url = 'https://adm.petner.com.br/PetMedicineList';
  List<PetMedicineModel> petMedicineList = [];

  Map<String, dynamic> jsonSend = {
    'petId': petId,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      for (var item in jsonData) {
        PetMedicineModel petMedicineModel = PetMedicineModel.fromJson(item);
        petMedicineList.add(petMedicineModel);
      }
      PetMedicineData().petMedicineList = petMedicineList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petMedicineListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petMedicineListApi: $e');
  }

  return petMedicineList;
}

Future<Map<String, dynamic>> registerAllergyApi([
  String? option,
  String? petId,
  String? allergy,
]) async {
  const url = 'https://adm.petner.com.br/RegisterAllergy';
  Map<String, dynamic> responseData;

  Map<String, dynamic> jsonSend = {
    'option': option,
    'petId': petId,
    'allergy': allergy,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);
    } else {
      responseData = {'registerDisease': 2};
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST registerDisease: ${response.statusCode}');
    }
  } catch (e) {
    responseData = {'registerDiseaseApi': 3};
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST registerDisease: $e');
  }

  return responseData;
}

Future<List<PetAllergyModel>> petAllergyListApi([
  String? petId,
]) async {
  const url = 'https://adm.petner.com.br/PetAllergyList';
  List<PetAllergyModel> petAllergyList = [];

  Map<String, dynamic> jsonSend = {
    'petId': petId,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      for (var item in jsonData) {
        PetAllergyModel petAllergyModel = PetAllergyModel.fromJson(item);
        petAllergyList.add(petAllergyModel);
      }
      PetAllergyData().petAllergyList = petAllergyList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petAllergyListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petAllergyListApi: $e');
  }

  return petAllergyList;
}

Future<List<PetSymptomModel>> petSymptomListApi([
  String? petId,
  String? queueId,
]) async {
  const url = 'https://adm.petner.com.br/PetSimptomList';
  List<PetSymptomModel> petSymptomList = [];

  Map<String, dynamic> jsonSend = {
    'petId': petId,
    'queueId': queueId,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      for (var item in jsonData) {
        PetSymptomModel petSymptomModel = PetSymptomModel.fromJson(item);
        petSymptomList.add(petSymptomModel);
      }
      PetSymptomData().petSymptomList = petSymptomList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petSymptomListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petSymptomListApi: $e');
  }

  return petSymptomList;
}

Future<void> symptomListApi() async {
  const url = 'https://adm.petner.com.br/SymptomList';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );
    if (response.statusCode == 200) {
      UserPreferences.saveSymptom(response.body);
    } else {
      // A resposta não foi bem-sucedida
      print('_Erro na solicitação POST symptomList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET symptomList: $e');
  }
}

Future<void> healthProgramListApi() async {
  const url = 'https://adm.petner.com.br/HealthProgramList';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
    );
    if (response.statusCode == 200) {
      UserPreferences.saveHealthProgram(response.body);
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST healthProgramList: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação GET healthProgramList: $e');
  }
}

Future<List<PetServiceHistoryModel>> petServiceHistoryListApi(
    String petId) async {
  const url = 'https://adm.petner.com.br/PetServiceHistoryList';
  List<PetServiceHistoryModel> petServiceHistoryList = [];
  Map<String, dynamic> jsonSend = {
    'petId': petId,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      for (var item in jsonData) {
        PetServiceHistoryModel petServiceHistoryModel =
            PetServiceHistoryModel.fromJson(item);
        petServiceHistoryList.add(petServiceHistoryModel);
      }
      PetServiceHistoryData().petServiceHistoryList = petServiceHistoryList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petServiceHistoryListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petServiceHistoryListApi: $e');
  }

  return petServiceHistoryList;
}

Future<List<PetHealthProgramModel>> petHealthProgramListApi(
    String petId) async {
  const url = 'https://adm.petner.com.br/PetHealthProgramList';
  List<PetHealthProgramModel> petHealthProgramList = [];
  Map<String, dynamic> jsonSend = {
    'petId': petId,
  };

  print(jsonSend);

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': headerBasic
      },
      body: jsonEncode(jsonSend),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      for (var item in jsonData) {
        PetHealthProgramModel petHealthProgramModel =
            PetHealthProgramModel.fromJson(item);
        petHealthProgramList.add(petHealthProgramModel);
      }
      PetHealthProgramData().petHealthProgramList = petHealthProgramList;
    } else {
      // A resposta não foi bem-sucedida
      print(
          '_Erro na solicitação POST petHealthProgramListApi: ${response.statusCode}');
    }
  } catch (e) {
    // Ocorreu um erro durante a solicitação
    print('Erro na solicitação POST petHealthProgramListApi: $e');
  }

  return petHealthProgramList;
}
