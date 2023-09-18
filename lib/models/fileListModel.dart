// ignore_for_file: file_names

class PetFileModel {
  late final int fileId;
  late final int fileTypeId;
  late final String description;
  late final String filePath;
  late final String fileTypeName;
  late final String otherType;
  late final String fileDate;
  late final int serviceRecordNumber;
  late final String veterinary;
  late final String crmv;

  PetFileModel({
    required this.fileId,
    required this.fileTypeId,
    required this.description,
    required this.filePath,
    required this.fileTypeName,
    required this.otherType,
    required this.fileDate,
    required this.serviceRecordNumber,
    required this.veterinary,
    required this.crmv,
  });

  factory PetFileModel.fromJson(Map<String, dynamic> json) {
    return PetFileModel(
      fileId: json['fileId'],
      fileTypeId: json['fileTypeId'],
      description: json['description'],
      filePath: json['filePath'],
      fileTypeName: json['fileTypeName'],
      otherType: json['otherType'],
      fileDate: json['fileDate'],
      serviceRecordNumber: json['serviceRecordNumber'],
      veterinary: json['veterinary'],
      crmv: json['crmv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'fileTypeId': fileTypeId,
      'description': description,
      'filePath': filePath,
      'fileTypeName': fileTypeName,
      'otherType': otherType,
      ' fileDate': fileDate,
      'serviceRecordNumber': serviceRecordNumber,
      'veterinary': veterinary,
      'crmv': crmv,
    };
  }
}
