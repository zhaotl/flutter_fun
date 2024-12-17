import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String msg, {
  Toast length = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int timeInSecForIos = 1,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos);
}

void showShortToast(String msg) => showToast(msg, length: Toast.LENGTH_SHORT);

void showLongToast(String msg) => showToast(msg, length: Toast.LENGTH_LONG);
