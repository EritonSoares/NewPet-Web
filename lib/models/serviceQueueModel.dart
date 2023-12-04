// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ServiceQueueModel {
  late final int queueId;
  late final int queueOrder;
  late final int queueTypeId;
  late final String queueTypeName;
  late final String queueDate;
  //late final DateTime queueTime;
  late final int? tutorId;
  late final String? tutorName;
  late final int petId;
  late final String? petName;
  late final String? petNickName;
  late final String? plan;
  late final String? petPhoto;
  late final String? birthDay;
  late final String? age;
  late final int? ageType;
  late final int? raceId;
  late final String? raceName;
  late final int? specieId;
  late final String? specieName;
  late final String? genderId;
  late final String? genderName;
  late final int? sizeId;
  late final String? sizeName;
  late final int? coatId;
  late final String? coatName;
  late final int? temperamentId;
  late final String? temperamentName;
  late final bool? castrated;
  late final String? state;
  late final String? city;
  late final String? neidhborhood;
  late final int? environmentId;
  late final String? environmentName;
  late final int? foodId;
  late final String? foodName;
  late final int? bodyScoreId;
  late final String? bodyScoreName;
  late final int? productId;
  late final String? productName;
  late final int? screeningId;
  late final String? screeningName;
  late final List<ScreeningModel>? screeningList;
  late final bool? hasTeleOrientation;
  late final bool? haveTeleConsultation;
  late final bool? thereEmergency;
  late final bool? emergencyReleased;
  late final String? emergencyMessage;
  late final bool? thereHome;
  late final bool? homeReleased;
  late final String? homeMessage;
  late final List<PetFileListModel> fileList;
  late final List<HospitalListModel> hospitalList;

  ServiceQueueModel({
    required this.queueId,
    required this.queueOrder,
    required this.queueTypeId,
    required this.queueTypeName,
    required this.queueDate,
    //required this.queueTime,
    required this.tutorId,
    required this.tutorName,
    required this.petId,
    required this.petName,
    required this.petNickName,
    required this.plan,
    required this.petPhoto,
    required this.birthDay,
    required this.age,
    required this.ageType,
    required this.raceId,
    required this.raceName,
    required this.specieId,
    required this.specieName,
    required this.genderId,
    required this.genderName,
    required this.sizeId,
    required this.sizeName,
    required this.coatId,
    required this.coatName,
    required this.temperamentId,
    required this.temperamentName,
    required this.castrated,
    required this.state,
    required this.city,
    required this.neidhborhood,
    required this.environmentId,
    required this.environmentName,
    required this.foodId,
    required this.foodName,
    required this.bodyScoreId,
    required this.bodyScoreName,
    required this.productId,
    required this.productName,
    required this.screeningId,
    required this.screeningName,
    required this.screeningList,
    required this.hasTeleOrientation,
    required this.haveTeleConsultation,
    required this.thereEmergency,
    required this.emergencyReleased,
    required this.emergencyMessage,
    required this.thereHome,
    required this.homeReleased,
    required this.homeMessage,
    required this.fileList,
    required this.hospitalList,
  });

  factory ServiceQueueModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> screeningListJson = json['screeningList'];
    List<ScreeningModel> screeningList = screeningListJson
        .map((screeningJson) => ScreeningModel.fromJson(screeningJson))
        .toList();

    List<dynamic> fileListJson = json['fileList'];
    List<PetFileListModel> fileList = fileListJson
        .map((fileJson) => PetFileListModel.fromJson(fileJson))
        .toList();

    List<dynamic> hospitalListJson = json['hospitalList'];
    List<HospitalListModel> hospitalList = hospitalListJson
        .map((hospitalJson) => HospitalListModel.fromJson(hospitalJson))
        .toList();

    return ServiceQueueModel(
      queueId: json['queueId'],
      queueOrder: json['queueOrder'],
      queueTypeId: json['queueTypeId'],
      queueTypeName: json['queueTypeName'],
      queueDate: json['queueDate'],
      //queueTime: DateTime.parse(json['queueTime']),
      tutorId: json['tutorId'],
      tutorName: json['tutorName'],
      petId: json['petId'],
      petName: json['petName'],
      petNickName: json['petNickName'],
      plan: json['plan'],
      petPhoto: json['petPhoto'],
      birthDay: json['birthDay'],
      age: json['age'],
      ageType: json['ageType'],
      raceId: json['raceId'],
      raceName: json['raceName'],
      specieId: json['specieId'],
      specieName: json['specieName'],
      genderId: json['genderId'],
      genderName: json['genderName'],
      sizeId: json['sizeId'],
      sizeName: json['sizeName'],
      coatId: json['coatId'],
      coatName: json['coatName'],
      temperamentId: json['temperamentId'],
      temperamentName: json['temperamentName'],
      castrated: json['castrated'],
      state: json['state'],
      city: json['city'],
      neidhborhood: json['neidhborhood'],
      environmentId: json['environmentId'],
      environmentName: json['environmentName'],
      foodId: json['foodId'],
      foodName: json['foodName'],
      bodyScoreId: json['bodyScoreId'],
      bodyScoreName: json['bodyScoreName'],
      productId: json['productId'],
      productName: json['productName'],
      screeningId: json['screeningId'],
      screeningName: json['screeningName'],
      screeningList: screeningList,
      hasTeleOrientation: json['hasTeleOrientation'],
      haveTeleConsultation: json['haveTeleConsultation'],
      thereEmergency: json['thereEmergency'],
      emergencyReleased: json['emergencyReleased'],
      emergencyMessage: json['emergencyMessage'],
      thereHome: json['thereEmergency'],
      homeReleased: json['emergencyReleased'],
      homeMessage: json['homeMessage'],
      fileList: fileList,
      hospitalList: hospitalList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> screeningListJson =
        screeningList!.map((screening) => screening.toJson()).toList();

    List<Map<String, dynamic>> fileListJson =
        fileList.map((file) => file.toJson()).toList();

    List<Map<String, dynamic>> hospitalListJson =
        hospitalList.map((hospital) => hospital.toJson()).toList();

    return {
      'queueId': queueId,
      'queueOrder': queueOrder,
      'queueTypeId': queueTypeId,
      'queueTypeName': queueTypeName,
      'queueDate': queueDate,
      //'queueTime': queueTime,
      'tutorId': tutorId,
      'tutorName': tutorName,
      'petId': petId,
      'petName': petName,
      'petNickName': petNickName,
      'plan': plan,
      'petPhoto': petPhoto,
      'birthDay': birthDay,
      'age': age,
      'ageType': ageType,
      'raceId': raceId,
      'raceName': raceName,
      'specieId': specieId,
      'specieName': specieName,
      'genderId': genderId,
      'genderName': genderName,
      'sizeId': sizeId,
      'sizeName': sizeName,
      'coatId': coatId,
      'coatName': coatName,
      'temperamentId': temperamentId,
      'temperamentName': temperamentName,
      'castrated': castrated,
      'state': state,
      'city': city,
      'neidhborhood': neidhborhood,
      'environmentId': environmentId,
      'environmentName': environmentName,
      'foodId': foodId,
      'foodName': foodName,
      'bodyScoreId': bodyScoreId,
      'bodyScoreName': bodyScoreName,
      'productId': productId,
      'productName': productName,
      'screeningId': screeningId,
      'screeningName': screeningName,
      'screeningList': screeningListJson,
      'hasTeleOrientation': hasTeleOrientation,
      'haveTeleConsultation': haveTeleConsultation,
      'thereEmergency': thereEmergency,
      'emergencyReleased': emergencyReleased,
      'emergencyMessage': emergencyMessage,
      'thereHome': thereHome,
      'homeReleased': homeReleased,
      'homeMessage': homeMessage,
      'fileList': fileListJson,
      'hospitalList': hospitalListJson,
    };
  }
}

class ScreeningModel {
  late final String? question;
  late final String? answer;
  ScreeningModel({
    required this.question,
    required this.answer,
  });

  factory ScreeningModel.fromJson(Map<String, dynamic> json) {
    return ScreeningModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}

class PetFileListModel {
  late final String fileName;
  late final String url;
  PetFileListModel({
    required this.fileName,
    required this.url,
  });

  factory PetFileListModel.fromJson(Map<String, dynamic> json) {
    return PetFileListModel(
      fileName: json['fileName'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'url': url,
    };
  }
}

class HospitalListModel {
  late final int hospitalId;
  late final String hospitalName;
  late final String hospitalAddress;
  HospitalListModel({
    required this.hospitalId,
    required this.hospitalName,
    required this.hospitalAddress,
  });

  factory HospitalListModel.fromJson(Map<String, dynamic> json) {
    return HospitalListModel(
      hospitalId: json['hospitalId'],
      hospitalName: json['hospitalName'],
      hospitalAddress: json['hospitalAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hospitalId': hospitalId,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress,
    };
  }
}
