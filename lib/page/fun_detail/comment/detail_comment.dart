import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/common_comment_item.dart';
import 'package:fun_fluter/page/fun_detail/comment/comments_controller.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:fun_fluter/view_state/common/common_view_state_sliver.dart';
import 'package:get/get.dart';

class DetailComment extends StatelessWidget {
  final int jokeId;
  final String? tag;
  final int totalCount;

  const DetailComment(
      {super.key, required this.jokeId, this.tag, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    FunCommentsController commentsController =
        GetInstance().find<FunCommentsController>(tag: tag);
    commentsController.totalNum.value = totalCount;
    return Column(
      children: [
        Expanded(
            child: _DetailCommontList(
          jokeId: jokeId,
          tag: tag,
        )),
        Container(color: ColorPalette.instance.divider, height: 2.w),
        // cpnPostJokeComment(commentsController)
      ],
    );
  }
}

class _DetailCommontList extends CommonViewStateSliver<FunCommentsController> {
  final int jokeId;

  _DetailCommontList({super.tag, required this.jokeId})
      : super(enableRefresh: false);

  @override
  void preInit() {
    super.preInit();
    controller.jokesId = jokeId;
  }

  @override
  bool lazyLoadData() {
    return true;
  }

  @override
  Widget buildSliverList() {
    var items = controller.dataList;
    return ListView.separated(
        itemBuilder: (context, index) {
          return CommonCommentItem(
            controller: controller,
            item: items[index],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.w,
            indent: 48.w,
            color: ColorPalette.instance.divider,
          );
        },
        itemCount: items.length);
  }
}
