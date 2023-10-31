// ignore_for_file: file_names

class ServiceQueueModel {
  late final int queueId;
  late final int queueType;
  late final String? tutorName;
  late final int petId;
  late final String? petName;
  late final String? petNickName;
  late final String? plan;
  late final String? petPhoto;
  late final String? bithDay;
  late final String? age;
  late final int? ageType;
  late final int? raceId;
  late final String? raceName;
  late final int? specieId;
  late final String? specieName;
  late final String? genderId;
  late final String? genderName;
  late final int? sizeId;
  late final String? sizeName;
  late final int? coatId;
  late final String? coatName;
  late final int? temperamentId;
  late final String? temperamentName;
  late final bool? castrated;
  late final String? state;
  late final String? city;
  late final String? neidhborhood;
  late final int? environmentId;
  late final String? environmentName;
  late final int? foodId;
  late final String? foodName;
  late final int? bodyScoreId;
  late final String? bodyScoreName;
  late final int? productId;
  late final String? productName;
  late final int? screeningId;
  late final String? screeningName;
  late final List<ScreeningModel>? screeningList;

  ServiceQueueModel({
    required this.queueId,
    required this.queueType,
    required this.tutorName,
    required this.petId,
    required this.petName,
    required this.petNickName,
    required this.plan,
    required this.petPhoto,
    required this.bithDay,
    required this.age,
    required this.ageType,
    required this.raceId,
    required this.raceName,
    required this.specieId,
    required this.specieName,
    required this.genderId,
    required this.genderName,
    required this.sizeId,
    required this.sizeName,
    required this.coatId,
    required this.coatName,
    required this.temperamentId,
    required this.temperamentName,
    required this.castrated,
    required this.state,
    required this.city,
    required this.neidhborhood,
    required this.environmentId,
    required this.environmentName,
    required this.foodId,
    required this.foodName,
    required this.bodyScoreId,
    required this.bodyScoreName,
    required this.productId,
    required this.productName,
    required this.screeningId,
    required this.screeningName,
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
      petId: json['petId'],
      petName: json['petName'],
      petNickName: json['petNickName'],
      plan: json['plan'],
      petPhoto: json['petPhoto'],
      bithDay: json['bithDay'],
      age: json['age'],
      ageType: json['ageType'],
      raceId: json['raceId'],
      raceName: json['raceName'],
      specieId: json['specieId'],
      specieName: json['specieName'],
      genderId: json['genderId'],
      genderName: json['genderName'],
      sizeId: json['sizeId'],
      sizeName: json['sizeName'],
      coatId: json['coatId'],
      coatName: json['coatName'],
      temperamentId: json['temperamentId'],
      temperamentName: json['temperamentName'],
      castrated: json['castrated'],
      state: json['state'],
      city: json['city'],
      neidhborhood: json['neidhborhood'],
      environmentId: json['environmentId'],
      environmentName: json['environmentName'],
      foodId: json['foodId'],
      foodName: json['foodName'],
      bodyScoreId: json['bodyScoreId'],
      bodyScoreName: json['bodyScoreName'],
      productId: json['productId'],
      productName: json['productName'],
      screeningId: json['screeningId'],
      screeningName: json['screeningName'],
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
      'petId': petId,
      'petName': petName,
      'petNickName': petNickName,
      'plan': plan,
      'petPhoto': petPhoto,
      'bithDay': bithDay,
      'age': age,
      'ageType': ageType,
      'raceId': raceId,
      'raceName': raceName,
      'specieId': specieId,
      'specieName': specieName,
      'genderId': genderId,
      'genderName': genderName,
      'sizeId': sizeId,
      'sizeName': sizeName,
      'coatId': coatId,
      'coatName': coatName,
      'temperamentId': temperamentId,
      'temperamentName': temperamentName,
      'castrated': castrated,
      'state': state,
      'city': city,
      'neidhborhood': neidhborhood,
      'environmentId': environmentId,
      'environmentName': environmentName,
      'foodId': foodId,
      'foodName': foodName,
      'bodyScoreId': bodyScoreId,
      'bodyScoreName': bodyScoreName,
      'productId': productId,
      'productName': productName,
      'screeningId': screeningId,
      'screeningName': screeningName,
      'screeningList': screeningListJson
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
