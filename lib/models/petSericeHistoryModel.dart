// ignore_for_file: file_names

class PetServiceHistoryModel {
  late final int serviceFormId;
  late final String serviceFormDate;
  late final bool servicedByPetner;
  late final String veterinary;
  late final String crmv;
  late final String screeningName;
  late final String diagnostic;
  late final bool attachment;
  late final String typeServiceForm;
  late final String riskRating;
  late final List<PetExameListModel> exameList;
  late final List<PetMedicineListModel> medicineList;
  late final List<PetFileListModel> fileList;

  PetServiceHistoryModel({
    required this.serviceFormId,
    required this.serviceFormDate,
    required this.servicedByPetner,
    required this.veterinary,
    required this.crmv,
    required this.screeningName,
    required this.diagnostic,
    required this.attachment,
    required this.typeServiceForm,
    required this.riskRating,
    required this.exameList,
    required this.medicineList,
    required this.fileList,
  });

  factory PetServiceHistoryModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> exameListJson = json['exameList'];
    List<PetExameListModel> exameList = exameListJson
        .map((exameJson) => PetExameListModel.fromJson(exameJson))
        .toList();

    List<dynamic> medicineListJson = json['medicineList'];
    List<PetMedicineListModel> medicineList = medicineListJson
        .map((medicineJson) => PetMedicineListModel.fromJson(medicineJson))
        .toList();

    List<dynamic> fileListJson = json['fileList'];
    List<PetFileListModel> fileList = fileListJson
        .map((fileJson) => PetFileListModel.fromJson(fileJson))
        .toList();

    return PetServiceHistoryModel(
      serviceFormId: json['serviceFormId'],
      serviceFormDate: json['serviceFormDate'],
      servicedByPetner: json['servicedByPetner'],
      veterinary: json['veterinary'],
      crmv: json['crmv'],
      screeningName: json['screeningName'],
      diagnostic: json['diagnostic'],
      attachment: json['attachment'],
      typeServiceForm: json['typeServiceForm'],
      riskRating: json['riskRating'],
      exameList: exameList,
      medicineList: medicineList,
      fileList: fileList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> exameListJson =
        exameList.map((exame) => exame.toJson()).toList();

    List<Map<String, dynamic>> medicineListJson =
        medicineList.map((medicine) => medicine.toJson()).toList();

    List<Map<String, dynamic>> fileListJson =
        fileList.map((file) => file.toJson()).toList();

    return {
      'serviceFormId': serviceFormId,
      'serviceFormDate': serviceFormDate,
      'servicedByPetner': servicedByPetner,
      'veterinary': veterinary,
      'crmv': crmv,
      'screeningName': screeningName,
      'diagnostic': diagnostic,
      'attachment': attachment,
      'typeServiceForm': typeServiceForm,
      'riskRating': riskRating,
      'exameList': exameListJson,
      'medicineList': medicineListJson,
      'fileList': fileListJson,
    };
  }
}

class PetExameListModel {
  late final int exameId;
  late final String exameName;
  late final String typeExameName;
  PetExameListModel({
    required this.exameId,
    required this.exameName,
    required this.typeExameName,
  });

  factory PetExameListModel.fromJson(Map<String, dynamic> json) {
    return PetExameListModel(
      exameId: json['exameId'],
      exameName: json['exameName'],
      typeExameName: json['typeExameName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exameId': exameId,
      'exameName': exameName,
      'typeExameName': typeExameName,
    };
  }
}

class PetMedicineListModel {
  late final int medicineId;
  late final String medicineName;
  late final String dosage;
  PetMedicineListModel({
    required this.medicineId,
    required this.medicineName,
    required this.dosage,
  });

  factory PetMedicineListModel.fromJson(Map<String, dynamic> json) {
    return PetMedicineListModel(
      medicineId: json['medicineId'],
      medicineName: json['medicineName'],
      dosage: json['dosage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'medicineName': medicineName,
      'dosage': dosage,
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
