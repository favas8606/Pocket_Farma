import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/login_page.dart';

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
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                  radius: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const <Widget>[
                    Text(
                      'UserName',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Username@gmail.com',
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
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: const Text('Theme', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Language', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: const Text('Report Problem', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.info),
            title: const Text('About Us', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Sign Out', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => loginPage()),
                  (route) => false);
            },
          ),

          ListTile(
            leading: Icon(Icons.close),
            title: const Text('Close Drawer', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
