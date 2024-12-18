import 'dart:async';

import 'package:fun_fluter/event/attention_changed_event.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/recommend_user_entity.dart';
import 'package:fun_fluter/utils/toast_util.dart';
import 'package:fun_fluter/view_state/view_state_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/get_utils.dart';

class RecommendUserController extends ViewStateController {
  RxList<RecommendUserEntity> dataList = <RecommendUserEntity>[].obs;

  late StreamSubscription attentionChangeSubscription;

  @override
  void onInit() {
    super.onInit();
    attentionChangeSubscription =
        eventBus.on<AttentionChangedEvent>().listen((event) {
      var item = dataList.firstWhereOrNull(
          (element) => element.userId.toString() == event.userId);
      if (item != null) {
        item.isAttention = event.attention;
        dataList.refresh();
      }
    });
  }

  @override
  void loadData() {
    sendRequest(HttpGo.instance.apiService.getAttentionRecommendList(),
        onSuccess: (data) {
      dataList.clear();
      dataList.addAll(data);
    });
  }

  void attentionUser(int? userId, bool noAttention, int index) {
    sendRequest(
        HttpGo.instance.apiService
            .attentionUser(noAttention ? "1" : "0", "${userId ?? ""}"),
        bindViewState: false,
        showLoadingDialog: true,
        needLogin: true, onSuccess: (data) {
      showToast(noAttention ? "关注成功" : "取消关注成功");
      eventBus.fire(AttentionChangedEvent(
          userId: userId?.toString(), attention: noAttention));
    });
  }

  @override
  void onClose() {
    attentionChangeSubscription.cancel();
    super.onClose();
  }
}
