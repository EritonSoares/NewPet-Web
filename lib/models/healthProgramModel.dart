// ignore_for_file: file_names

class HealthProgramModel {
  late final String healthProgramid;
  late final String name;
  late final int specieId;
  late final String action;
  late final String description;
  late final String factorType;
  late final String factor;
  late final String product;
  late final String amount;
  late final String frequency;

  HealthProgramModel({
    required this.healthProgramid,
    required this.name,
    required this.specieId,
    required this.action,
    required this.description,
    required this.factorType,
    required this.factor,
    required this.product,
    required this.amount,
    required this.frequency,
  });

  factory HealthProgramModel.fromJson(Map<String, dynamic> json) {
    return HealthProgramModel(
      healthProgramid: json['healthProgramid'],
      name: json['name'],
      specieId: json['specieId'],
      action: json['action'],
      description: json['description'],
      factorType: json['factorType'],
      factor: json['factor'],
      product: json['product'],
      amount: json['amount'],
      frequency: json['frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthProgramid': healthProgramid,
      'name': name,
      'specieId': specieId,
      'action': action,
      'description': description,
      'factorType': factorType,
      'factor': factor,
      'product': product,
      'amount': amount,
      'frequency': frequency,
    };
  }
}
