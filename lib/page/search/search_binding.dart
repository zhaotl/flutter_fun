import 'package:fun_fluter/page/search/history/search_history_controller.dart';
import 'package:fun_fluter/page/search/hot/search_hot_key_controller.dart';
import 'package:fun_fluter/page/search/result/search_result_controller.dart';
import 'package:fun_fluter/page/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MySearchController());
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => SearchHotKeyController());
    Get.lazyPut(() => SearchResultController());
  }
}
