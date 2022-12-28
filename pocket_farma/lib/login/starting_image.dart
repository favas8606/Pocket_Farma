// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/Screen/homeScreen.dart';
import 'package:pocket_farma/login/login_page.dart';
import 'package:pocket_farma/login/verification.dart';

import 'package:shared_preferences/shared_preferences.dart';

class starting_Image extends StatefulWidget {
  const starting_Image({Key? key}) : super(key: key);

  @override
  State<starting_Image> createState() => _starting_imageState();
}

class _starting_imageState extends State<starting_Image> {
  @override
  void initState() {
    checkUserLogedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splashscreen.png'),
                fit: BoxFit.cover)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => loginPage()));
  }

  Future<void> checkUserLogedIn() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final _sharedprefs = await SharedPreferences.getInstance();
    final _userLogedIn = _sharedprefs.getBool(save_Key_Name);
    if (_userLogedIn == null || _userLogedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const ScreenHome()));
    }
  }
}
