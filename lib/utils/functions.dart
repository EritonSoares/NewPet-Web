// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:petner_web/utils/widgetUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String calculateAge(DateTime dataNascimento) {
  DateTime dataAtual = DateTime.now();

  int anos = dataAtual.year - dataNascimento.year;
  int meses = dataAtual.month - dataNascimento.month;
  int dias = dataAtual.day - dataNascimento.day;

  if (meses < 0 || (meses == 0 && dias < 0)) {
    anos--;
    meses += 12;
  }

  if (dias < 0) {
    int ultimoDiaMesAnterior =
        DateTime(dataAtual.year, dataAtual.month - 1, 0).day;
    dias += ultimoDiaMesAnterior;
    meses--;
  }

  String idade = '$anos ano(s), $meses mese(s), $dias dia(s)';
  if (anos == 0 && meses > 0) {
    idade = '$meses mese(s), $dias dia(s)';
  } else if (anos == 0 && meses == 0) {
    idade = '$dias dia(s)';
  }

  return idade;
}

Future<void> saveBase64Image(String base64Image, String fileName) async {
  Uint8List bytes = base64.decode(base64Image);
  //String path = (await getApplicationDocumentsDirectory()).path;
  File file = File(fileName);

  await file.writeAsBytes(bytes);

  File(fileName).exists().then(
      (value) => value ? print('xx Arquivo Existe') : 'Arquivo NÃO Existe');
}

Widget getImageFile(String fileName) {
  return CircleAvatar(
      radius: 60,
      backgroundImage: FileImage(
        File(fileName),
      ));
}

void showAlertDialog(BuildContext context, String message, int validatePet) {
  CustomWidgets.showAlertDialog(
    context,
    message,
    validatePet,
  );
}
