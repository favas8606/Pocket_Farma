import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/login/sign_up.dart';
import 'package:pocket_farma/login/verification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pocket_farma/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

TextEditingController emailController = TextEditingController();

class _loginPageState extends State<loginPage> {
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
              child: Column(),
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
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                            child: const Text('VERIFY'),
                            onPressed: () {
                              print(emailController.text);

                              verification(context);

                              show();
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
                                    style: TextStyle(fontSize: 15),
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
                                    Navigator.of(context).pushReplacement(
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

  void verification(BuildContext ctx) async {
    if (!EmailValidator.validate(emailController.text, true) ||
        emailController.text.length < 14) {
      return null;
    } else {
      emailValue = emailController.text;

      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => const verify()));
    }
  }

  void show() {
    if (!EmailValidator.validate(emailController.text, true) ||
        emailController.text.length < 14) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("Enter Valid Form"),
        backgroundColor: Color.fromARGB(255, 250, 103, 92),
      ));
      emailController.clear();
    } else {
      emailController.clear();
    }
  }
}
