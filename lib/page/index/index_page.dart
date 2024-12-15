import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/page/index/index_controller.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IndexPage extends StatelessWidget {
  IndexPage({super.key});
  final List<BottomNavigationBarItem> bottomNavBarItems = [
    _customButtonNavigationBarItem("主页",
        defaultImage: "nav_home".png, activeImage: "nav_home".lottie),
    _customButtonNavigationBarItem("发现",
        defaultImage: "nav_discovery".png, activeImage: "nav_discovery".lottie),
    _customButtonNavigationBarItem("发布"),
    _customButtonNavigationBarItem("消息",
        defaultImage: "nav_message".png, activeImage: "nav_message".lottie),
    _customButtonNavigationBarItem("我的",
        defaultImage: "nav_mine".png, activeImage: "nav_mine".lottie)
  ];

  @override
  Widget build(Object context) {
    final indexController = Get.find<IndexController>();

    return Obx(() => Scaffold(
          body: PageView(
            controller: indexController.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: indexController.navPages,
          ),
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavBarItems,
            elevation: 8,
            backgroundColor: ColorPalette.instance.background,
            // backgroundColor: indexController.index.value != 2
            //     ? ColorPalette.instance.background
            //     : Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: indexController.index.value,
            fixedColor: ColorPalette.instance.primary,
            unselectedItemColor: ColorPalette.instance.secondText,
            onTap: (index) {
              indexController.navigate(index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // todo:
              // AppRoutes.jumpPage(AppRoutes.publishPage, needLogin: true);
            },
            backgroundColor: ColorPalette.instance.primary,
            elevation: 8,
            child: Image.asset("nav_push".png,
                width: 72.w, height: 72.w, color: Colors.white),
          ),
        ));
  }

  static BottomNavigationBarItem _customButtonNavigationBarItem(String label,
      {String? defaultImage, String? activeImage}) {
    return BottomNavigationBarItem(
        icon: defaultImage == null
            ? const Icon(null)
            : Image.asset(defaultImage,
                width: 44.w,
                height: 44.w,
                color: ColorPalette.instance.secondIcon),
        activeIcon: activeImage == null
            ? const Icon(null)
            : Obx(() => RepaintBoundary(
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        ColorPalette.instance.primary, BlendMode.srcIn),
                    child: Lottie.asset(activeImage,
                        repeat: false, width: 44.w, height: 44.w)))),
        label: label);
  }
}
