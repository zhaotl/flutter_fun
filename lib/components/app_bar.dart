import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

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

PreferredSizeWidget? commonTitleBar({
  String leftIcon = "ic_back",
  String title = "",
  String? rightIcon,
  String? rightText,
  Widget? rightWidget,
  GestureTapCallback? leftClick,
  GestureTapCallback? rightClick,
  Color? contentColor,
  Color? backgroundColor,
}) {
  Widget? right;
  if (rightText != null || rightIcon != null) {
    right = Container(
      width: 160.w,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: rightClick,
        child: (rightIcon != null)
            ? Image.asset(rightIcon.webp, width: 40.w, height: 40.w)
            : Text(
                rightText!,
                style: TextStyle(
                  color: contentColor ?? ColorPalette.instance.firstText,
                  fontSize: 32.w,
                ),
              ),
      ),
    );
  } else {
    right = (rightWidget != null)
        ? GestureDetector(
            onTap: rightClick,
            child: Container(
                width: 160.w,
                alignment: Alignment.centerRight,
                child: rightWidget),
          )
        : Container(width: 160.w);
  }
  return PreferredSize(
      preferredSize: Size(double.infinity, 88.w),
      child: Container(
        height: 88.w,
        color: backgroundColor ?? Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32.w),
            Container(
              alignment: Alignment.centerLeft,
              width: 160.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: leftClick ?? Get.back,
                child: Image.asset(leftIcon.webp,
                    width: 40.w,
                    height: 40.w,
                    color: contentColor ?? ColorPalette.instance.firstIcon),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: contentColor ?? ColorPalette.instance.firstText,
                      fontSize: 36.w,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            right,
            SizedBox(width: 32.w),
          ],
        ),
      ));
}
