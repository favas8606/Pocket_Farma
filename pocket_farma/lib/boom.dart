// // ignore_for_file: non_constant_identifier_names, avoid_print, camel_case_types

// ignore_for_file: avoid_print, camel_case_types

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class notificationtesting extends StatefulWidget {
  const notificationtesting({Key? key}) : super(key: key);

  @override
  State<notificationtesting> createState() => _notificationtestingState();
}

class _notificationtestingState extends State<notificationtesting> {
  @override
  void initState() {
    super.initState();
    requstToPermission();
    getToken();
  }

  String? token;

  final title = 'Hello Pocket Pharma';
  final body = 'New Dr  is joined verify his documnet';
  Map<String, dynamic>? userToken = {
    "token": "",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        child: const Text("send"),
        onPressed: () {
          print(token);
        },
      ),
    ));
  }

  void sendPushMessageForDoctor(token, body, title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'content-Type': 'application/json',
          'Authorization':
              'key=AAAA2y32B8M:APA91bGbFoUxPxbm2dWCBjL9id7egX2_SEUi32N73Y1MJZpoIqZ4Uk1To8A0k6zWq4le1yi1AOJgNXPalMxaeHm4hP7w4Nj8mTLPjkQD_FuMuU_CECzERUlLllkX8ikO1kpVJ_KSbG-P',
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': 'hello',
            'title': 'title',
          },
          "notification": <String, dynamic>{
            'title': title,
            'body': body,
            'android_channel_id': 'dbfood',
          },
          'to': token,
        }),
      );
    } catch (error) {
      print(error);
    }
  }

  void requstToPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user greanted provisionl permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user greanted provisionl permission');
    } else {
      print('user declined ');
    }
  }

  void getToken() async {
    await FirebaseFirestore.instance
        .collection('AdminToken')
        .doc('AdminDevice')
        .get()
        .then((snapShort) {
      if (snapShort.data()!.isNotEmpty) {
        setState(() {
          token = userToken!['Token'];
        });
      }
    });
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: ElevatedButton(
//                 child: const Text("Notification"),
//                 onPressed: () async {
//                   NotificationSettingsDone();
//                   listenNotification();
//                 },
//               ),
//             )
//           ]),
//     );
//   }

//   NotificationSettingsDone() async {
//     NotificationApi.showNotification(
//       title: 'Hello user',
//       body:
//           ' Youer Account for pocket pharma  is sucssessfully registered , you can login now ',
//     );
//     print("complete 1");
//   }

//   void listenNotification() async {
//     print('complete 5');

//     NotificationApi.onNotification.stream.listen((String? payload) {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => const loginPage()));
//     });
//   }
// }

