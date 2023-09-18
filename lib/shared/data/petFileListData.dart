// ignore_for_file: file_names

import '../../models/fileListModel.dart';

class PetFileData {
  static final PetFileData _instance = PetFileData._internal();

  factory PetFileData() {
    return _instance;
  }

  PetFileData._internal();

  List<PetFileModel> petFileList = [];
}
