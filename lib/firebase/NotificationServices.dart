import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../about_page/view/about_page.dart';
import '../contact_us_page/view/contact_us_page.dart';
import '../facebook_auth/view/facebook_auth_screen.dart';
import '../google_auth/view/google_signin.dart';


class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // function to request notifications permissions
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission: ${settings.authorizationStatus}');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print(
            'User granted provisional permission: ${settings.authorizationStatus}');
      }
    } else {
      // AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          // handle interaction when app is active for android
          handleMessage(context, message);
        });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');

        print("notifications channel id:${message.notification!.android!.channelId}");
        print("notifications click action:${message.notification!.android!.clickAction}");
        print("notifications color:${message.notification!.android!.color}");
        print("notifications count:" +
            message.notification!.android!.count.toString());
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message,notification!.body);
      }
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message,var messageBody) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      styleInformation: BigTextStyleInformation(messageBody),
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    // if (message.data['type'] == 'msj') {
    //
    //   Get.to(SplashScreenPage());
    //
    // }



    String? type = message.data['type'];

    if (type == 'contact') {
      Get.to(() => ContactUsScreenPage());
    }

    if (type == 'about') {

      Get.to(() => AboutScreenPage(),
        arguments: {
          "item_id" : message.data['item_id'].toString(),
        },);

      Get.to(() => AboutScreenPage());
    }

    if (type == 'loginGoogle') {
      Get.to(() => GoogleSigninScreenPage());
    }


    if (message.data['type'] == 'facebook') {

      Get.to(FaceBookAuthScreenPage());

    }

    // if (message.data['type'] == 'msj') {
    //
    //   Get.to(FaceBookAuthScreenPage());
    //
    // }
  }


}
