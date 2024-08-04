import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void statusMessage({
  required String message,
  required Color backgroundColor,
  Color? textColor = Colors.white,
  double? fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}
