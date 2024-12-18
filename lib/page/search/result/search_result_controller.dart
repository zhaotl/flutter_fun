import 'package:fun_fluter/components/fun_video_play_helper_mixin.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/page/search/history/search_history_controller.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/view_state/common/common_list_controller.dart';
import 'package:get/get.dart';

class SearchResultController extends CommonListController
    with FunVideoPlayHelperMixin {
  String _key = "";
  final historyController = Get.find<HistoryController>();

  @override
  void onInit() {
    super.onInit();
    monitorVideoActive();
  }

  @override
  void onClose() {
    disposePlayer();
    super.onClose();
  }

  void updateKey(String key) {
    _key = key;
    dataList.clear();
    resetPlayList();
    if (_key.isNotEmpty) {
      loadData();
      historyController.add(key);
    }
  }

  @override
  Future<BaseResult<List<FunDetailEntity>>> requestFuture(String pageNum) {
    return HttpGo.instance.apiService.searchJokes(_key, pageNum);
  }

  @override
  bool checkVideoActive() {
    return AppRoutes.curPage.value == AppRoutes.searchPage;
  }
}
