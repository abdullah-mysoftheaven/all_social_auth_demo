import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/Colors.dart';
// import 'package:get_storage/get_storage.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

class FCM {
  // final localStorage = GetStorage();

  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
          (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
    // With this token you can test it easily on your phone
    // final token = _firebaseMessaging.getToken().then((value) => print('Token: $value'));
    final token = _firebaseMessaging.getToken().then((value) {
      print('FirebaseMessagingToken Token: $value');
      log('FirebaseMessagingToken Token: $value');
      saveFirebaseMessagingToken(token: value.toString());
    });
  }

  Future<void> saveFirebaseMessagingToken({
    required String token,
  }) async {
    var FirebaseMessagingToken = {
      'token': token ?? "",
    };

    showMessage(token);

    // try {
    //   localStorage.write('firebaseMessagingToken1', token);
    // } finally {}
    //
    // try {
    //   localStorage.write('firebaseMessagingToken', jsonEncode(FirebaseMessagingToken));
    // } finally {}

    // String savedData = localStorage.read('USER_TOKEN');
    // print("LocalStorage :" + savedData);
    print("saved FirebaseMessagingToken ");
    log("saved FirebaseMessagingToken ");
  }

  void showMessage(var messahe){
    Fluttertoast.showToast(
        msg: messahe,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: appColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}