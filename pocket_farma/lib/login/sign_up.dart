// ignore_for_file: use_build_context_synchronously, avoid_print, camel_case_types, unused_field, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pocket_farma/login/Notification.dart';
// import 'package:http/http.dart' as http;

import 'package:pocket_farma/login/login_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<signUpPage> {
  List<String> suggestions = [];

  someFunction() async {
    final collection = FirebaseFirestore.instance.collection("Accounts");
    await collection.get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var a = querySnapshot.docs;
        for (var element in a) {
          suggestions.add(element.data()['Name']);
        }
        setState(() {
          suggestions;
        });
      }
    });
  }

  bool isCheck = false;
  File? _file;
  PlatformFile? _DoctorFile;
  PlatformFile? _DistributerFile;
  UploadTask? uploadTaskDoctor;
  UploadTask? uploadTaskDistributer;

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  final password = "000000000";
  String? body;
  String? title;
  String? token;

  final _formKey = GlobalKey<FormState>();
  String dropDownValue = '';
  String genderValue = '';
  late String todaydate;

  String professionalValue = '';
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    DateTime today = DateTime.now();
    todaydate = "${today.day}-${today.month}-${today.year}";
    someFunction();

    print(todaydate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 169, 221, 247),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/pocket_pharma_sign_up.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: Text("Name:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: TextFormField(
                      controller: nameController,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 3, color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Enter valid name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: Text("Age:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: TextFormField(
                        controller: ageController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || int.parse(value) < 18) {
                            return 'Age should be 18+ ';
                          }
                          return null;
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: Text("Gender:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 3, color: Colors.black),
                        ),
                      ),
                      value: dropDownValue,
                      items: const [
                        DropdownMenuItem<String>(
                            value: '', child: Text('-choose-')),
                        DropdownMenuItem<String>(
                            value: 'male', child: Text('Male')),
                        DropdownMenuItem<String>(
                            value: 'female', child: Text('Female')),
                        DropdownMenuItem<String>(
                            value: 'other', child: Text('Other')),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          genderValue = value!;
                        });
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Choose gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: Text("Phone:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: TextFormField(
                        controller: mobileController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || (value.length) != 10) {
                            return 'Enter valid mobile number';
                          }
                          return null;
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: Text("Email:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: TextFormField(
                        controller: emailController,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !EmailValidator.validate(value, true)) {
                            return 'Enter valid Email Address';
                          }
                          return null;
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: Text("Profession:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 8, left: 10, bottom: 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 3, color: Colors.black),
                        ),
                      ),
                      value: professionalValue,
                      items: const [
                        DropdownMenuItem<String>(
                            value: '', child: Text('-choose-')),
                        DropdownMenuItem<String>(
                            value: 'Doctor', child: Text('Doctor')),
                        DropdownMenuItem<String>(
                            value: 'Medical Distributer',
                            child: Text('medical distributer')),
                        DropdownMenuItem<String>(
                            value: 'User', child: Text('User')),
                      ],
                      onChanged: (String? value) {
                        print(value);
                        setState(() {
                          professionalValue = value!;
                        });
                      },
                      validator: (value) {
                        if (professionalValue == '') {
                          return 'Choose Your Profession';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (professionalValue == 'Doctor')
                    TextButton(
                      onPressed: () => doctorProf(binary: true),
                      child: const Text("Upload Document"),
                    )
                  else if (professionalValue == 'Medical Distributer')
                    TextButton(
                      onPressed: () => distributerProf(binary: true),
                      child: const Text("Upload image"),
                    ),
                  if (professionalValue != 'User')
                    _DoctorFile != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blueAccent)),
                              child:
                                  Text("Selected File: ${_DoctorFile!.name}"),
                            ),
                          )
                        : Container(),
                  _DistributerFile != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text(
                                  "Documnet for proof: ${_DistributerFile!.name}")),
                        )
                      : Container(),
                  FormField(
                    builder: (state) {
                      return Row(
                        children: [
                          Checkbox(
                              value: isCheck,
                              onChanged: (value) {
                                isCheck = value!;
                                state.didChange(value);
                              }),
                          const Text('Entered data is correct?'),
                        ],
                      );
                    },
                    validator: (value) {
                      if (isCheck == false) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          content: Text("Ensure entered data is correct?"),
                          backgroundColor: Colors.red,
                        ));
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 70,
                          right: 70,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.validate();

                            checkName();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Alredy have an account?',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              'Sign In ',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const loginPage()));
                            },
                          )
                        ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  // image sending for doctors

  doctorProf({required bool binary}) async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'pdf']);

    if (file != null) {
      setState(() {
        _DistributerFile = null;
        _file = File(file.files.single.path!);
        _DoctorFile = file.files.first;
      });
    }
  }
  // image sending for distributers

  distributerProf({required bool binary}) async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'pdf']);

    if (file != null) {
      setState(() {
        _DoctorFile = null;
        _file = File(file.files.single.path!);
        _DistributerFile = file.files.first;
      });
    }
  }

  Future checkName() async {
    int count = 0;
    if (nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        mobileController.text.isNotEmpty &&
        professionalValue != '' &&
        genderValue != '' &&
        emailController.text.isNotEmpty) {
      for (int i = 0; i < suggestions.length; i++) {
        if (suggestions[i] == nameController.text) {
          setState(() {
            count++;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            content:
                Text("User Name already taken, you have to change the Name"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     behavior: SnackBarBehavior.floating,
    //     margin: EdgeInsets.all(10),
    //     content: Text("Ensure data is correct!"),
    //     duration: Duration(seconds: 2),
    //     backgroundColor: Colors.red,
    //   ));
    // }
    if (count == 0) {
      signup();
    } else {
      return;
    }
  }

  Future signup() async {
    if (professionalValue == 'Doctor') {
      if (_DoctorFile != null) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: password,
          );
          dataCheck();
        } on FirebaseAuthException catch (e) {
          print(e);
          errorMessage();
        }
      } else {
        print("error");
        showErrorMessageForUploadingFiles();
      }
    } else if (professionalValue == 'Medical Distributer') {
      if (_DistributerFile != null) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: password,
          );
          dataCheck();
        } on FirebaseAuthException catch (e) {
          print(e);
          errorMessage();
        }
      } else {
        showErrorMessageForUploadingFiles();
      }
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: password,
        );
        dataCheck();
      } on FirebaseAuthException catch (e) {
        print(e);
        errorMessage();
      }
    }
  }

  dataCheck() async {
    // send data to common table
    commonTable();
    // dataCheck()  {
    if (professionalValue == 'Doctor') {
      doctorData();
      uploadFileToDoctor();
    } else if (professionalValue == 'Medical Distributer') {
      distributersData();
      uploadFileToDistributers();
    } else {
      normalUsersData();
    }
  }
  // functions for doctors

  void doctorData() async {
    final nameValue = nameController.text;
    final ageValue = int.parse(ageController.text);
    final professionValue = professionalValue;
    final mobileValue = mobileController.text;
    final emailValue = emailController.text;
    final gender = genderValue;

    final doctor = Doctor(
      name: nameValue,
      age: ageValue,
      profession: professionValue,
      phone: mobileValue,
      email: emailValue,
      gender: gender,
    );
    //  sendData(doctor);
    await sendData(doctor);
    await Future.delayed(const Duration(milliseconds: 1000));

    NotificationSettingsDoneToDoctors();
    listenNotification();
    clearing();
    // sendPushMessageForDoctor(token, body, title);
  }

  NotificationSettingsDoneToDoctors() async {
    NotificationApi.showNotification(
      title: 'Hello Dr ${nameController.text}',
      body:
          ' Your pocket pharma Account  is sucssessfully registered , Soon Admin will verify Your Account ',
    );
    print("complete 4");
  }

  Future sendData(Doctor doctor) async {
    final docValue = FirebaseFirestore.instance
        .collection('Doctors')
        .doc(nameController.text);
    final jsonDatas = doctor.toJson();
    await docValue.set(jsonDatas);
  }
  // distributers functions

  void distributersData() async {
    final nameValue = nameController.text;
    final ageValue = int.parse(ageController.text);
    final professionValue = professionalValue;
    final mobileValue = mobileController.text;
    final emailValue = emailController.text;
    final gender = genderValue;

    final distributer = Distributer(
      name: nameValue,
      age: ageValue,
      profession: professionValue,
      phone: mobileValue,
      email: emailValue,
      gender: gender,
    );
    //  sendData to distributers
    await sendDatatoDistributer(distributer);
    NotificationSettingsDoneToDistributers();
    listenNotification();
    clearing();
  }

  Future sendDatatoDistributer(Distributer distributer) async {
    final distributerValue = FirebaseFirestore.instance
        .collection('Medical_Distributers')
        .doc(nameController.text);
    final jsonDatas = distributer.toJson();
    await distributerValue.set(jsonDatas);
    await Future.delayed(const Duration(milliseconds: 1000));

    // sendPushMessageForDistributer(token, body, title);
  }

  NotificationSettingsDoneToDistributers() async {
    NotificationApi.showNotification(
      title: 'Hello  ${nameController.text}',
      body:
          ' Your pocket pharma Account  is sucssessfully registered , Soon Admin will verify Your Account ',
    );
    print("complete 4");
  }

  void listenNotification() {
    print('complete 5');

    NotificationApi.onNotification.stream.listen((String? payload) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const loginPage()));
    });
  }
  // normal users functions

  void normalUsersData() async {
    final nameValue = nameController.text;
    final ageValue = int.parse(ageController.text);
    final professionValue = professionalValue;
    final mobileValue = mobileController.text;
    final emailValue = emailController.text;
    final gender = genderValue;

    final normalUser = NormalUser(
      name: nameValue,
      age: ageValue,
      profession: professionValue,
      phone: mobileValue,
      email: emailValue,
      gender: gender,
    );
    //  sendData to normal users
    await sendDataToNormalUser(normalUser);
    await Future.delayed(const Duration(milliseconds: 1000));

    NotificationSettingsDoneToNormalUser();
    listenNotification();
    clearing();
  }

  NotificationSettingsDoneToNormalUser() async {
    NotificationApi.showNotification(
      title: 'Hello ${nameController.text}',
      body:
          ' Your pocket pharma Account   is sucssessfully registered , you can login now ',
    );
    print("complete 4");
  }

  Future sendDataToNormalUser(NormalUser normalUser) async {
    final docValue =
        FirebaseFirestore.instance.collection('Users').doc(nameController.text);
    final jsonDatas = normalUser.toJson();
    await docValue.set(jsonDatas);
  }

  void commonTable() async {
    final nameValue = nameController.text;
    final ageValue = int.parse(ageController.text);
    final professionValue = professionalValue;
    final phoneValue = mobileController.text;
    final gender = genderValue;

    final emailValue = emailController.text;
    final defaultTableUser = Accounts(
      name: nameValue,
      age: ageValue,
      profession: professionValue,
      phone: phoneValue,
      email: emailValue,
      gender: gender,
    );
    await sendDataToDefaultTable(defaultTableUser);
  }

  Future sendDataToDefaultTable(Accounts defaultTableUser) async {
    final usr = FirebaseFirestore.instance
        .collection('Accounts')
        .doc(nameController.text);
    final jasonDatas = defaultTableUser.toJson();
    await usr.set(jasonDatas);
  }

  Future uploadFileToDoctor() async {
    final path =
        'file/Doctor/$todaydate/${nameController.text}/${_DoctorFile!.name}';
    final files = File(_DoctorFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTaskDoctor = ref.putFile(files);
      uploadTaskDistributer = null;
    });

    final snapshot = await uploadTaskDoctor!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download Link : $urlDownload");
    setState(() {
      uploadTaskDoctor = null;
    });
  }

  Future uploadFileToDistributers() async {
    final path =
        'file/Distributers/$todaydate/${nameController.text}/${_DistributerFile!.name}';
    final files = File(_DistributerFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTaskDistributer = ref.putFile(files);
      uploadTaskDoctor = null;
    });

    final snapshot = await uploadTaskDistributer!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download Link : $urlDownload");
    setState(() {
      uploadTaskDistributer = null;
    });
  }

  void clearing() {
    nameController.clear();
    ageController.clear();

    mobileController.clear();
    emailController.clear();

    setState(() {
      _DistributerFile = null;
      _DoctorFile = null;

      isCheck = false;
    });
  }

  void errorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text("Enter valid Account"),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }

  void showErrorMessageForUploadingFiles() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text("Upload your Document"),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }
}

