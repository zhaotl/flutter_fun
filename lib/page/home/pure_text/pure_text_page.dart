import 'package:flutter/material.dart';
import 'package:fun_fluter/components/common_fun_item.dart';
import 'package:fun_fluter/page/home/pure_text/pure_text_controller.dart';
import 'package:fun_fluter/view_state/common/common_view_state_paging.dart';

class PureTextPage extends CommonViewStatePaging<PureTextController> {
  PureTextPage({super.key});

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
              index: index, item: items[index], funController: controller);
        });
  }
}
