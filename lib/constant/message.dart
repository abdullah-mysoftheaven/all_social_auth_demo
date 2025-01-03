import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Colors.dart';

void showToastMessageLong(String message)
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: appColor,
      textColor: Colors.white,
      fontSize: 16.0
  );
}