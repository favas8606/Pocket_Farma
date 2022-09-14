import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_farma/login/sign_up.dart';
import 'package:pocket_farma/login/verification.dart';
import 'package:email_validator/email_validator.dart';
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
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              height: 280,
              width: 450,
              child: Image.asset(
                'assets/PocketPharma.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: ElevatedButton(
                child: const Text('VERIFY'),
                onPressed: () {
                  print(emailController.text);
                  verification(context);
                  show();
                  emailController.clear();
                },
              )),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text('Does not have account?'),
                ),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const signUpPage()));
                  },
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  void verification(BuildContext ctx) async {
    if (!EmailValidator.validate(emailController.text, true)) {
      return null;
    } else {
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
        backgroundColor: Colors.red,
      ));
    }
  }
}
