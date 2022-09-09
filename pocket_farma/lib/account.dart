import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:pocket_farma/login_page.dart';
import 'package:pocket_farma/navBar.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: navBar(),
      appBar: AppBar(),
      body: const Center(
        child: Text("profile page"),
      ),
    );
  }
}
