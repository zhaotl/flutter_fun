import 'package:flutter/material.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/log/fun_log.dart';
import 'package:fun_fluter/view_state/view_state.dart';
import 'package:fun_fluter/view_state/view_state_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStatePagingController extends ViewStateController {
  int curPage = 1;
  int pageSize = 10;
  RefreshController? refreshController;

  void refreshPaging();

  void loadMorePaging();

  void sendRefreshPagingRequest<T>(Future<BaseResult<T>> sendRequest,
      {bool bindViewState = true,
      ValueChanged<T>? onSuccess,
      VoidCallback? onEmpty,
      VoidCallback? onFailed}) {
    sendRequest.then((result) {
      if (result.isSuccess()) {
        refreshController?.refreshCompleted();
        curPage = 1;
        if (result.isEmpty()) {
          if (bindViewState) {
            viewState.value = ViewStateEmpty();
          }
          if (onEmpty != null) onEmpty();
        } else {
          if (onSuccess != null) {
            onSuccess(result.data as T);
          }
        }
      } else {
        refreshController?.refreshFailed();
        if (onFailed != null) onFailed();
      }
    }).catchError((e) {
      refreshController?.refreshFailed();
      if (onFailed != null) onFailed();
    });
  }

  void sendLoadMorePagingRequest<T>(Future<BaseResult<T>> sendRequest,
      {bool bindViewState = true,
      CheckMoreData<BaseResult<T>>? onCheckMoreData,
      ValueChanged<T>? onSuccess,
      VoidCallback? onEmpty,
      VoidCallback? onFailed}) {
    sendRequest.then((result) {
      if (result.isSuccess()) {
        curPage++;
        if (result.isEmpty()) {
          refreshController?.loadNoData();
          if (onEmpty != null) onEmpty();
        } else {
          bool isNoMoreData = onCheckMoreData != null
              ? onCheckMoreData(result)
              : result.noMoreData(pageSize);
          if (isNoMoreData) {
            refreshController?.loadNoData();
          } else {
            refreshController?.loadComplete();
          }

          if (onSuccess != null && !result.isEmpty()) {
            onSuccess(result.data as T);
          }
        }
      } else {
        refreshController?.loadFailed();
        onFailed;
      }
    }).catchError((onError) {
      FunLog.e("error: $onError");
      refreshController?.loadFailed();
      onFailed;
    });
  }
}
