import 'package:fun_fluter/page/home/home_controller.dart';
import 'package:fun_fluter/page/index/index_controller.dart';
import 'package:fun_fluter/page/search/search_page.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => HomeController());
  }
}
