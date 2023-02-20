// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:pocket_farma/login/sign_up.dart';
import 'package:pocket_farma/login/verification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController emailController = TextEditingController();

  var newEmail;
  String? typeOfUser;
  String? mtoken;
  late final name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splashscreen.png'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(children: [
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: SweepGradient(colors: [
                      Color.fromARGB(255, 124, 124, 145),
                      Color.fromARGB(255, 127, 130, 158),
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black),
                            ),
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Choose Your Profession",
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 241, 236, 236),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black),
                              ),
                            ),
                            value: typeOfUser,
                            items: const [
                              DropdownMenuItem<String>(
                                  value: '', child: Text('-choose-')),
                              DropdownMenuItem<String>(
                                  value: 'Admin', child: Text('Admin')),
                              DropdownMenuItem<String>(
                                  value: 'Doctors', child: Text('Doctor')),
                              DropdownMenuItem<String>(
                                  value: 'Medical_Distributers',
                                  child: Text('medical distributer')),
                              DropdownMenuItem<String>(
                                  value: 'Users', child: Text('User')),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                typeOfUser = value;
                              });
                              // print(typeOfUser);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                            child: const Text('VERIFY'),
                            onPressed: () {
                              // print(emailController.text);

                              // verification(context);
                              checkExistingEmail(context);

                              show();
                              // tockenCreationForAddmin();
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, right: 10, left: 1),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Does not have account?',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                TextButton(
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    //signup screen
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const signUpPage()));
                                  },
                                )
                              ]))
                    ],
                  ),
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }

  void checkExistingEmail(BuildContext ctx) async {
    if (typeOfUser != null) {
      FirebaseFirestore.instance
          .collection(typeOfUser!)
          .where("Email", isEqualTo: emailController.text)
          .get()
          .then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> user = querySnapshot.docs[0].data();
          if (user["Email"] == emailController.text) {
            name = user['Name'];
            // ignore: no_leading_underscores_for_local_identifiers
            final _sharedPrefsemail = await SharedPreferences.getInstance();
            await _sharedPrefsemail.setString('sharedemail', user["Email"]);

            // setState(() {
            //   emailValue = user['Email'];
            // });
            SharedPreferences docName = await SharedPreferences.getInstance();
            await docName.setString('docname', name);
            if (typeOfUser != 'Admin') {
              SharedPreferences typeOfProfession =
                  await SharedPreferences.getInstance();
              await typeOfProfession.setString(
                  'professionValue', user['Profession']);
            }

            Navigator.of(ctx).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const verify()));
            return;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            content: Text("Enter valid Email"),
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 32, 32),
          ));
        }
      });
    }
  }

  void show() async {
    if (!EmailValidator.validate(emailController.text, true) ||
        emailController.text.length < 14) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("Enter Valid Email"),
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromARGB(255, 250, 103, 92),
      ));
    } else {
      final typeofUser = await SharedPreferences.getInstance();
      await typeofUser.setString('typeofuser', typeOfUser!);
    }
  }
}
