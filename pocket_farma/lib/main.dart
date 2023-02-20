// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pocket_farma/Admin/AdminHomePage.dart';
import 'package:pocket_farma/Admin/deleteUser.dart';
import 'package:pocket_farma/Screen/Location/LocationPage.dart';
import 'package:pocket_farma/Screen/Location/Map.dart';
import 'package:pocket_farma/Screen/homePage.dart';
import 'package:pocket_farma/boom.dart';

import 'package:pocket_farma/firebase_options.dart';
import 'package:pocket_farma/login/sign_up.dart';
import 'package:pocket_farma/login/starting_image.dart';
import 'package:pocket_farma/navigation/navBar.dart';

const Save_Key_Name = 'userLogedIn';
var emailValue = '';
var setData = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Location_locate(),
    );
  }
}
