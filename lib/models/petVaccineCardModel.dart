// ignore_for_file: file_names

class PetVaccineCardModel {
  late final int petVaccineId;
  late final int vaccineId;
  late final String vaccineName;
  late final bool mandatory;
  late final String lastDose;
  late final String nextDose;
  late final int totalDose;
  late final List<PetVaccinationCardModel> vaccineList;

  PetVaccineCardModel({
    required this.petVaccineId,
    required this.vaccineName,
    required this.vaccineId,
    required this.mandatory,
    required this.lastDose,
    required this.nextDose,
    required this.totalDose,
    required this.vaccineList,
  });

  factory PetVaccineCardModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> vaccineListJson = json['vaccineList'];
    List<PetVaccinationCardModel> vaccineList = vaccineListJson
        .map((vaccineJson) => PetVaccinationCardModel.fromJson(vaccineJson))
        .toList();

    return PetVaccineCardModel(
      petVaccineId: json['petVaccineId'],
      vaccineId: json['vaccineId'],
      vaccineName: json['vaccineName'],
      mandatory: json['mandatory'],
      lastDose: json['lastDose'],
      nextDose: json['nextDose'],
      totalDose: json['totalDose'],
      vaccineList: vaccineList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> vaccineListJson =
        vaccineList.map((vaccine) => vaccine.toJson()).toList();

    return {
      'petVaccineId': petVaccineId,
      'vaccineId': vaccineId,
      'vaccineName': vaccineName,
      'mandatory': mandatory,
      'lastDose': lastDose,
      'nextDose': nextDose,
      'totalDose': totalDose,
      'vaccineList': vaccineListJson
    };
  }
}

class PetVaccinationCardModel {
  late final int vaccinationCardId;
  late final String vaccineType;
  late final bool applied;
  late final String applicationDate;
  late final String expiresIn;
  late final String brandId;
  late final String otherBrand;
  late final String appliedVacinaId;
  late final String stampImage;
  late final String stampImageBase64;
  late final String vaccineTypeId;
  late final String crmv;
  late final String veterinary;
  late final String vaccineLot;
  late final String observation;
  late final String imageFile;
  late final String base64Image;
  late final String imageFileApp;
  PetVaccinationCardModel({
    required this.vaccinationCardId,
    required this.vaccineType,
    required this.applied,
    required this.applicationDate,
    required this.expiresIn,
    required this.brandId,
    required this.otherBrand,
    required this.appliedVacinaId,
    required this.stampImage,
    required this.stampImageBase64,
    required this.vaccineTypeId,
    required this.crmv,
    required this.veterinary,
    required this.vaccineLot,
    required this.observation,
    required this.imageFile,
    required this.base64Image,
    required this.imageFileApp,
  });

  void setApplied(bool xapplied) {
    applied = xapplied;
  }

  factory PetVaccinationCardModel.fromJson(Map<String, dynamic> json) {
    return PetVaccinationCardModel(
      vaccinationCardId: json['vaccinationCardId'],
      vaccineType: json['vaccineType'],
      applied: json['applied'],
      applicationDate: json['applicationDate'],
      expiresIn: json['expiresIn'],
      brandId: json['brandId'],
      otherBrand: json['otherBrand'],
      appliedVacinaId: json['appliedVacinaId'],
      stampImage: json['stampImage'],
      stampImageBase64: json['stampImageBase64'],
      vaccineTypeId: json['vaccineTypeId'],
      crmv: json['crmv'],
      veterinary: json['veterinary'],
      vaccineLot: json['vaccineLot'],
      observation: json['observation'],
      imageFile: json['imageFile'],
      base64Image: json['base64Image'],
      imageFileApp: json['imageFileApp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccinationCardId': vaccinationCardId,
      'vaccineType': vaccineType,
      'applied': applied,
      'applicationDate': applicationDate,
      'expiresIn': expiresIn,
      'brandId': brandId,
      'otherBrand': otherBrand,
      'appliedVacinaId': appliedVacinaId,
      'stampImage': stampImage,
      'stampImageBase64': stampImageBase64,
      'vaccineTypeId': vaccineTypeId,
      'crmv': crmv,
      'veterinary': veterinary,
      'vaccineLot': vaccineLot,
      'observation': observation,
      'imageFile': imageFile,
      'base64Image': base64Image,
      'imageFileApp': imageFileApp,
    };
  }
}
