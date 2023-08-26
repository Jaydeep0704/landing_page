import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSnackbar({required String title, required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,

    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 15.0);
}
