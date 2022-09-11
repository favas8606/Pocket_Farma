import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/homeScreen.dart';
import 'package:pocket_farma/verification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

var emailController = TextEditingController();

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              height: 250,
              width: 450,
              child: Image.asset(
                'assets/Pocketpharma.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text('Does not have account?'),
              ),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //signup screen
                },
              )
            ],
          ),
        ],
      )),
    );
  }

  void verification(BuildContext ctx) async {
    if (!EmailValidator.validate(emailController.text, true)) {
      return null;
    } else {
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(save_Key_Name, true);
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const Verificatoin()));
    }
  }

  void show() {
    if (!EmailValidator.validate(emailController.text, true)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        content: Text("Enter Valid Form"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
