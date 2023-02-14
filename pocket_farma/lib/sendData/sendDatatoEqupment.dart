// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class datatoEqupment extends StatefulWidget {
  const datatoEqupment({Key? key}) : super(key: key);

  @override
  State<datatoEqupment> createState() => _datatoEqupmentState();
}

class _datatoEqupmentState extends State<datatoEqupment> {
  var nameController = TextEditingController();
  var usageController = TextEditingController();
  var partsController = TextEditingController();
  var accessoriesController = TextEditingController();
  var careController = TextEditingController();
  var preparationController = TextEditingController();

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
        title: const Text('Add Equipment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "Name"),
              controller: nameController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "usage"),
              controller: usageController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "parts"),
              controller: partsController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "accessories"),
              controller: accessoriesController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "care"),
              controller: careController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "preparation"),
              controller: preparationController,
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
    final nameValue = nameController.text;
    final usageValue = usageController.text;
    final partsValue = partsController.text;
    final accessoriesValue = accessoriesController.text;
    final careValue = careController.text;
    final preparationValue = preparationController.text;
    final senddata = sendDatatoDB(
      name: nameValue,
      usage: usageValue,
      parts: partsValue,
      accessories: accessoriesValue,
      care: careValue,
      preparation: preparationValue,
    );
    await sendDatatoDatabase(senddata);
    await Future.delayed(const Duration(seconds: 2));
    nameController.clear();
    careController.clear();
    partsController.clear();
    usageController.clear();
    preparationController.clear();
    accessoriesController.clear();
  }

  sendDatatoDatabase(sendDatatoDB senddata) async {
    final databaseValue = FirebaseFirestore.instance
        .collection("EQUIPMENT")
        .doc(nameController.text);
    final jsonData = senddata.toJson();
    await databaseValue.set(jsonData);
  }
}

class sendDatatoDB {
  final name;
  final usage;
  final parts;
  final accessories;
  final care;
  final preparation;
  sendDatatoDB(
      {this.name,
      this.usage,
      this.parts,
      this.accessories,
      this.care,
      this.preparation});
  Map<String, dynamic> toJson() => {
        'Name': name,
        'Usage': usage,
        'Parts': parts,
        'Accessories': accessories,
        'Care': care,
        'Preparation': preparation,
      };
}
