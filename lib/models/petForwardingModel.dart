// ignore_for_file: file_names

class PetForwardingModel {
  late final int? petForwardingId;
  late final String? forwardingName;
  late final String? forwardingType;

  PetForwardingModel({
    required this.petForwardingId,
    required this.forwardingName,
    required this.forwardingType,
  });

  factory PetForwardingModel.fromJson(Map<String, dynamic> json) {
    return PetForwardingModel(
      petForwardingId: json['petForwardingId'],
      forwardingName: json['forwardingName'],
      forwardingType: json['forwardingType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petForwardingId': petForwardingId,
      'forwardingName': forwardingName,
      'forwardingType': forwardingType,
    };
  }
}
