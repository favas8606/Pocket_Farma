import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/Screen/homeScreen.dart';
import 'package:pocket_farma/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class verify extends StatefulWidget {
  const verify({Key? key}) : super(key: key);

  @override
  State<verify> createState() => _verifyState();
}

const save_Key_Name = 'userLogedIn';

class _verifyState extends State<verify> {
  bool _isResendAgain = false;

  late Timer _timer;
  int _start = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "Verification Code",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Enter the one time password for verification',
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) {
                              if (value.length == 1) {
                                return;
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Don't get code"),
                          TextButton(
                              onPressed: () {
                                if (_isResendAgain) return;
                                resend();
                              },
                              child: Text(
                                _isResendAgain
                                    ? "Try again in $_start"
                                    : "Resend",
                                style: const TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            emailController.clear;
                            storeData();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => const ScreenHome()));
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('verify')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;

          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  void storeData() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setBool(save_Key_Name, true);
  }
}
