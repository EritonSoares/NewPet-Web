// ignore_for_file: file_names

import 'package:petner_web/models/consultationModel.dart';

class ConsultationData{
  static final ConsultationData _instance = ConsultationData._internal();

  factory ConsultationData() {
    return _instance;
  }

  ConsultationData._internal();

  List<ConsultationModel> consultationList = [];

  ConsultationModel getConsultationById(int index) {
    return consultationList.firstWhere((element) => (element.id == index));
  }
}
