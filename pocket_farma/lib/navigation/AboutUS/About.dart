import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class About_US extends StatelessWidget {
  const About_US({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: const Center(
                child: Text(
              'POCKET PHARMA',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 110,
              width: 500,
              child: const Text(
                'Pocket Pharma brings to you an online platform, which can be accessed for all information about medicines and medical equipmenets We are trying to gives you to information about pharmacutical field.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            height: 20,
            width: 500,
            child: const Center(
                child: Text(
              'Our Work',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              width: 500,
              child: const Text(
                """
At Pocket Pharma We strongly bellive that we provide better experience and efficient time utlizing.Our App provides information about medical drug and medical equipments more efficiently .Also provide information about new medicine to doctors , We provide Location of medical store We hope POCKET PHARMA gives you better experience """,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
          ),
          const SizedBox(
              height: 30,
              child: Text(
                'POCKET PHARMA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 148, 153, 155),
                ),
              )),
        ],
      ),
    );
  }
}
