// ignore_for_file: file_names

import 'package:flutter/material.dart' show AlertDialog, BuildContext, CircleAvatar, Colors, Column, CrossAxisAlignment, EdgeInsets, FontWeight, Icon, IconButton, MainAxisAlignment, MaterialPageRoute, Navigator, NetworkImage, Padding, Row, SizedBox, Text, TextButton, TextOverflow, TextStyle, Widget, showDialog;
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/petModel.dart';
import '../shared/data/genderData.dart';
import '../shared/data/petData.dart';
import '../shared/data/raceData.dart';
import '../shared/data/specieData.dart';

class CustomWidgets {
  static void showAlertDialog(BuildContext context, String message, int validate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.pop(context);
                if (validate == 1) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

Widget getPetData(PetModel myPet, bool pageMyPet, BuildContext context, [updatePetData]) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Foto do pet
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(myPet.imageUrl),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8.0),
            // Espécie do pet
            Text(
              '${SpecieData().getSpecieById(PetData().getPetById(myPet.id.toString()).specie).name} - ${GenderData().getGenderById(PetData().getPetById(myPet.id.toString()).gender)['name']}',
              style: const TextStyle(fontSize: 18, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
            ),
            // Raça do pet
            const SizedBox(height: 5.0),
            Text(
              RaceData().getRaceById(myPet.race).name,
              style: const TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5.0),
            // Idade do pet
            Text(
              myPet.age,
              style: const TextStyle(fontSize: 12, fontFamily: 'Baloo'),
            ),
          ],
        ),
        const SizedBox(width: 20.0),
        //if (pageMyPet)
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: IconButton(
            onPressed: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPetPage(option: 'U', petId: myPet.id)),
              ).whenComplete(() {
                updatePetData(PetData().getPetById(myPet.id.toString()));
              });
              */
            },
            icon: Icon(
              PhosphorIcons.regular.pencilSimple,
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    ),
  );
}
