// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key}) : super(key: key);

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  var nameController = TextEditingController();
  var professionType = '';
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: deleteData,
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void deleteData() async {
    // featch profession
    try {
      await FirebaseFirestore.instance
          .collection('Accounts')
          .doc(nameController.text)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.data()!.isNotEmpty) {
          Map<String, dynamic>? user = querySnapshot.data();
          setState(() {
            professionType = user!["Profession"];
            print(professionType);
          });
        }
      });
      // set CommonTable to Delete
      final userAccounts = FirebaseFirestore.instance
          .collection("Accounts")
          .doc(nameController.text);
      // Set Professional Account To Delete
      final professionalAccount = FirebaseFirestore.instance
          .collection(professionType)
          .doc(nameController.text);
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
                title: const Text('Delete'),
                content: Text(
                    'You are going to Delete User ${nameController.text} '),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        userAccounts.delete();
                        professionalAccount.delete();
                        success();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red, // Text Color
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      )),
                ]);
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("User Not Found"),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 32, 32),
      ));
    }
  }

  void success() async {
    await Future.delayed(const Duration(milliseconds: 250));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text("Succsess"),
      duration: Duration(seconds: 2),
      backgroundColor: Color.fromARGB(255, 3, 179, 26),
    ));
    nameController.clear();
  }
}
