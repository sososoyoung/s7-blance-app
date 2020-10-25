import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  _show(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  MyToast.success(String msg) {
    _show(msg, Colors.green[600]);
  }
  MyToast.info(String msg) {
    _show(msg, Colors.lightBlue[600]);
  }
  MyToast.error(String msg) {
    _show(msg, Colors.red[600]);
  }
  MyToast.warn(String msg) {
    _show(msg, Colors.yellow[600]);
  }
}

showTost(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Color(0XFF18CBFD),
      textColor: Colors.white,
      fontSize: 16.0);
}
