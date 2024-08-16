import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app_name/PushNotification/notifcation_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> handleMessageBackground(RemoteMessage? message) async {
  if (message == null) return;

  print("Received the message on background");

  navigatorKey.currentState?.pushNamed("/message", arguments: message);
}

class NotificationServiceFirebase {
  Future<void> initNotificationFirebase() async {
    final firebasemessaging = FirebaseMessaging.instance;
    await firebasemessaging.requestPermission();
    try {
      final FCM_Token =
          await firebasemessaging.getToken().timeout(Duration(seconds: 2));
      print("fcm token is $FCM_Token");
      await FirebaseMessaging.instance.subscribeToTopic("updates");

      // await DatabaseWriteService().updateUserFCM(
      //     FirebaseAuth.instance.currentUser!.uid.toString(),
      //     FCM_Token.toString());
    } catch (e) {
      print("Couldn't subscribe to the topic");
    }
    //

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      print("Got init msg");
      handleMessage(msg);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print("Recieved msg while app in on");
      handleMessage(msg);
      NotificationService().showNotificationBasic(
          id: 0,
          title: msg.notification?.title ?? "",
          body: msg.notification?.body ?? "",
          payLoad: jsonEncode(msg.data));
    });

    FirebaseMessaging.onMessage.listen((msg) {
      print("Recived msg here");
      NotificationService().showNotificationBasic(
          id: 0,
          title: msg.notification?.title ?? "",
          body: msg.notification?.body ?? "",
          payLoad: jsonEncode(msg.data));
    });

    FirebaseMessaging.onBackgroundMessage((message) {
      print("This works");
      return handleMessageBackground(message);
    });
  }

  void handleMessage(RemoteMessage? message) {
    print("Received the message");
    if (message == null) return;
    navigatorKey.currentState?.pushNamed("/message", arguments: message);
  }
}
