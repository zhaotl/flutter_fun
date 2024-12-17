import 'package:flutter/material.dart';
import 'package:fun_fluter/ext/get_ext.dart';
import 'package:fun_fluter/http/exception/request_exception.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/utils/toast_util.dart';
import 'package:fun_fluter/view_state/view_state.dart';
import 'package:get/get.dart';

import '../router/routers.dart';

typedef CheckEmpty<T> = bool Function(T? value);
typedef CheckMoreData<T> = bool Function(T? value);
typedef Convert<T, R> = R Function(T? value);

abstract class ViewStateController extends GetxController {
  final Rx<ViewState> viewState = ViewState().obs;

  void loadData() {}

  void sendRequest<T>(Future<BaseResult<T>> sendRequestBlock,
      {bool bindViewState = true,
      bool showLoadingDialog = false,
      bool needLogin = false,
      bool emptyAsSuccess = false,
      CheckEmpty<BaseResult<T>>? checkEmpty,
      ValueChanged<T?>? onSuccess,
      VoidCallback? onEmpty,
      VoidCallback? onFail}) {
    // if (needLogin && !UserManager.instance.isLogin()) { // todo:
    if (needLogin) {
      AppRoutes.jumpToPage(AppRoutes.verifyCodeLoginPage);
      return;
    }

    if (bindViewState) {
      viewState.value = ViewStateLoading();
    }

    if (showLoadingDialog) {
      Get.showLoading();
    }

    sendRequestBlock.then((result) {
      if (result.isSuccess()) {
        if (showLoadingDialog) {
          Get.hideLoading();
        }
        bool isEmpty =
            checkEmpty != null ? checkEmpty(result) : result.isEmpty();
        if (!isEmpty || (emptyAsSuccess && isEmpty)) {
          if (bindViewState) {
            viewState.value = ViewStateSuccess(result.data);
          }
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        } else {
          if (bindViewState) {
            viewState.value = ViewStateEmpty();
          }
          if (onEmpty != null) {
            onEmpty();
          }
        }
      } else {
        if (bindViewState) {
          viewState.value =
              ViewStateFailed(errorCode: result.code, errorMessage: result.msg);
        }
        if (onFail != null) {
          onFail();
        }
        if (showLoadingDialog) {
          Get.hideLoading();
          showShortToast("${result.code}: ${result.msg}");
        }
      }
    }).catchError((e, staceTrace) {
      RequestException requestException = RequestException.create(e);
      if (bindViewState) {
        viewState.value = ViewStateError(
            errorCode: requestException.code,
            errorMessage: requestException.message);
      }
      if (showLoadingDialog) {
        Get.hideLoading();
        showToast("${requestException.code}: ${requestException.message}");
      }
      if (onFail != null) {
        onFail();
      }
    });
  }
}
