// ignore_for_file: file_names, implementation_imports, unnecessary_import, unused_field, non_constant_identifier_names, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MedicineDataTransfer extends StatefulWidget {
  const MedicineDataTransfer({Key? key}) : super(key: key);

  @override
  State<MedicineDataTransfer> createState() => _MedicineDataTransferState();
}

class _MedicineDataTransferState extends State<MedicineDataTransfer> {
  @override
  void initState() {
    emailOfDoctor();
    super.initState();
  }

  emailOfDoctor() async {
    final DoctorEmail = await SharedPreferences.getInstance();
    final doctorEmail = DoctorEmail.getString('Dremail');

    setState(() {
      recepiantMail = doctorEmail;
    });
    if (recepiantMail == null) {
      ifdoctoremailnull();
    }
    // print(recepiantMail);
  }

  ifdoctoremailnull() async {
    Map<String, dynamic>? email = {
      "Name": "",
      "Profession": "",
      "Age": "",
      "Email": "",
      "Phone": "",
      "Gender": "",
    };
    final DoctorName = await SharedPreferences.getInstance();
    final doctorname = DoctorName.getString('name');
    FirebaseFirestore.instance
        .collection("Doctors")
        .doc(doctorname)
        .get()
        .then((querySnapshort) {
      if (querySnapshort.data()!.isNotEmpty) {
        recepiantMail = email['Email'];
      }
      print(recepiantMail);
    });
  }

  List<String> attachments = [];
  List<String> files = [];
  bool isHTML = true;
  var dataFile;
  var recepiantMail;

  var nameController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();
  File? _file;
  PlatformFile? _NewDataFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: const Text('Send Documents'),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: nameController,
            autofocus: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: ("Name of the new product"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide:
                      const BorderSide(width: 5, color: Colors.blueAccent)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: subjectController,
            autocorrect: true,
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: (" category of the medicine"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide:
                      const BorderSide(width: 5, color: Colors.blueAccent)),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
          child: TextField(
            controller: messageController,
            textInputAction: TextInputAction.newline,
            autofocus: true,
            autocorrect: true,
            maxLines: 8,
            maxLength: 500,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              hintText: 'Explain about new product',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide:
                      const BorderSide(width: 5, color: Colors.blueAccent)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => medicineData(binary: true),
                child: const Text("Choose Document"),
              ),
            ],
          ),
        ),
        _NewDataFile != null
            ? Column(children: <Widget>[
                for (var i = 0; i < files.length; i++)
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          files[i],
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => {_removeAttachment(i)},
                      )
                    ],
                  ),
              ])
            : Container(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {
                sendDataToUser();
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              )),
        )
      ]),
    );
  }

  medicineData({required bool binary}) async {
    final file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _NewDataFile = file.files.first;
        dataFile = _NewDataFile!.path;

        print("file  $dataFile");

        addToAttachement();
      });
    }
  }

  void sendDataToUser() async {
    print(recepiantMail);
    final Email email = Email(
      body: messageController.text,
      subject: subjectController.text,
      recipients: [recepiantMail],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }
    if (!mounted) return;
  }

  void addToAttachement() {
    final name = dataFile.split('/').last;
    setState(() {
      attachments.add(dataFile);
      files.add(name);
    });
  }

  _removeAttachment(int i) {
    setState(() {
      attachments.removeAt(i);
      files.removeAt(i);
    });
  }
}
