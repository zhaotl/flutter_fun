import 'package:flutter/material.dart';
import 'package:fun_fluter/components/common_fun_item.dart';
import 'package:fun_fluter/page/search/result/search_result_controller.dart';
import 'package:fun_fluter/view_state/common/common_view_state_paging.dart';

class SearchResultPage extends CommonViewStatePaging<SearchResultController> {
  SearchResultPage({super.key});

  @override
  bool autoLoadData() {
    return true;
  }

  @override
  Widget buildPagingList() {
    var items = controller.dataList;
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CommonFunItem(
            item: items[index],
            index: index,
            funController: controller,
            videoPlayHelper: controller,
          );
        });
  }

  @override
  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    controller.scrollNotificationCallback(scrollNotification);
  }
}
