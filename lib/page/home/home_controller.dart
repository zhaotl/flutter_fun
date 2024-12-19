import 'package:flutter/material.dart';
import 'package:fun_fluter/components/keep_alive_wrapper.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/home_tab_changed_event.dart';
import 'package:fun_fluter/page/home/follow/follow_page.dart';
import 'package:fun_fluter/page/home/fresh/fresh_page.dart';
import 'package:fun_fluter/page/home/fun_image/fun_image_page.dart';
import 'package:fun_fluter/page/home/pure_text/pure_text_page.dart';
import 'package:fun_fluter/page/home/recommend/recommend_page.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt index = 1.obs;
  late TabController tabController;

  final List<Widget> tabPages = [
    KeepAliveWrapper(child: FollowPage()),
    KeepAliveWrapper(child: RecommendPage()),
    KeepAliveWrapper(child: FreshPage()),
    KeepAliveWrapper(child: PureTextPage()),
    KeepAliveWrapper(child: FunImagePage())
  ];

  final List<String> tabs = ["关注", "推荐", "新鲜", "纯文", "趣图"];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: index.value);
    tabController.addListener(() {
      if (!tabController.indexIsChanging &&
          index.value != tabController.index) {
        index.value = tabController.index;
        eventBus.fire(HomeTabChangedEvent(index: index.value));
      }
    });
  }

  void jumpToPage(int index) {
    tabController.animateTo(index);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
