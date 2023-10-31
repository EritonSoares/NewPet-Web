// ignore_for_file: file_names

import 'package:petner_web/models/petSericeHistoryModel.dart';

class AnexoServiceHistoryData {
  static final AnexoServiceHistoryData _instance =
      AnexoServiceHistoryData._internal();

  factory AnexoServiceHistoryData() {
    return _instance;
  }

  AnexoServiceHistoryData._internal();

  List<PetFileListModel> anexoServiceHistoryList = [];

/*
  AnexoServiceHistoryModel getAnexoServiceHistoryById(String index) {
    return anexoServiceHistoryList.firstWhere((element) => (element.anexoServiceHistoryId.toString() == index));
  }

  removeAnexoServiceHistoryById(String index) {
    anexoServiceHistoryList.removeWhere((element) => (element.anexoServiceHistoryId.toString() == index));
  }
  */
}
