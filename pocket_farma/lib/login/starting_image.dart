// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_farma/Admin/AdminHomePage.dart';

import 'package:pocket_farma/Screen/HomeScreen/homeScreen.dart';
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const loginPage()));
  }

  Future<void> checkUserLogedIn() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final _sharedprefs = await SharedPreferences.getInstance();
    final _userLogedIn = _sharedprefs.getBool(save_Key_Name);
    if (_userLogedIn == null || _userLogedIn == false) {
      gotoLogin();
    } else {
      final _sharedPrefsemail = await SharedPreferences.getInstance();
      final String? sharedEmail = _sharedPrefsemail.getString('sharedemail');
      setState(() {
        sharedEmail;
      });

      await FirebaseFirestore.instance
          .collection('Accounts')
          .where("Email", isEqualTo: sharedEmail)
          .get()
          .then((querySnapshort) async {
        if (querySnapshort.docs.isNotEmpty) {
          Map<String, dynamic> user = querySnapshort.docs[0].data();
          print(user['Email']);
          if (user['Email'] == sharedEmail) {
            if (sharedEmail != 'pocketpharma22@gmail.com') {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ScreenHome()));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AdminHomePage()));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                "Your Account is removed from Pocket pharma",
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
              duration: Duration(seconds: 3),
            ));
            gotoLogin();

            final _sharedPrefs = await SharedPreferences.getInstance();
            _sharedPrefs.clear();
          }
        } else {
          gotoLogin();
        }
      });

      print(sharedEmail);
    }
  }
}
