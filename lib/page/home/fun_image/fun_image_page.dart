import 'package:flutter/material.dart';
import 'package:fun_fluter/components/common_fun_item.dart';
import 'package:fun_fluter/page/home/fun_image/fun_image_controller.dart';
import 'package:fun_fluter/view_state/common/common_view_state_paging.dart';

class FunImagePage extends CommonViewStatePaging<FunImageController> {
  FunImagePage({super.key});

  @override
  bool autoLoadData() {
    return true;
  }

  @override
  Widget buildPagingList() {
    var items = controller.dataList;
    return ListView.builder(
        cacheExtent: 0.0,
        physics: ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) => CommonFunItem(
            item: items[index], index: index, funController: controller));
  }
}
