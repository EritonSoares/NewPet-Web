// ignore_for_file: file_names

import 'package:petner_web/models/serviceQueueModel.dart';

class ServiceQueueData {
  static final ServiceQueueData _instance = ServiceQueueData._internal();

  factory ServiceQueueData() {
    return _instance;
  }

  ServiceQueueData._internal();

  List<ServiceQueueModel> serviceQueueList = [];

}