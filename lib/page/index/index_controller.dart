import 'package:flutter/material.dart';
import 'package:fun_fluter/components/app_bar.dart';
import 'package:fun_fluter/event/app_lifecycle_change_event.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/index_nav_changed_event.dart';
import 'package:get/get.dart';

class IndexController extends GetxController with WidgetsBindingObserver {
  RxInt index = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  final List<Widget> navPages = [
    // KeepAliveWrapper
    const Center(child: Text("Home")),
    const Center(child: Text("Discovery")),
    const Center(child: Text("Publish")),
    const Center(child: Text("Message")),
    const Center(child: Text("Mypage")),
  ];

  void navigate(int index) {
    this.index.value = index;
    pageController.jumpToPage(index);
    updateStatusBarColor(Colors.transparent, index != 2);
    eventBus.fire(IndexNavChangedEvent(index));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    eventBus.fire(AppLifecycleChangeEvent(state));
  }
}
