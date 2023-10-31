// ignore_for_file: file_names

class PetHealthProgramModel {
  late final String petHealthProgramId;
  late final String name;
  late final String action;
  late final String description;
  late final String product;
  late final String amount;
  late final String frequency;

  PetHealthProgramModel({
    required this.petHealthProgramId,
    required this.name,
    required this.action,
    required this.description,
    required this.product,
    required this.amount,
    required this.frequency,
  });

  factory PetHealthProgramModel.fromJson(Map<String, dynamic> json) {
    return PetHealthProgramModel(
      petHealthProgramId: json['petHealthProgramId'],
      name: json['name'],
      action: json['action'],
      description: json['description'],
      product: json['product'],
      amount: json['amount'],
      frequency: json['frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petHealthProgramId': petHealthProgramId,
      'name': name,
      'action': action,
      'description': description,
      'product': product,
      'amount': amount,
      'frequency': frequency,
    };
  }
}
