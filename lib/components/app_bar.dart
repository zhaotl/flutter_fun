import 'package:flutter/services.dart';
import 'package:fun_fluter/theme/color_palette.dart';

void updateStatusBarColor(Color color, bool iconDark) {
  var isDarkStyle = ColorPalette.instance.isDark();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarBrightness:
          (iconDark && !isDarkStyle) ? Brightness.dark : Brightness.light));
}
