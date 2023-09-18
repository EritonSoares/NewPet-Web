// ignore_for_file: file_names

import 'package:path_provider/path_provider.dart';

class PathProvider {
  static Future<String?> getPah() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String?> getPahFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
}
