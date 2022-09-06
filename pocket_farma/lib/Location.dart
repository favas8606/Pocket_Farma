import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Location_locate extends StatefulWidget {
  const Location_locate({Key? key}) : super(key: key);

  @override
  State<Location_locate> createState() => _Location_locateState();
}

class _Location_locateState extends State<Location_locate> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('Location'),
      ),
    );
  }
}
