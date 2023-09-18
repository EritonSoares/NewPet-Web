// ignore_for_file: file_names

class PetTreatmentModel {
  late final int treatmentId;
  late final String description;
  late final String medicine;
  late final String amount;
  late final int? unit;
  late final int? timesDay;
  late final int? howManyDays;
  late final bool continuous;
  late final String quantityBox;
  late final String amountBox;
  late final String startTime;
  late final String? startDate;
  late final String? finishDate;
  late final bool finished;
  late final String? exclusionDate;

  PetTreatmentModel({
    required this.treatmentId,
    required this.description,
    required this.medicine,
    required this.amount,
    required this.unit,
    required this.timesDay,
    required this.howManyDays,
    required this.continuous,
    required this.quantityBox,
    required this.amountBox,
    required this.startTime,
    required this.startDate,
    required this.finishDate,
    required this.finished,
    required this.exclusionDate,
  });

  factory PetTreatmentModel.fromJson(Map<String, dynamic> json) {
    return PetTreatmentModel(
      treatmentId: json['treatmentId'],
      description: json['description'],
      medicine: json['medicine'],
      amount: json['amount'],
      amountBox: json['amountBox'],
      continuous: json['continuous'],
      exclusionDate: json['exclusionDate'],
      finished: json['finished'],
      howManyDays: json['howManyDays'],
      quantityBox: json['quantityBox'],
      startDate: json['startDate'],
      finishDate: json['finishDate'],
      startTime: json['startTime'],
      timesDay: json['timesDay'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'treatmentId': treatmentId,
      'description': description,
      'medicine': medicine,
      'amount': amount,
      'amountBox': amountBox,
      'continuous': continuous,
      'exclusionDate': exclusionDate,
      'finished': finished,
      'howManyDays': howManyDays,
      'quantityBox': quantityBox,
      'startDate': startDate,
      'finishDate': finishDate,
      'startTime': startTime,
      'timesDay': timesDay,
      'unit': unit,
    };
  }
}
