import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:pocket_farma/homeScreen.dart';
import 'package:pocket_farma/login_page.dart';
import 'package:pocket_farma/navigation/aboutus.dart';
import 'package:pocket_farma/navigation/reportProblem.dart';
import 'package:pocket_farma/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
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
                Text('userImage'),
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
                      emailController.text,
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
          SizedBox(
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Theme', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Here you can give your route to navigate
              },
            ),
          ),
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

          const Divider(
            height: 3,
          ),

          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Sign Out', style: TextStyle(fontSize: 18)),
            onTap: () {
              // delete shared Priference
              signOut();
              // Here you can give your route to navigate
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => loginPage()),
                  (route) => false);
            },
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
}

void homepage(BuildContext ctx) {
  Navigator.of(ctx)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => const ScreenHome()));
}

void aboutUs(BuildContext ctx) {
  Navigator.of(ctx)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => const about_Us()));
}

void reportProblem(BuildContext ctx) {
  Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const report_Problem()));
}
