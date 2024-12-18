import 'dart:async';

import 'package:fun_fluter/event/attention_changed_event.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/fun_comment_event.dart';
import 'package:fun_fluter/event/fun_like_event.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/utils/toast_util.dart';
import 'package:fun_fluter/view_state/view_state_paging_controller.dart';
import 'package:get/get.dart';

abstract class CommonListController extends ViewStatePagingController {
  RxList<FunDetailEntity> dataList = <FunDetailEntity>[].obs;
  late StreamSubscription attentionChangeSub;
  late StreamSubscription funLikeSub;
  late StreamSubscription funCommentSub;

  @override
  void onInit() {
    super.onInit();

    attentionChangeSub = eventBus.on<AttentionChangedEvent>().listen((event) {
      var item = dataList
          .firstWhereOrNull((e) => e.user?.userId.toString() == event.userId);
      if (item != null) {
        item.info?.isAttention = event.attention;
        dataList.refresh();
      }
    });

    funLikeSub = eventBus.on<FunLikeEvent>().listen((event) {
      var item =
          dataList.firstWhereOrNull((e) => e.joke?.jokesId == event.funId);
      if (item != null) {
        if (event.isLikeAction == true) {
          item.info?.isLike = event.value;
          item.info?.likeNum = (event.value)
              ? (item.info?.likeNum ?? 0) + 1
              : (item.info?.likeNum ?? 0) - 1;
        } else {
          item.info?.isUnlike = event.value;
          item.info?.disLikeNum = (event.value)
              ? (item.info?.disLikeNum ?? 0) + 1
              : (item.info?.disLikeNum ?? 0) - 1;
        }
        dataList.refresh();
      }
    });

    funCommentSub = eventBus.on<FunCommentEvent>().listen((event) {
      var item =
          dataList.firstWhereOrNull((e) => e.joke?.jokesId == event.funId);
      if (item != null) {
        item.info?.commentNum = event.totalNum;
        dataList.refresh();
      }
    });
  }

  Future<BaseResult<List<FunDetailEntity>>> requestFuture(String pageNum);

  @override
  void loadData() async {
    curPage = 1;
    sendRequest(requestFuture("$curPage"), onSuccess: (funs) {
      dataList.clear();
      dataList.addAll(funs);
    });
  }

  @override
  void refreshPaging() async {
    curPage = 1;
    sendRefreshPagingRequest(requestFuture("$curPage"), onSuccess: (funs) {
      dataList.clear();
      dataList.addAll(funs);
    });
  }

  @override
  void loadMorePaging() async {
    sendRefreshPagingRequest(requestFuture("${curPage + 1}"),
        onSuccess: (funs) {
      dataList.addAll(funs);
    });
  }

  void likeFun(int? jokeId, bool? isLike) {
    sendRequest(
        HttpGo.instance.apiService
            .likeJoke("${jokeId ?? ""}", "${isLike ?? false}"),
        bindViewState: false,
        needLogin: true,
        emptyAsSuccess: true,
        showLoadingDialog: true,
        onSuccess: (data) => eventBus.fire(FunLikeEvent(
            funId: jokeId, isLikeAction: true, value: isLike ?? false)));
  }

  void unLikeFun(int? jokeId, bool? isUnLike) {
    sendRequest(
        HttpGo.instance.apiService
            .unlikeJoke("${jokeId ?? ""}", "${isUnLike ?? false}"),
        bindViewState: false,
        needLogin: true,
        emptyAsSuccess: true,
        showLoadingDialog: true,
        onSuccess: (data) => eventBus.fire(FunLikeEvent(
            funId: jokeId, isLikeAction: true, value: isUnLike ?? false)));
  }

  void attentionUser(int? userId, bool noAttention) {
    sendRequest(
        HttpGo.instance.apiService
            .attentionUser(noAttention ? "1" : "0", "${userId ?? ""}"),
        bindViewState: false,
        needLogin: true,
        showLoadingDialog: true, onSuccess: (result) {
      showToast(noAttention ? "关注成功" : "取消关注成功");
      eventBus.fire(AttentionChangedEvent(
          userId: userId?.toString(), attention: noAttention));
    });
  }

  @override
  void onClose() {
    attentionChangeSub.cancel();
    funLikeSub.cancel();
    funCommentSub.cancel();
    super.onClose();
  }
}
