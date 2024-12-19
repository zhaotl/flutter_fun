import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/fun_comment_event.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/http/models/fun_comment_entity.dart';
import 'package:fun_fluter/view_state/common/simple_view_state_paging_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FunCommentsController extends SimpleViewStatePagingController {
  int jokesId = 0;
  TextEditingController textEditingController = TextEditingController();
  RxBool isInputValid = false.obs;
  RxString commentInput = "".obs;
  RxInt totalNum = 0.obs;
  int? replyCommentId;
  bool isReplyChild = false;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  Future<BaseResult<FunCommentEntity>> requestFuture(String pageNum) {
    return HttpGo.instance.apiService
        .getJokeCommentList(jokesId.toString(), pageNum);
  }

  @override
  bool checkEmpty(BaseResult result) {
    return (result.data as FunCommentEntity).comments?.isEmpty ?? true;
  }

  @override
  bool checkNoMoreData(BaseResult result) {
    return ((result.data as FunCommentEntity).comments?.length ?? 0) < pageSize;
  }

  @override
  List convertResult(originResult) {
    return (originResult as FunCommentEntity).comments ?? [];
  }

  void deleteComment(FunCommentComments comment) {
    sendRequest(
      HttpGo.instance.apiService.deleteJokeComment(
        comment.commentId.toString(),
      ),
      emptyAsSuccess: true,
      showLoadingDialog: true,
      bindViewState: false,
      onSuccess: (value) {
        dataList.remove(comment);
        totalNum.value = totalNum.value - 1 - (comment.itemCommentNum ?? 0);
        eventBus.fire(FunCommentEvent(totalNum.value, jokesId));
        dataList.refresh();
      },
    );
  }

  void likeComment(FunCommentComments item) {
    bool isLike = item.isLike ?? false;
    sendRequest(
        HttpGo.instance.apiService
            .likeJokeComment(item.commentId.toString(), "${!isLike}"),
        bindViewState: false,
        emptyAsSuccess: true,
        showLoadingDialog: true, onSuccess: (value) {
      item.isLike = !isLike;
      if (!isLike) {
        // 点赞操作
        item.likeNum = (item.likeNum ?? 0) + 1;
      } else {
        item.likeNum = min((item.likeNum ?? 0) - 1, 0);
      }
      dataList.refresh();
    });
  }
}
