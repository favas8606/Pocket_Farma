// ignore_for_file: camel_case_types, file_names, no_leading_underscores_for_local_identifiers, avoid_print, unused_local_variable

import 'package:flutter/material.dart';

import 'package:pocket_farma/Screen/HomeScreen/homeScreen.dart';
import 'package:pocket_farma/login/login_page.dart';
import 'package:pocket_farma/main.dart';
import 'package:pocket_farma/navigation/NewData/DoctorsList.dart';
import 'package:pocket_farma/navigation/aboutus.dart';
import 'package:pocket_farma/navigation/reportProblem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  String? userProfession = '';

  @override
  void initState() {
    findTypeOfAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey.shade500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text('userImage'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const Text(
                      'UserName',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      emailValue,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14.0),
                    ),
                  ],
                )
              ],
            ),
          ),

          //Here you place your menu items

          const Divider(height: 3.0),
          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home Page', style: TextStyle(fontSize: 18)),
              onTap: () {
                homepage(context);
              },
            ),
          ),
          const Divider(height: 3),
          // if (userProfession == 'Medical Distributer')
          userProfession == "Medical Distributer"
              ? SizedBox(
                  child: ListTile(
                    leading: const Icon(Icons.new_releases),
                    title: const Text("New released Medicine",
                        style: TextStyle(fontSize: 18)),
                    onTap: () {
                      newMedicalData(context);
                    },
                  ),
                )
              : Container(),

          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.report_problem),
              title:
                  const Text('Report Problem', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                reportProblem(context);
              },
            ),
          ),

          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                aboutUs(context);
              },
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out', style: TextStyle(fontSize: 18)),
            onTap: () {
              // delete shared Priference
              signOut();
              // Here you can give your route to navigate
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const loginPage()),
                  (route) => false);
            },
          ),
          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Close', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                Navigator.of(context).pop();
              },
            ),
          ),

          const Divider(
            height: 3,
          ),
        ],
      ),
    );
  }

  void signOut() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.clear();
    print('sign out');
  }

  void findTypeOfAccount() async {
    final typeOfProfession = await SharedPreferences.getInstance();
    userProfession = typeOfProfession.getString('professionValue');
    print(userProfession);
    setState(() {
      userProfession;
    });
  }
}

void homepage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ScreenHome()));
}

void aboutUs(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const about_Us()));
}

void reportProblem(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const report_Problem()));
}

void newMedicalData(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ListOfDoctors()));
}
