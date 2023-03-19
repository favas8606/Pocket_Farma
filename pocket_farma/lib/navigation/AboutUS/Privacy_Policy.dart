// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

class privacy_policy extends StatelessWidget {
  const privacy_policy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: ((context) => const about_Us())));
              Navigator.of(context).pop();
            }),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: const [
            Text(
              'PRIVACY POLICY',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ignore: prefer_interpolation_to_compose_strings
            Text(
                "Pocket Pharma takes the privacy of your information seriously.This privacy notice"
                "Privacy Notice"
                "describes the types of personal information we collect from you though our pocket pharma . It also describes the purposes for which we collect that personal information, the other parties with whom we may share it and the measures we take to protect the security of your data . It also tells you about your rights and choices with respect to your personal information, and how you can contact us about our privacy practices. "),
            Text(
                'you are advised to carefully read this privacy Notice before using or availing any of our product and / or services.'),
            Text(
              '1.DEFINITION',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
                'We only collect required information for identify the users and it should be secured.'),
            Text(
              'Data Protection Laws',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
                'any applicable law for the time being in force relating to the processing of Data.'),
            Text(
              'Partners',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
                'select third parties (including Pocket Pharma Group Entities) with whom we have contracts for the businesses described in this Privacy Notice.'),
            Text(
              'Users',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text('We provide 3 type servises and 3 type of users.'),
            Text(
              '2.WHAT DATA DO WE COLLECT ABOUT YOU',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'Pocket Pharma collects Data for various purposes set out in this Privacy Notice.This Data includes, without limitation, the following categories:'),
            Text(
              'Contact information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
                'name, email address, country, employer, phone number and other similar contact data.'),
            Text(
              'Technical information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
                'device and mobile app usage, Internet Protocol (IP) address and similar information collected via automated means, such as cookies and similar technologies.'),
            Text(
              'Personal information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text('Age,Sex,occupation'),
            Text(
              '3.HOW WE COLLECT DATA',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Personal information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
                'We receive and store any information you enter on Pocket Pharma or give us in any other way'),
            Text(
              '4.MINORS',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'Pocket Pharma do not offer services for use by minors. If you are under 18, you may use our website or mobile application only with the involvement of a parent or guardian.'),
            Text(
              '5.SHARING OF DATA',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'Partners,Entites,Service Providers,Information form other source,Business Transfers,'),
            Text(
              '6.SECURING DATA',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'We will use technical and organisational measures to safeguard your Data and we store your Data on secure servers. Technical and organisational measures include measures to deal with any suspected data breach. If you suspect any misuse or loss or unauthorised access to your Data, please let us know immediately by contacting us by e-mail at our email address provided at Clause 16 below.'),
            Text(
              '7.YOUR RIGHTS AND CHOICES',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'When we process Data about you, we do so with your consent and/or as necessary to operate our business, meet our contractual and legal obligations, protect the security of our systems and our customers, or fulfil other legitimate interests of Pocket Pharma as described in this Privacy Notice.'),
            Text(
              '8.HOW TO CONTACT US',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'To request to access, review, update, or withdraw your consent for your personal information or to otherwise reach us, please submit a request by e-mailing us at pocketpharma22@gmail.com . You may contact us for information on Service Providers, Partners and Tata Group Entities with whom we may share your Data in compliance with this Privacy Notice and applicable law. We will respond to your request within 30 days.')
          ],
        ),
      ),
    );
  }
}
