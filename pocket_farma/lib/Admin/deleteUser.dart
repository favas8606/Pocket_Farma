// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key}) : super(key: key);

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  var nameController = TextEditingController();
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
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: deleteData, child: const Text("Delete")),
            )
          ],
        ),
      ),
    );
  }

  void deleteData() async {
    SharedPreferences typeOfProfession = await SharedPreferences.getInstance();
    final professionType = typeOfProfession.getString('professionValue');
    // Delete form account table
    final userAccounts = FirebaseFirestore.instance
        .collection("Accounts")
        .doc(nameController.text);
    await userAccounts.delete();
    // Delete from professional table
    final userProfession = FirebaseFirestore.instance
        .collection(professionType!)
        .doc(nameController.text);
    await userProfession.delete();
  }
}
