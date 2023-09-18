// ignore_for_file: file_names

class FileTypeModel {
  String fileTypeId;
  String description;

  FileTypeModel({
    required this.fileTypeId,
    required this.description,
  });

  factory FileTypeModel.fromJson(Map<String, dynamic> json) {
    return FileTypeModel(
      fileTypeId: json['fileTypeId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileTypeId': fileTypeId,
      'description': description,
    };
  }
}
