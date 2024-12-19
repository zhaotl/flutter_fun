import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_fluter/components/fun_video_play_helper_mixin.dart';
import 'package:fun_fluter/components/keep_alive_wrapper.dart';
import 'package:fun_fluter/event/attention_changed_event.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/fun_comment_event.dart';
import 'package:fun_fluter/event/fun_like_event.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/page/fun_detail/comment/detail_comment.dart';
import 'package:fun_fluter/page/fun_detail/fun_detail_page.dart';
import 'package:fun_fluter/utils/toast_util.dart';
import 'package:fun_fluter/view_state/view_state_controller.dart';
import 'package:get/get.dart';

class FunDetailController extends ViewStateController
    with GetSingleTickerProviderStateMixin {
  final RxInt index = 0.obs;
  final RxList<String> tabs = <String>[].obs;
  final RxList<Widget> navPages = <Widget>[].obs;
  final String? tag;
  RxDouble expandedHeight = Get.height.obs;
  GlobalKey globalKey = GlobalKey();
  late Rx<FunDetailEntity> jokeDetailEntity;
  late StreamSubscription attentionChangeSub;
  late StreamSubscription likeActionSub;
  late StreamSubscription commentNumSub;
  FunVideoPlayHelperMixin? videoPlayHelper;

  FunDetailController({this.tag});

  late TabController tabController = TabController(
      initialIndex: index.value, vsync: this, length: tabs.length);

  @override
  void onInit() {
    super.onInit();
    FunDetailEntity entity = Get.arguments["FunDetailEntity"];
    jokeDetailEntity = entity.obs;
    videoPlayHelper = Get.arguments["videoPlayHelper"];
    tabs.value = ['评论', '点赞'];

    navPages.value = [
      KeepAliveWrapper(
          child: DetailComment(
              tag: tag,
              jokeId: jokeDetailEntity.value.joke?.jokesId ?? 0,
              totalCount: jokeDetailEntity.value.info?.commentNum ?? 0)),
      KeepAliveWrapper(child: Center(child: Text("点赞")))
      // JokeDetailLikePage(
      //     tag: tag, jokeId: jokeDetailEntity.value.joke?.jokesId ?? 0)),
    ];

    attentionChangeSub = eventBus.on<AttentionChangedEvent>().listen((event) {
      jokeDetailEntity.refresh();
    });
    likeActionSub = eventBus.on<FunLikeEvent>().listen((event) {
      jokeDetailEntity.refresh();
    });
    commentNumSub = eventBus.on<FunCommentEvent>().listen((event) {
      jokeDetailEntity.refresh();
    });
  }

  void jump2Page(int index) {
    tabController.animateTo(index);
  }

  void attentionUser(int? userId, bool noAttention) {
    sendRequest(
        HttpGo.instance.apiService
            .attentionUser(noAttention ? "1" : "0", "${userId ?? ""}"),
        bindViewState: false,
        needLogin: true,
        showLoadingDialog: true, onSuccess: (data) {
      showToast(noAttention ? "关注成功" : "取消关注成功");
      eventBus.fire(AttentionChangedEvent(
          userId: userId?.toString(), attention: noAttention));
    });
  }

  void likeJokeAction(int? jokesId, bool? isLike) {
    sendRequest(
        HttpGo.instance.apiService
            .likeJoke("${jokesId ?? ""}", "${isLike ?? false}"),
        bindViewState: false,
        needLogin: true,
        emptyAsSuccess: true,
        showLoadingDialog: true, onSuccess: (data) {
      eventBus.fire(FunLikeEvent(
          funId: jokesId, isLikeAction: true, value: isLike ?? false));
    });
  }

  void unlikeJokeAction(int? jokesId, bool? isUnLike) {
    sendRequest(
        HttpGo.instance.apiService
            .unlikeJoke("${jokesId ?? ""}", "${isUnLike ?? false}"),
        bindViewState: false,
        needLogin: true,
        emptyAsSuccess: true,
        showLoadingDialog: true, onSuccess: (data) {
      eventBus.fire(FunLikeEvent(
          funId: jokesId, isLikeAction: false, value: isUnLike ?? false));
    });
  }

  @override
  void onClose() {
    attentionChangeSub.cancel();
    likeActionSub.cancel();
    commentNumSub.cancel();
    super.onClose();
  }
}
