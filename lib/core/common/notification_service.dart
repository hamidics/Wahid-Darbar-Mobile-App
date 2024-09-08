/*
 
 */

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialize() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );

    await _fcm.subscribeToTopic("all");

    await _fcm.setAutoInitEnabled(true);

    String token = await _fcm.getToken();

    await SharedPreferences.getInstance()
        .then((value) => value.setString('fcmToken', token));

    // print('token: $token');
  }
}
