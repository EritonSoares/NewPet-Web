// ignore_for_file: file_names

import '../../models/fileTypeModel.dart';

class FileTypeData {
  static final FileTypeData _instance = FileTypeData._internal();

  factory FileTypeData() {
    return _instance;
  }

  FileTypeData._internal();

  List<FileTypeModel> fileTypeListList = [];
}
