// ignore_for_file: file_names

class ServiceQueueModel {
  late final int queueId;
  late final int queueType;
  late final String? tutorName;
  late final String? petName;
  late final String? specie;
  late final String? race;
  late final String? age;
  late final String? screening;
  late final List<ScreeningModel>? screeningList;

  ServiceQueueModel({
    required this.queueId,
    required this.queueType,
    required this.tutorName,
    required this.petName,
    required this.specie,
    required this.race,
    required this.age,
    required this.screening,
    required this.screeningList,
  });

  factory ServiceQueueModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> screeningListJson = json['screeningList'];
    List<ScreeningModel> screeningList = screeningListJson
        .map((vaccineJson) => ScreeningModel.fromJson(vaccineJson))
        .toList();

    return ServiceQueueModel(
      queueId: json['queueId'],
      queueType: json['queueType'],
      tutorName: json['tutorName'],
      petName: json['petName'],
      specie: json['specie'],
      race: json['race'],
      age: json['age'],
      screening: json['screening'],
      screeningList: screeningList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> screeningListJson =
        screeningList!.map((screening) => screening.toJson()).toList();

    return {
      'queueId': queueId,
      'queueType': queueType,
      'tutorName': tutorName,
      'petName': petName,
      'specie': specie,
      'race': race,
      'age': age,
      'screening': screening,
      'vaccineList': screeningListJson
    };
  }
}

class ScreeningModel {
  late final String? question;
  late final String? answer;
  ScreeningModel({
    required this.question,
    required this.answer,
  });

  factory ScreeningModel.fromJson(Map<String, dynamic> json) {
    return ScreeningModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}