class Doctor {
  final String name;
  final int age;
  final String profession;
  final String phone;
  final String email;
  final String gender;

  Doctor(
      {required this.name,
      required this.age,
      required this.profession,
      required this.phone,
      required this.email,
      required this.gender});

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Age': age.toString(),
        'Profession': profession,
        'Mobile Number': phone,
        'Email': email,
        'Gender': gender,
      };
}
// class for medical distributers

class Distributer {
  final String name;
  final int age;
  final String profession;
  final String phone;
  final String email;

  final String gender;

  Distributer({
    required this.name,
    required this.age,
    required this.profession,
    required this.phone,
    required this.email,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Age': age.toString(),
        'Profession': profession,
        'Mobile Number': phone,
        'Email': email,
        'Gender': gender,
      };
}
// class for normal users

class NormalUser {
  final String name;
  final int age;
  final String profession;
  final String phone;
  final String email;
  final String gender;

  NormalUser({
    required this.name,
    required this.age,
    required this.profession,
    required this.phone,
    required this.email,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Age': age.toString(),
        'Profession': profession,
        'Mobile Number': phone,
        'Email': email,
        'Gender': gender,
      };
}

class Accounts {
  final String name;
  final int age;
  final String profession;
  final String phone;
  final String email;
  final String gender;

  Accounts(
      {required this.name,
      required this.age,
      required this.profession,
      required this.phone,
      required this.gender,
      required this.email});
  Map<String, dynamic> toJson() => {
        'Name': name,
        'Age': age.toString(),
        'Profession': profession,
        'Phone': phone,
        'Email': email,
        'Gender': gender,
      };
}
