import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FireBaseOperations {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static bool isInit = false;
  static StreamSubscription? messageListenSubscription;

  static Future init() async {
    if (!isInit) {

      if (Platform.isIOS) {
        await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      }
      if (messageListenSubscription != null) {
        messageListenSubscription!.cancel();
      }
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('>>>>> notification message <<<<<: ');
        debugPrint('Message data: ${message.data}');

        if (message.data["type"] == "NEW_ORDER" ||
            message.data["type"] == "STATUS_UPDATED") {}
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification title: ${message.notification!.title}');
          debugPrint(
              'Message also contained a notification body: ${message.notification!.body}');
        }
      });
      messageListenSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('>>>>> notification message <<<<<: ');
        debugPrint('Message data: ${message.data}');
      });
      isInit = true;
    }
  }
}