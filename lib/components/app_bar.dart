import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_fluter/theme/color_palette.dart';

void updateStatusBarColor(Color color, bool iconDark) {
  var isDarkStyle = ColorPalette.instance.isDark();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarBrightness:
          (iconDark && !isDarkStyle) ? Brightness.dark : Brightness.light));
}

AppBar commonAppBar(
    {Color statusBarColor = Colors.transparent,
    Color? backgroudColor,
    bool iconDark = true,
    PreferredSizeWidget? bottom}) {
  var isDarkStyle = ColorPalette.instance.isDark();
  return AppBar(
    elevation: 0,
    toolbarHeight: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: (iconDark == true && !isDarkStyle)
            ? Brightness.dark
            : Brightness.light),
    backgroundColor: backgroudColor ?? ColorPalette.instance.background,
    bottom: bottom,
  );
}
