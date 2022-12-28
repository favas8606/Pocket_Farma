// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/login/login_page.dart';
import 'package:file_picker/file_picker.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<signUpPage> {
  bool isCheck = false;
  File? _file;
  PlatformFile? _DoctorFile;
  PlatformFile? _DistributerFile;

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  final password = "000000000";

  final _formKey = GlobalKey<FormState>();
  String dropDownValue = '';
  String genderValue = '';

  String professionalValue = '';
  // Map<String, String> enteredValues = {};

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
                      validator: (_) {
                        if (nameController.text.length < 4) {
                          return 'Enter valid name';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   setState(() {
                      //     enteredValues['Name'] = value!;
                      //   });
                      // },
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
                        // onSaved: (value) {
                        //   setState(() {
                        //     enteredValues['Age'] = value!;
                        //   });
                        // },
                        validator: (_) {
                          if (int.parse(ageController.text) < 18) {
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
                      // onSaved: (value) {
                      //   setState(() {
                      //     enteredValues['Gender'] = value.toString();
                      //   });
                      // },
                      validator: (_) {
                        if (genderValue == '') {
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
                        // onSaved: (value) {
                        //   setState(() {
                        //     enteredValues['Mobile Number'] = value!;
                        //   });
                        // },
                        validator: (_) {
                          if (int.parse(mobileController.text) < 1000000000 ||
                              int.parse(mobileController.text) >= 10000000000) {
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
                        // onSaved: (value) {
                        //   setState(() {
                        //     enteredValues['Email'] = value!;
                        //   });
                        // },
                        validator: (_) {
                          if (!EmailValidator.validate(
                              emailController.text, true)) {
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
                      // onSaved: (value) {
                      //   setState(() {
                      //     enteredValues['Profession'] = value.toString();
                      //   });
                      // },
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
                  _DoctorFile != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blueAccent)),
                            child: Text("Selected File: ${_DoctorFile!.name}"),
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
                    // onSaved: (value) {
                    //   setState(() {
                    //     enteredValues['CheckBox'] = value.toString();
                    //   });
                    // },
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

                            signup();

                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            //   enteredValues.forEach((key, value) {
                            //     print('$key = $value');
                            //   });
                            // }
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
                                      builder: (context) => loginPage()));
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
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']);

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
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']);

    if (file != null) {
      setState(() {
        _DoctorFile = null;
        _file = File(file.files.single.path!);
        _DistributerFile = file.files.first;
      });
    }
  }

  Future signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: password,
      );
      dataCheck();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => loginPage()));
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("Enter valid Account"),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 9, 9, 9),
      ));
      // Utils.showSnackBar(e.message);
    }
  }

  dataCheck() async {
    // send data to common table
    commonTable();
    // dataCheck()  {
    if (professionalValue == 'Doctor') {
      doctorData();
    } else if (professionalValue == 'Medical Distributer') {
      distributersData();
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
  }

  Future sendDatatoDistributer(Distributer distributer) async {
    final distributerValue = FirebaseFirestore.instance
        .collection('Medical_Distributers')
        .doc(nameController.text);
    final jsonDatas = distributer.toJson();
    await distributerValue.set(jsonDatas);
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
}

//class for Docotrs Distributers normal_users
// class for doctors

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
