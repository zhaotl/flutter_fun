import 'package:flutter/material.dart';
import 'package:fun_fluter/components/keep_alive_wrapper.dart';
import 'package:fun_fluter/components/loading_dialog.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/home_tab_changed_event.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt index = 1.obs;
  late TabController tabController;

  final List<Widget> tabPages = [
    const KeepAliveWrapper(child: LoadingDialog()),
    const KeepAliveWrapper(child: Center(child: Text("Recommend"))),
    const KeepAliveWrapper(child: Center(child: Text("Fresh"))),
    const KeepAliveWrapper(child: Center(child: Text("Pure"))),
    const KeepAliveWrapper(child: Center(child: Text("FunPic")))
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
