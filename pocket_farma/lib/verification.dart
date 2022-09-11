import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:pocket_farma/homeScreen.dart';

class Verificatoin extends StatefulWidget {
  const Verificatoin({Key? key}) : super(key: key);

  @override
  _VerificatoinState createState() => _VerificatoinState();
}

const save_Key_Name = 'userLogedIn';

class _VerificatoinState extends State<Verificatoin> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';

  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

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

  verify(ctx) {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });

    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const ScreenHome()));
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3) _currentIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/Pocketpharma.jpg',
                        ),
                        radius: 90,
                      ),
                    ),
                    Container(
                        child: const Text(
                      "Verification",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        "Please enter the OTP code send to your Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // Verification Code Input
                    Container(
                      child: VerificationCode(
                        length: 4,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        underlineColor: const Color.fromARGB(255, 70, 65, 65),
                        keyboardType: TextInputType.number,
                        underlineUnfocusedColor: Colors.black,
                        onCompleted: (value) {
                          setState(() {
                            _code = value;
                          });
                        },
                        onEditing: (value) {},
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't resive the OTP?",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                          TextButton(
                              onPressed: () {
                                if (_isResendAgain) return;
                                resend();
                              },
                              child: Text(
                                _isResendAgain
                                    ? "Try again in $_start"
                                    : "Resend",
                                style:
                                    const TextStyle(color: Colors.blueAccent),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: MaterialButton(
                        elevation: 0,
                        onPressed: _code.length < 4
                            ? () => {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(10),
                                    content: Text("code should be 4 number"),
                                  ))
                                }
                            : () {
                                verify(context);
                              },
                        color: Colors.orange.shade400,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: _isLoading
                            ? Container(
                                width: 20,
                                height: 20,
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 3,
                                  color: Colors.black,
                                ),
                              )
                            : _isVerified
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const Text(
                                    "Verify",
                                    style: TextStyle(color: Colors.white),
                                  ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
