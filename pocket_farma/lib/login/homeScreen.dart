import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/login/login_page.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Text('welcome to home page'),
    );
  }
}

// signout(BuildContext ctx) {
//   Navigator.of(ctx).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (ctx) => loginPage()), (route) => false);
// }