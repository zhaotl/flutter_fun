import 'package:fun_fluter/page/index/index_binding.dart';
import 'package:fun_fluter/page/index/index_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static RxString curPage = indexPage.obs;
  static final perPage = Rxn<String>();

  static const indexPage = "/";
  static const publishPage = "/publish_page";

  static final routerPages = [
    GetPage(name: indexPage, page: () => IndexPage(), binding: IndexBinding())
  ];
}
