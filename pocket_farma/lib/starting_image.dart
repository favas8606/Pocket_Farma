import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/homeScreen.dart';
import 'package:pocket_farma/login_page.dart';
import 'package:pocket_farma/verification.dart';
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
      backgroundColor: Colors.green[200],
      body: Column(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8, top: 60, bottom: 30),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/Pocketpharma.jpg',
                ),
                radius: 120,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
            child: Text(
              'Pockrt Pharma',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 20));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => loginPage()));
  }

  Future<void> checkUserLogedIn() async {
    final _sharedprefs = await SharedPreferences.getInstance();
    final _userLogedIn = _sharedprefs.getBool(save_Key_Name);
    if (_userLogedIn == null || _userLogedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome()));
    }
  }
}
