// ignore_for_file: constant_identifier_names, camel_case_types, unused_field, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pocket_farma/Admin/AdminHomePage.dart';
import 'package:pocket_farma/Screen/HomeScreen/homeScreen.dart';
import 'package:pocket_farma/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_otp/email_otp.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class verify extends StatefulWidget {
  const verify({Key? key}) : super(key: key);

  @override
  State<verify> createState() => _verifyState();
}

const save_Key_Name = 'userLogedIn';

class _verifyState extends State<verify> {
  bool _isResendAgain = false;
  late final userProfession;
  String? emailForOtp;
  String? typeofuser;
  late Timer _timer;
  int _start = 60;
  String? OTP;

  @override
  void initState() {
    checkProfession();
    print(emailValue);

    super.initState();
  }

  OtpFieldController otpController = OtpFieldController();

  EmailOTP myauth = EmailOTP();
  sendotp() async {
    myauth.setConfig(
        appEmail: "pocketpharma22@gmail.com",
        appName: "Pocket Pharma",
        userEmail: emailForOtp,
        otpLength: 5,
        otpType: OTPType.digitsOnly);
    if (await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("OTP has been sent"),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Oops, OTP send failed"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: ListView(
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
                  child: OTPTextField(
                      controller: otpController,
                      length: 5,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      onChanged: (pin) {
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        setState(() {
                          OTP = pin;
                        });
                      }),
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
                            // emailController.clear;

                            validateOtp();
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
          sendotp();

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

  void validateOtp() async {
    if (await myauth.verifyOTP(otp: OTP) == true) {
      storeData();
      if (userProfession == 'Admin') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminHomePage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ScreenHome()));
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text("OTP is verified"),
        backgroundColor: Colors.green,
        margin: EdgeInsets.all(10),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text("Invalid OTP"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
      ));
    }
  }

  void checkProfession() async {
    final _sharedPrefsemail = await SharedPreferences.getInstance();
    emailForOtp = _sharedPrefsemail.getString('sharedemail');
    final typeofUser = await SharedPreferences.getInstance();
    typeofuser = typeofUser.getString('typeofuser');
    setState(() {
      typeofuser;
    });
    if (typeofuser != 'Admin') {
      final typeOfProfession = await SharedPreferences.getInstance();
      userProfession = typeOfProfession.getString('professionValue');
      setState(() {
        userProfession;
      });
    } else {
      setState(() {
        userProfession = "Admin";
      });
    }
    sendotp();
  }
}
