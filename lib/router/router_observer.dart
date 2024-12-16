import 'package:flutter/material.dart';
import 'package:fun_fluter/log/fun_log.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:get/get.dart';

class AppRouterObserver extends GetObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name != null &&
        route.settings.name?.isNotEmpty == true) {
      AppRoutes.prePage.value = route.settings.name;
    }

    if (previousRoute?.settings.name != null &&
        previousRoute?.settings.name?.isNotEmpty == true) {
      AppRoutes.curPage.value = previousRoute?.settings.name ?? "";
    }

    FunLog.d(
        "didPop: curPage = ${AppRoutes.curPage.value}, prePage = ${AppRoutes.prePage.value}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute?.settings.name != null &&
        previousRoute?.settings.name?.isNotEmpty == true) {
      AppRoutes.prePage.value = previousRoute?.settings.name!;
    }

    if (route.settings.name != null &&
        route.settings.name?.isNotEmpty == true) {
      AppRoutes.curPage.value = route.settings.name!;
    }

    FunLog.d(
        "didPush - curPage = ${AppRoutes.curPage.value}, prePage = ${AppRoutes.prePage.value}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    FunLog.d("didReplace - didReplace = $newRoute");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    FunLog.d("didRemove - disRemove = $route");
  }
}
