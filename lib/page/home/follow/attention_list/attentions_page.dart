import 'package:flutter/material.dart';
import 'package:fun_fluter/components/common_fun_item.dart';
import 'package:fun_fluter/view_state/common/common_view_state_sliver.dart';

import 'attentions_controller.dart';

class AttentionsPage extends CommonViewStateSliver<AttentionsController> {
  AttentionsPage({super.key});

  @override
  bool lazyLoadData() => true;

  @override
  Widget buildSliverList() {
    var items = controller.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CommonFunItem(
          item: items[i],
          index: i,
          funController: controller,
          videoPlayHelper: controller),
    );
  }
}
