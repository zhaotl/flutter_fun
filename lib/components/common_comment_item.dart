import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/common_image.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/ext/get_ext.dart';
import 'package:fun_fluter/http/models/fun_comment_entity.dart';
import 'package:fun_fluter/page/fun_detail/comment/comments_controller.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

/// 评论item组件
class CommonCommentItem extends StatelessWidget {
  final FunCommentComments item;
  final FunCommentsController controller;

  const CommonCommentItem(
      {super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 24.w, bottom: 8.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  AppRoutes.jumpToPage(AppRoutes.userCenterPage, arguments: {
                    "index": "0",
                    "userId": (item.commentUser?.userId ?? 0).toString()
                  });
                },
                child: commonImage(CommonImageType.circleImage,
                    url: item.commentUser?.userAvatar,
                    width: 80.w,
                    height: 80.w),
              ),
              SizedBox(width: 32.w),
              _commentItemBody(item),
              SizedBox(width: 32.w),
              _commentItemLikeInfo(item),
            ],
          ),
          // _subComments(item, controller)
        ],
      ),
    );
  }

  /// 评论列表item内容
  Widget _commentItemBody(FunCommentComments item) {
    List<Widget> bottomChildren = [];
    bottomChildren.add(Text(
      item.timeStr ?? "--",
      style: TextStyle(fontSize: 24.w, color: ColorPalette.instance.thirdText),
    ));
    bottomChildren.add(GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.hideBottomSheet();
        controller.replyCommentId = item.commentId;
        controller.isReplyChild = false;
        // todo
        // showSendCommentSheet(controller);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
        child: Text(
          "回复",
          style: TextStyle(
              fontSize: 24.w, color: ColorPalette.instance.secondText),
        ),
      ),
    ));

    // todo
    // if (UserManager.instance.isSelf(item.commentUser?.userId)) {
    //   bottomChildren.add(GestureDetector(
    //     behavior: HitTestBehavior.opaque,
    //     onTap: () {
    //       controller.deleteComment(item);
    //     },
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
    //       child: Text(
    //         "删除",
    //         style:
    //             TextStyle(fontSize: 24.w, color: ColorPalette.instance.primary),
    //       ),
    //     ),
    //   ));
    // }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.commentUser?.nickname ?? "--",
            style: TextStyle(
                fontSize: 28.w,
                color: ColorPalette.instance.secondText,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.w),
          Text(
            item.content ?? "--",
            style: TextStyle(
                fontSize: 28.w, color: ColorPalette.instance.firstText),
          ),
          Row(
            children: bottomChildren,
          )
        ],
      ),
    );
  }

  /// 评论item点赞信息
  Widget _commentItemLikeInfo(FunCommentComments item) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.likeComment(item);
        },
        child: Column(
          children: [
            SizedBox(height: 24.w),
            Image.asset("ic_like_heart_fill".webp,
                width: 32.w,
                height: 32.w,
                color: (item.isLike == true)
                    ? ColorPalette.instance.primary
                    : ColorPalette.instance.thirdIcon),
            SizedBox(height: 8.w),
            Text(
              (item.likeNum ?? 0).toString(),
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalette.instance.thirdIcon),
            ),
          ],
        ));
  }
}
