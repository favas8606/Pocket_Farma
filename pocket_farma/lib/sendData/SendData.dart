// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendDataToDB extends StatefulWidget {
  const SendDataToDB({Key? key}) : super(key: key);

  @override
  State<SendDataToDB> createState() => _SendDataToDBState();
}

class _SendDataToDBState extends State<SendDataToDB> {
  var NameController = TextEditingController();
  var Therapeutic_groupController = TextEditingController();
  var Drug_categoryController = TextEditingController();
  var Indication_DosageController = TextEditingController();
  var ContentController = TextEditingController();
  var InteractionsController = TextEditingController();
  var PrecautionsController = TextEditingController();
  var PregnancyController = TextEditingController();
  var Side_effectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Add Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "Name"),
              controller: NameController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Therapeutic_group"),
              controller: Therapeutic_groupController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Drug_category"),
              controller: Drug_categoryController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Indication_Dosage"),
              controller: Indication_DosageController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Content"),
              controller: ContentController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Precautions"),
              controller: PrecautionsController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Interactions"),
              controller: InteractionsController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Pregnancy"),
              controller: PregnancyController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Side_effect"),
              controller: Side_effectController,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: sendData, child: const Text("SUBMIT")),
            )
          ],
        ),
      ),
    );
  }

  void sendData() async {
    final NameValue = NameController.text;
    final Therapeutic_groupValue = Therapeutic_groupController.text;
    final Drug_categoryValue = Drug_categoryController.text;
    final Indication_DosageValue = Indication_DosageController.text;
    final ContantValue = ContentController.text;
    final PrecautionsValue = PrecautionsController.text;
    final InteractionsValue = InteractionsController.text;
    final PregnancyValue = PregnancyController.text;
    final Side_effectValue = Side_effectController.text;

    final senddata = SendDataTodb(
        name: NameValue,
        Therapeutic_group: Therapeutic_groupValue,
        Drug_category: Drug_categoryValue,
        Indication_Dosage: Indication_DosageValue,
        Content: ContantValue,
        Precautions: PrecautionsValue,
        Interactions: InteractionsValue,
        Pregnancy: PregnancyValue,
        Side_effect: Side_effectValue);
    await sendDataToDataBase(senddata);
    await Future.delayed(const Duration(seconds: 2));
    NameController.clear();
    Therapeutic_groupController.clear();
    Drug_categoryController.clear();
    Indication_DosageController.clear();
    Indication_DosageController.clear();
    ContentController.clear();
    PrecautionsController.clear();
    InteractionsController.clear();
    PregnancyController.clear();
    Side_effectController.clear();
  }

  Future sendDataToDataBase(SendDataTodb senddata) async {
    final finalValue = FirebaseFirestore.instance
        .collection("MEDICINE")
        .doc(NameController.text);
    final jsonData = senddata.toJson();
    await finalValue.set(jsonData);
  }
}

class SendDataTodb {
  final String name;
  final String Therapeutic_group;
  final String Drug_category;
  final String Indication_Dosage;
  final Content;
  final String Precautions;
  final Interactions;
  final Pregnancy;
  final String Side_effect;

  SendDataTodb({
    required this.name,
    required this.Therapeutic_group,
    required this.Drug_category,
    required this.Indication_Dosage,
    this.Content,
    required this.Precautions,
    this.Interactions,
    this.Pregnancy,
    required this.Side_effect,
  });

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Therapeutic group": Therapeutic_group,
        "Drug category": Drug_category,
        "Indication & Dosage": Indication_Dosage,
        "Content": Content,
        "Precautions": Precautions,
        "Interactions": Interactions,
        "Pregnancy": Pregnancy,
        "Side effect": Side_effect,
      };
}
