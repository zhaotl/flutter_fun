import 'package:flutter/material.dart';
import 'package:fun_fluter/components/common_fun_item.dart';
import 'package:fun_fluter/page/home/fresh/fresh_controller.dart';
import 'package:fun_fluter/view_state/common/common_view_state_paging.dart';

class FreshPage extends CommonViewStatePaging<FreshController> {
  FreshPage({super.key});

  @override
  bool autoLoadData() => true;

  @override
  Widget buildPagingList() {
    var items = controller.dataList;
    return ListView.builder(
        physics: ClampingScrollPhysics(),
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
