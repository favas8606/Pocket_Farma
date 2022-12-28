import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          height: 370,
          width: 360,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/Group8.png'))),
        ),
        const SizedBox(height: 8),
        const SizedBox(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Welcome to Pocket Pharma",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 12, 8, 8)),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            thickness: 1.5,
            endIndent: 90,
            color: Colors.black45,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "We are here to give you information of medical equpment , medicine. After the COVID-19 outbreak importence of medical software is part of our life. Pocket Pharma gives you information about medical equpment and medicine ,also provide location of medical store to a people of perticular area",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    ));
  }
}
