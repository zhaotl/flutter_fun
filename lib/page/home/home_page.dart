import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/app_bar.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/page/home/home_controller.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: commonAppBar(
            backgroudColor: ColorPalette.instance.pure,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 100.w),
              child: _topBar(),
            ),
          ),
          backgroundColor: ColorPalette.instance.background,
          body: TabBarView(
            controller: _homeController.tabController,
            children: _homeController.tabPages,
          ),
        ));
  }

  Widget _topBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _tabBar()),
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
            child: Hero(
              tag: "ic_search",
              child: Image.asset("ic_search".webp,
                  width: 40.w,
                  height: 40.w,
                  color: ColorPalette.instance.firstIcon),
            ),
          ),
          onTap: () {
            AppRoutes.jumpToPage(AppRoutes.searchPage);
          },
        )
      ],
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: _homeController.tabController, // todo:
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: false,
      indicatorColor: Colors.transparent,
      labelPadding: const EdgeInsets.all(0),
      labelColor: ColorPalette.instance.primary,
      unselectedLabelColor: ColorPalette.instance.secondary,
      labelStyle: TextStyle(fontSize: 36.w, fontWeight: FontWeight.bold),
      onTap: (index) {
        _homeController.jumpToPage(index);
      },
      tabs: _homeController.tabs
          .map((e) => Container(
                height: 72.w,
                alignment: Alignment.center,
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    );
  }
}
