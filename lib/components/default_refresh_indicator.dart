import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DefaultRefreshHeader extends RefreshIndicator {
  DefaultRefreshHeader({super.key})
      : super(height: 180.w, refreshStyle: RefreshStyle.Follow);

  @override
  State<StatefulWidget> createState() {
    return _DefaultRefreshHeader();
  }
}

class _DefaultRefreshHeader
    extends RefreshIndicatorState<DefaultRefreshHeader> {
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    Widget textWidget;
    Widget? imageWidget;
    switch (mode) {
      case RefreshStatus.canRefresh:
        textWidget = Text("松开后更新",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
        imageWidget = ColorFiltered(
          colorFilter: ColorFilter.mode(
              ColorPalette.instance.secondary, BlendMode.srcIn),
          child: Lottie.asset("view_loading".lottie,
              width: 120.w, height: 120.w, animate: false),
        );
        break;

      case RefreshStatus.refreshing:
        textWidget = Text("刷新中...",
            style: TextStyle(
                color: ColorPalette.instance.secondary, fontSize: 28.w));
        imageWidget = ColorFiltered(
            colorFilter: ColorFilter.mode(
              ColorPalette.instance.secondary,
              BlendMode.srcIn,
            ),
            child: Lottie.asset("view_loading".lottie,
                width: 120.w, height: 120.w));
        break;
      case RefreshStatus.completed:
        textWidget = Text("刷新成功",
            style: TextStyle(
                color: ColorPalette.instance.secondary, fontSize: 28.w));
        break;
      case RefreshStatus.failed:
        textWidget = Text("刷新失败",
            style: TextStyle(
                color: ColorPalette.instance.secondary, fontSize: 28.w));
        break;
      default:
        textWidget = Text("下拉刷新",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
        imageWidget = ColorFiltered(
          colorFilter: ColorFilter.mode(
              ColorPalette.instance.secondary, BlendMode.srcIn),
          child: Lottie.asset("view_loading".lottie,
              width: 120.w, height: 120.w, animate: false),
        );
        break;
    }

    return Obx(() => Container(
          color: ColorPalette.instance.background,
          width: double.infinity,
          height: 180.w,
          alignment: Alignment.center,
          child: Row(
            children: [
              imageWidget ?? SizedBox(width: 120.w, height: 120.w),
              textWidget,
              SizedBox(height: 120.w, width: 120.w)
            ],
          ),
        ));
  }
}

class DefaultLoadFooter extends LoadIndicator {
  DefaultLoadFooter({super.key})
      : super(height: 140.w, loadStyle: LoadStyle.ShowAlways);

  @override
  State<StatefulWidget> createState() => _DefaultLoadFooter();
}

class _DefaultLoadFooter extends LoadIndicatorState<DefaultLoadFooter> {
  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    Widget textWidget;
    Widget? imageWidget;

    switch (mode) {
      case LoadStatus.loading:
        textWidget = Text("加载中...",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
        imageWidget = ColorFiltered(
          colorFilter: ColorFilter.mode(
              ColorPalette.instance.secondary, BlendMode.srcIn),
          child:
              Lottie.asset("view_loading".lottie, width: 120.w, height: 120.w),
        );
      case LoadStatus.idle:
        textWidget = Text("加载成功",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
      case LoadStatus.canLoading:
        textWidget = Text("松开加载更多",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
        imageWidget = ColorFiltered(
            colorFilter: ColorFilter.mode(
                ColorPalette.instance.secondary, BlendMode.srcIn),
            child: Lottie.asset("view_loading".lottie,
                width: 120.w, height: 120.w, animate: false));
      case LoadStatus.noMore:
        textWidget = Text("暂无更多数据",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
      case LoadStatus.failed:
        textWidget = Text("加载失败",
            style: TextStyle(
                color: ColorPalette.instance.secondText, fontSize: 28.w));
    }

    return Obx(() => Container(
          color: ColorPalette.instance.background,
          width: double.infinity,
          height: 140.w,
          alignment: Alignment.center,
          child: Row(
            children: [
              imageWidget ?? SizedBox(width: 120.w),
              textWidget,
              SizedBox(width: 120.w)
            ],
          ),
        ));
  }

  @override
  Future endLoading() {
    return Future.delayed(const Duration(microseconds: 500));
  }
}
