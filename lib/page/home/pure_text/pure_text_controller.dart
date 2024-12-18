import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/view_state/common/common_list_controller.dart';

class PureTextController extends CommonListController {
  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  Future<BaseResult<List<FunDetailEntity>>> requestFuture(String pageNum) {
    return HttpGo.instance.apiService.getTextList(pageNum);
  }
}
