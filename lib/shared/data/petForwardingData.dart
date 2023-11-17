// ignore_for_file: file_names

import 'package:petner_web/models/petForwardingModel.dart';

class PetForwardingData {
  static final PetForwardingData _instance = PetForwardingData._internal();

  factory PetForwardingData() {
    return _instance;
  }

  PetForwardingData._internal();

  List<PetForwardingModel> petForwardingList = [];

  PetForwardingModel getSymptomById(int index) {
    return petForwardingList
        .firstWhere((element) => (element.petForwardingId == index));
  }
}
