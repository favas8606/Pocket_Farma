import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/navigation/AboutUS/About.dart';

class about_Us extends StatelessWidget {
  const about_Us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 250,
              width: 450,
              child: Image.asset(
                'assets/Pocketpharma.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Divider(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => About_US()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                alignment: Alignment.centerLeft,
              ),
              child: const Text('About Us', style: TextStyle(fontSize: 20))),
        ),
        const Divider(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                //navigation
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                alignment: Alignment.centerLeft,
              ),
              child: const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20),
              )),
        ),
        const SizedBox(
          height: 50,
          width: double.infinity,
        ),
        const SizedBox(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text(
              "Pocket Pharma",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ),
      ]),
    );
  }
}
