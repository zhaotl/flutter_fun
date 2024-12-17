import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/view_state/view_state_controller.dart';
import 'package:get/get.dart';

class SearchHotKeyController extends ViewStateController {
  RxList<String> hotKeys = <String>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void loadData() {
    sendRequest(HttpGo.instance.apiService.getHotSearch(), onSuccess: (value) {
      if (value != null) {
        hotKeys.clear();
        hotKeys.addAll(value);
      }
    });
  }
}
