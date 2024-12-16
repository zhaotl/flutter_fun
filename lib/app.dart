import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/default_refresh_indicator.dart';
import 'package:fun_fluter/page/index/index_binding.dart';
import 'package:fun_fluter/page/index/index_page.dart';
import 'package:fun_fluter/router/router_observer.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (context, child) => _defaultRefreshConfig(
        GetMaterialApp(
          showPerformanceOverlay: false, // 用于开发过程中的调试
          getPages: AppRoutes.routerPages,
          navigatorObservers: [AppRouterObserver()],
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 150),
          title: "FunFlutter",
          home: IndexPage(),
          initialBinding: IndexBinding(),
          locale: const Locale('zh'),
        ),
      ),
    );
  }

  RefreshConfiguration _defaultRefreshConfig(Widget child) {
    return RefreshConfiguration(
      headerBuilder: () => DefaultRefreshHeader(),
      footerBuilder: () => DefaultLoadFooter(),
      headerTriggerDistance: 180.w,
      maxOverScrollExtent: 100.w,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      enableBallisticLoad: true,
      footerTriggerDistance: 140.w,
      child: child,
    );
  }
}
