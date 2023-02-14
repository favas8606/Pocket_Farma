// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:pocket_farma/Admin/deleteUser.dart';
import 'package:pocket_farma/login/login_page.dart';
import 'package:pocket_farma/sendData/SendData.dart';
import 'package:pocket_farma/sendData/sendDatatoEqupment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationBarForAdmin extends StatefulWidget {
  const NavigationBarForAdmin({Key? key}) : super(key: key);

  @override
  State<NavigationBarForAdmin> createState() => _NavigationBarForAdminState();
}

class _NavigationBarForAdminState extends State<NavigationBarForAdmin> {
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
                // const Text('Welcome to pocket pharma'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const <Widget>[
                    Text(
                      'Pocket Pharma',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'pocketpharma22@gmail.com',
                      style: TextStyle(
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
              leading: const Icon(Icons.new_label),
              title:
                  const Text('Add Medicines', style: TextStyle(fontSize: 18)),
              onTap: () {
                addMedicine(context);
              },
            ),
          ),
          const Divider(height: 3),

          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.new_label),
              title:
                  const Text('Add Equipments', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                addEquipment(context);
              },
            ),
          ),
          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.domain_verification),
              title: const Text('Document Storage',
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                gotoVerifiyDoctorsAndDistributers(context);
              },
            ),
          ),
          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.storage_outlined),
              title:
                  const Text('Goto Database', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                gotoDatabase(context);
              },
            ),
          ),
          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.storage_outlined),
              title: const Text('Delete User', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
                deleteUser(context);
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
    final _sharedPrefsemail = await SharedPreferences.getInstance();
    _sharedPrefsemail.clear();

    print('sign out');
  }
}

void addMedicine(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SendDataToDB()));
}

void addEquipment(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const datatoEqupment()));
}

void deleteUser(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const DeleteUser()));
}

void gotoVerifiyDoctorsAndDistributers(BuildContext context) async {
  final Uri urlLink = Uri.parse(
      'https://console.firebase.google.com/u/0/project/pocketpharmaproject/storage/pocketpharmaproject.appspot.com/files');
  if (!await canLaunchUrl(urlLink)) {
    throw Exception("could not launch $urlLink");
  } else {
    await launchUrl(urlLink);
  }
}

void gotoDatabase(BuildContext context) async {
  final Uri urlLink = Uri.parse(
      'https://console.firebase.google.com/u/0/project/pocketpharmaproject/firestore/data/~2F');
  if (!await canLaunchUrl(urlLink)) {
    throw Exception("could not launch $urlLink");
  } else {
    await launchUrl(urlLink);
  }
}
