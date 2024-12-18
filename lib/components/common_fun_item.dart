import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/common_image.dart';
import 'package:fun_fluter/components/fun_video_play_helper_mixin.dart';
import 'package:fun_fluter/components/fun_video_player.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:fun_fluter/utils/media_util.dart';
import 'package:fun_fluter/utils/toast_util.dart';
import 'package:fun_fluter/view_state/common/common_list_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CommonFunItem extends StatelessWidget {
  final FunDetailEntity item;
  final int index;
  final CommonListController? funController;
  final bool showUserInfo;
  final FunVideoPlayHelperMixin? videoPlayHelper;

  const CommonFunItem(
      {super.key,
      required this.item,
      required this.index,
      this.funController,
      this.showUserInfo = true,
      this.videoPlayHelper});

  @override
  Widget build(BuildContext context) {
    return CommonFun(
      item: item,
      index: index,
      showUserInfo: showUserInfo,
      isInnerList: true,
      videoPlayHelper: videoPlayHelper,
      onLike: () {
        funController?.likeFun(item.joke?.jokesId, item.info?.isLike != true);
      },
      onUnlike: () {
        funController?.unLikeFun(
            item.joke?.jokesId, item.info?.isUnlike != true);
      },
      onAttention: () {
        bool noAttention = item.info?.isAttention != true;
        funController?.attentionUser(item.user?.userId, noAttention);
      },
      onComment: () {
        // todo:
        // showJokeCommentSheet()
      },
    );
  }
}

class CommonFun extends StatelessWidget {
  final FunDetailEntity item;
  final int index;
  final bool showUserInfo;
  final VoidCallback? onAttention;
  final VoidCallback? onLike;
  final VoidCallback? onUnlike;
  final VoidCallback? onComment;
  final bool isInnerList;
  final FunVideoPlayHelperMixin? videoPlayHelper;
  final bool multiplexVideoPlayer;

