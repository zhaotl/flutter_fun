import 'package:flutter/material.dart';
import 'package:fun_fluter/components/no_over_scroll_behavior.dart';
import 'package:fun_fluter/view_state/common/common_view_state.dart';
import 'package:fun_fluter/view_state/view_state_paging_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class CommonViewStatePaging<T extends ViewStatePagingController>
    extends CommonViewState<T> {
  final bool enableRefresh;
  final bool enableLoadMore;

  CommonViewStatePaging(
      {super.key,
      super.tag,
      this.enableRefresh = true,
      this.enableLoadMore = true});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void preInit() {
    controller.refreshController = _refreshController;
  }

  @override
  Widget buildBody(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              scrollNotificationCallback(notification);
              return false;
            },
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown:
                  controller.viewState.value.isSuccess() && enableRefresh,
              enablePullUp:
                  controller.viewState.value.isSuccess() && enableLoadMore,
              onRefresh: () => controller.refreshPaging(),
              onLoading: () => controller.loadMorePaging(),
              child: buildPagingList(),
            )));
  }

  void scrollNotificationCallback(ScrollNotification scrollNotification);

  Widget buildPagingList();
}
