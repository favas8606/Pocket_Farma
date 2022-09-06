import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

List objects = ['profile', 'About us', 'Report', 'Sign out'];

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
            itemBuilder: (ctx, index) {
              return ListTile(
                title: objects[index],
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider();
            },
            itemCount: objects.length));
  }
}