  const CommonFun(
      {super.key,
      required this.item,
      this.index = 0,
      this.showUserInfo = true,
      this.onAttention,
      this.onLike,
      this.onUnlike,
      this.onComment,
      this.isInnerList = false,
      this.videoPlayHelper,
      this.multiplexVideoPlayer = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Map<String, dynamic> arguments = {
          "FunDetailEntity": item,
          "index": index,
          "videoPlayHelper": videoPlayHelper
        };
        if (isInnerList &&
            (item.joke?.type ?? 0) >= 3 &&
            videoPlayHelper?.needAutoPlay(index) == false) {
          videoPlayHelper?.manualPlay(item.joke?.jokesId, index);
          arguments["multiplexVideoPlayer"] = false;
        }
        AppRoutes.jumpToPage(AppRoutes.jokeDetailPage, arguments: arguments);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.w),
        child: Column(
          children: [
            _userInfo(),
            _content(),
            _bottomActionLayout(context),
            SizedBox(height: 12.w),
            Divider(height: 12.w, color: ColorPalette.instance.divider)
          ],
        ),
      ),
    );
  }

  Widget _bottomActionLayout(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionItem(
              "ic_like".webp,
              (item.info?.isLike == true)
                  ? ColorPalette.instance.primary
                  : ColorPalette.instance.secondIcon,
              item.info?.likeNum ?? 0, () {
            if (onLike != null) {
              onLike!();
            }
          }),
          _actionItem(
              "ic_unlike".webp,
              (item.info?.isUnlike == true)
                  ? ColorPalette.instance.primary
                  : ColorPalette.instance.secondIcon,
              item.info?.disLikeNum ?? 0, () {
            if (onUnlike != null) {
              onUnlike!();
            }
          }),
          _actionItem("ic_comment".webp, ColorPalette.instance.secondIcon,
              item.info?.commentNum ?? 0, () {
            if (onComment != null) {
              onComment!();
            }
          }),
          _actionItem("ic_share".webp, ColorPalette.instance.secondIcon,
              item.info?.shareNum ?? 0, () {
            showToast("todo...");
          }),
        ],
      );
    });
  }

  Widget _content() {
    int type = item.joke?.type ?? 1;
    switch (type) {
      case 1:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.w),
          child: Text(
            item.joke?.content ?? "--",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ColorPalette.instance.firstText, fontSize: 30.w),
          ),
        );
      case 2:
        return _imageContent();
      default:
        return FunVideoPlayer(
            item: item,
            index: index,
            isInnerList: isInnerList,
            videoPlayHelper: videoPlayHelper!); // CpnJokeVideoPlayer
    }
  }

  Widget _imageContent() {
    int picSize = item.joke?.imageUrl?.split(",").length ?? 1;
    bool isMultiPic = picSize > 1;
    Widget picBody;
    if (isMultiPic) {
      /// 多图
      double spacing = 12.w;
      int columnCount = (picSize > 3) ? 3 : picSize;
      double displaySize = (686.w - (columnCount - 1) * spacing) / columnCount;
      List<Widget> images = item.joke!.imageUrl!
          .split(",")
          .map(
            (v) =>
                _imageItem(v, 8.w, displaySize, displaySize, isMultiPic: true),
          )
          .toList();

      picBody = Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: images,
      );
    } else {
      List<double>? imageSize =
          item.joke?.imageSize?.split("x").map((v) => double.parse(v)).toList();
      if (imageSize != null) {
        double maxDisplayWidth = 686.w;
        double maxDisplayHeight = 400.w;
        double realWidth = imageSize[0];
        double realHeight = imageSize[1];
        double? displayWidth;
        double? displayHeight;
        double realRatio = realWidth / realHeight;
        if (realRatio >= 1) {
          /// 照片实际宽度>=实际高度
          if (maxDisplayWidth >= realWidth) {
            ///照片最大显示宽度>照片实际宽度
            displayWidth = realWidth;
            displayHeight = realHeight;
          } else {
            double displayRatio = maxDisplayWidth / realWidth;
            displayWidth = maxDisplayWidth;
            displayHeight = realHeight * displayRatio;
          }
        } else {
          if (maxDisplayHeight >= realHeight) {
            ///照片最大显示高度>照片实际高度
            displayWidth = realWidth;
            displayHeight = realHeight;
          } else {
            double displayRatio = maxDisplayHeight / realHeight;
            displayWidth = max(realWidth * displayRatio, 240.w);
            displayHeight = maxDisplayHeight;
          }
        }
        picBody = _imageItem(
            item.joke?.imageUrl ?? "", 16.w, displayWidth, displayHeight);
      } else {
        picBody = _imageItem(item.joke?.imageUrl ?? "", 16.w, 686.w, 400.w);
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(item.joke?.content ?? "--",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: ColorPalette.instance.firstText, fontSize: 30.w)),
          SizedBox(height: 16.w),
          picBody,
        ],
      ),
    );
  }

  Widget _actionItem(
      String imgAsset, Color imgColor, int count, VoidCallback actionCallback) {
    return InkWell(
      onTap: actionCallback,
      child: Container(
        height: 72.w,
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Image.asset(imgAsset,
                  width: 36.w, height: 36.w, color: imgColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text("$count",
                  style: TextStyle(
                      color: ColorPalette.instance.secondText, fontSize: 28.w)),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageItem(String url, double width, double height, double radius,
      {bool isMultiPic = false}) {
    List<String> urlList =
        isMultiPic ? item.joke?.imageUrl?.split(",").toList() ?? [] : [url];
    int index = isMultiPic ? urlList.indexOf(url) : 0;
    return GestureDetector(
      onTap: () {
        AppRoutes.jumpToPage(AppRoutes.picPreviewPage, arguments: {
          "urlList": urlList,
          "index": index,
        });
      },
      child: Hero(
        tag: urlList[index],
        child: RepaintBoundary(
          child: commonImage(CommonImageType.radiusImage,
              url: decodeMediaUrl(url),
              radius: radius,
              boxFit: BoxFit.cover,
              width: width,
              height: height,
              defaultHolderWidth: 100.w,
              defaultHolderHeight: 100.w),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return showUserInfo
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  AppRoutes.jumpToPage(AppRoutes.userCenterPage, arguments: {
                    "index": "0",
                    "userId": (item.user?.userId ?? 0).toString()
                  });
                },
                child: RepaintBoundary(
                  child: commonImage(CommonImageType.circleImage,
                      url: item.user?.avatar,
                      width: 80.w,
                      height: 80.w,
                      defaultPlaceHolderAssetName: "ic_default_avatar",
                      defaultErrorAssetName: "ic_default_avatar"),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    AppRoutes.jumpToPage(AppRoutes.userCenterPage, arguments: {
                      "index": "0",
                      "userId": (item.user?.userId ?? 0).toString()
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.user?.nickName ?? "--",
                        style: TextStyle(
                            color: ColorPalette.instance.firstText,
                            fontSize: 28.w,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        item.user?.signature ?? "--",
                        maxLines: 1,
                        style: TextStyle(
                            color: ColorPalette.instance.secondText,
                            fontSize: 24.w),
                      )
                    ],
                  ),
                ),
              ),
              item.info?.isAttention != true
                  ? InkWell(
                      onTap: () {
                        onAttention; // todo: double check if it works
                        // if (onAttention != null) onAttention!();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Text(
                          "关注",
                          style: TextStyle(
                              color: ColorPalette.instance.primary,
                              fontSize: 30.w,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        // todo:
                        // showJokeMoreSheet();
                      },
                      child: Image.asset("ic_more_menu".webp,
                          width: 40.w,
                          height: 40.w,
                          color: ColorPalette.instance.firstIcon),
                    )
            ],
          )
        : SizedBox.shrink();
  }
}
