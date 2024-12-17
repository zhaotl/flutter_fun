import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/http/exception/request_exception.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Widget defaultFailWidget(
    int? errorCode, String? errorMsg, VoidCallback onRetry) {
  return Obx(() => InkWell(
        onTap: () => onRetry(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "ic_view_fail".webp,
                width: 180.w,
                height: 180.w,
                color: ColorPalette.instance.secondIcon,
              ),
              SizedBox(height: 8),
              Text(
                "${errorMsg ?? "未知错误"}, 请重试",
                style: TextStyle(
                    color: ColorPalette.instance.thirdText, fontSize: 26.w),
              )
            ],
          ),
        ),
      ));
}

Widget defaultErrorWidget(
    int? errorCode, String? errorMsg, VoidCallback onRetry) {
  return Obx(() => InkWell(
        onTap: () => onRetry(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                errorCode == RequestException.netWorkError
                    ? "ic_view_network_error".webp
                    : "ic_view_fail".webp,
                width: 180.w,
                height: 180.w,
                color: ColorPalette.instance.secondIcon,
              ),
              SizedBox(height: 8),
              Text(
                "${errorMsg ?? "未知错误"}, 请重试",
                style: TextStyle(
                    color: ColorPalette.instance.thirdText, fontSize: 26.w),
              )
            ],
          ),
        ),
      ));
}

Widget defaultEmptyWidget(VoidCallback onRetry) {
  return Obx(() {
    return InkWell(
      onTap: () => onRetry(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "ic_view_empty".webp,
              width: 120.w,
              height: 120.w,
            ),
            Text(
              "暂无数据，点击刷新",
              style: TextStyle(
                color: ColorPalette.instance.thirdText,
                fontSize: 26.w,
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget defaultLoadingWidget() {
  return Obx(() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFiltered(
              colorFilter: ColorFilter.mode(
                ColorPalette.instance.secondary,
                BlendMode.srcIn,
              ),
              child: Lottie.asset("view_loading".lottie,
                  width: 256.w, height: 256.w)),
          Text(
            "加载中...",
            style: TextStyle(
                fontSize: 26.w, color: ColorPalette.instance.thirdText),
          )
        ],
      ),
    );
  });
}
