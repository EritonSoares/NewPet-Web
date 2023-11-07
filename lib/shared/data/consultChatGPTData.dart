// ignore_for_file: file_names

import 'package:petner_web/models/consultChatGPTModel.dart';

class ConsultChatGPTData {
  static final ConsultChatGPTData _instance = ConsultChatGPTData._internal();

  factory ConsultChatGPTData() {
    return _instance;
  }

  ConsultChatGPTData._internal();

  List<ConsultChatGPTModel> consultChatGPTList = [];

  ConsultChatGPTModel getConsultChatGPTById(String index) {
    return consultChatGPTList
        .firstWhere((element) => (element.chatGPTId == index));
  }
}
