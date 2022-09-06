import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/homeScreen.dart';
import 'package:pocket_farma/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
              height: 250,
              color: Colors.blueAccent[700],
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Pocket Pharama',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
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
          // TextButton(
          //   onPressed: () {
          //     verification(context);
          //   },
          //   child: Text('verify account'),
          //   // child: const Padding(
          //   //   padding: EdgeInsets.all(8.0),
          //   //   child: Text(
          //   //     'Enter for the verification',
          //   //   ),
          //   // ),
          // ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: ElevatedButton(
                child: const Text('verify'),
                onPressed: () {
                  print(emailController.text);
                  verification(context);
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Does not have account?'),
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

  void checkLogedIn(BuildContext ctx) async {
    final _sharedprefs = await SharedPreferences.getInstance();
    await _sharedprefs.setBool(save_Key_Name, true);
  }
}

void verification(BuildContext ctx) {
  Navigator.of(ctx)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => const verify()));
}
