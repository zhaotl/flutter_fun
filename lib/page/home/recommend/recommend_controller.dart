import 'package:fun_fluter/components/fun_video_play_helper_mixin.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/view_state/common/common_list_controller.dart';

class RecommendController extends CommonListController
    with FunVideoPlayHelperMixin {
  @override
  void onInit() {
    super.onInit();
    monitorVideoActive();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  bool checkVideoActive() {
    return AppRoutes.curPage.value == AppRoutes.indexPage &&
        indexPageIndex == 0 &&
        homePageIndex == 1;
  }

  @override
  Future<BaseResult<List<FunDetailEntity>>> requestFuture(String pageNum) {
    return HttpGo.instance.apiService.getRecommendList(pageNum);
  }
}
