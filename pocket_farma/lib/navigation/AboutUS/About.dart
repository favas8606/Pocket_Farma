// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

class About_US extends StatelessWidget {
  const About_US({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: ((context) => const about_Us())));
            }),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(
                child: Text(
              'POCKET PHARMA',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              height: 120,
              width: 500,
              child: Text(
                'Pocket Pharma brings to you an online platform, which can be accessed for all information about medicines and medical equipmenets We are trying to gives you to information about pharmacutical field.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: 500,
            child: Center(
                child: Text(
              'Our Work',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              height: 130,
              width: 500,
              child: Text(
                """
At Pocket Pharma We strongly bellive that we provide better experience and efficient time utlizing.Our App provides information about medical drug and medical equipments more efficiently .Also provide information about new medicine to doctors , We provide Location of medical store We hope POCKET PHARMA gives you better experience """,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
          ),
          SizedBox(
              height: 70,
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
