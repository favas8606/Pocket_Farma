// ignore_for_file: prefer_const_declarations, camel_case_types, avoid_print, file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class report_Problem extends StatefulWidget {
  const report_Problem({Key? key}) : super(key: key);

  @override
  State<report_Problem> createState() => _report_ProblemState();
}

class _report_ProblemState extends State<report_Problem> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Map<String, dynamic>? user = {
    "Name": "",
    "Profession": "",
    "Age": "",
    "Email": "",
    "Phone": "",
    "Gender": "",
  };

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: ((context) => const navBar())));
            }),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Report Problem',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
            width: double.infinity,
            child: Text(
              "Briefly explain what happened or what's not working?",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
            child: TextField(
              controller: textController,
              textInputAction: TextInputAction.newline,
              autofocus: true,
              autocorrect: true,
              maxLines: 5,
              maxLength: 300,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: const InputDecoration(
                hintText: 'Enter the problems you have...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 75,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    const Color.fromARGB(255, 84, 187, 201), // Background color
              ),
              child: const Icon(
                Icons.send,
                size: 25,
              ),
              onPressed: () {
                //where to send the report
                // textController.clear();
                sendEmail(
                    name: user!['Name'],
                    email: user!['Email'],
                    message: textController.text);
              },
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          const SizedBox(
            height: 20,
            child: Center(
              child: Text(
                'Pocket Pharma',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 175, 178, 180),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future sendEmail(
      {required String name,
      required String email,
      required String message}) async {
    final serviceId = 'service_41x3u7r';
    final templateId = "template_idds1ga";
    final userId = "zT1VZPQTYAeEnJXGY";

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
        },
      }),
    );
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: const Text("Feedback succssfully sent!"),
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green[400],
    ));
    await Future.delayed(const Duration(seconds: 1));
    textController.clear();
  }

  void getUserData() async {
    final docName = await SharedPreferences.getInstance();
    final String? docnam = docName.getString('docname');
    print(docnam);

    FirebaseFirestore.instance
        .collection("Accounts")
        .doc(docnam)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.data()!.isNotEmpty) {
        setState(() => {user = querySnapshot.data()});
      }
    });
  }
}
