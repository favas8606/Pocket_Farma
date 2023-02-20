// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future showNotification({
    int id = 6,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(id, title, body, await _notificationDetails(),
        payload: payload);
    print('completed 2');
    init();
  }

  static Future init({bool initScheduled = false}) async {
    const String navigationActionId = 'id_3';
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);
    try {
      await _notifications.initialize(settings,
          onDidReceiveNotificationResponse:
              (NotificationResponse notificationResponse) async {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            onNotification.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              onNotification.add(notificationResponse.payload);
            }
            break;
        }
      });
      print('complete 3');
    } catch (error) {
      print('error is $error');
    }

    // onNotification.add(payload);
  }

  static _notificationDetails() async {
    print(' complete 4');
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel Id 6',
        'channel Name',
        importance: Importance.max,
        enableVibration: true,
      ),
    );
  }
}
