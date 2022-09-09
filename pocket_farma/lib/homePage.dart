import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/navBar.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: const Color.fromARGB(255, 111, 235, 235),
            child: Column(
              children: const [
                Center(
                    child: Text(
                  'Pocket Pharma',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Color(0xFFFFFFFF),
            height: 200,
            child: const Center(child: Text('data')),
          )
        ],
      ),
    );
  }
}
