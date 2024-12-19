import 'package:flutter/material.dart';
import 'package:fun_fluter/components/default_view.dart';
import 'package:fun_fluter/components/no_over_scroll_behavior.dart';
import 'package:fun_fluter/view_state/view_state.dart';
import 'package:fun_fluter/view_state/view_state_paging_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class CommonViewStateSliver<T extends ViewStatePagingController>
    extends StatelessWidget {
  final bool enableRefresh;
  final bool enableLoadMore;

  final bool bindViewState;
  final String? tag;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  CommonViewStateSliver(
      {super.key,
      this.bindViewState = true,
      this.tag,
      this.enableLoadMore = true,
      this.enableRefresh = true});

  T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    preInit();
    if (!lazyLoadData()) {
      controller.loadData();
    }
    return Obx(() {
      ViewState viewState = controller.viewState.value;
      if (bindViewState) {
        if (viewState.isSuccess()) {
          return _buildSuccessContent();
        } else if (viewState.isEmpty()) {
          return buildCustomEmptyWidget() ??
              defaultSliverEmptyWidget(() {
                controller.loadData();
              });
        } else if (viewState.isFail()) {
          return buildCustomFailWidget() ??
              defaultSliverFailWidget(
                  viewState.errorCode, viewState.errorMessage, () {
                controller.loadData();
              });
        } else if (viewState.isError()) {
          return buildCustomErrorWidget() ??
              defaultSliverErrorWidget(
                  viewState.errorCode, viewState.errorMessage, () {
                controller.loadData();
              });
        } else if (viewState.isLoading()) {
          return buildCustomLoadingWidget() ?? defaultSliverLoadingWidget();
        } else {
          return buildCustomLoadingWidget() ?? defaultSliverLoadingWidget();
        }
      } else {
        return _buildSuccessContent();
      }
    });
  }

  Widget _buildSuccessContent() {
    return ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            scrollNotificationCallback(scrollNotification);
            return false;
          },
          child: SmartRefresher(
              controller: refreshController,
              enablePullDown: enableRefresh,
              enablePullUp: enableLoadMore,
              onRefresh: () {
                controller.refreshPaging();
              },
              onLoading: () {
                controller.loadMorePaging();
              },
              child: buildSliverList()),
        ));
  }

  void scrollNotificationCallback(ScrollNotification scrollNotification) {}

  Widget? buildCustomLoadingWidget() {
    return null;
  }

  Widget? buildCustomFailWidget() {
    return null;
  }

  Widget? buildCustomEmptyWidget() {
    return null;
  }

  Widget? buildCustomErrorWidget() {
    return null;
  }

  Widget buildSliverList();

  bool lazyLoadData() => false;

  void preInit() {
    controller.refreshController = refreshController;
  }
}
