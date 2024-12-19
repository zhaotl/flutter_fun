import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/app_bar.dart';
import 'package:fun_fluter/components/common_fun_item.dart';
import 'package:fun_fluter/components/nested_page.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/page/fun_detail/fun_detail_controller.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

class FunDetailPage extends NestedPage<FunDetailController> {
  FunDetailPage({super.key, super.tag});

  @override
  Widget buildNestedBody(BuildContext context) {
    return TabBarView(
        controller: controller.tabController, children: controller.navPages);
  }

  @override
  Widget buildNestedHeader(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final funHeight =
          (controller.globalKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      controller.expandedHeight.value = funHeight;
    });

    return Obx(() {
      return SliverAppBar(
          toolbarHeight: 88.w,
          expandedHeight: controller.expandedHeight.value,
          title: commonTitleBar(
              title: "帖子详情", backgroundColor: ColorPalette.instance.pure),
          automaticallyImplyLeading: false,
          pinned: true,
          elevation: 0,
          titleSpacing: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorPalette.instance.pure,
              statusBarIconBrightness: Brightness.dark),
          flexibleSpace: _flexibleSpace(context),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 100.w),
            child: _tabBar(),
          ));
    });
  }

  Widget _flexibleSpace(BuildContext context) {
    FunDetailEntity item = controller.jokeDetailEntity.value;

    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          children: [
            Container(
                key: controller.globalKey,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 88.w),
                child: CommonFun(
                    item: item,
                    onLike: () {
                      controller.likeJokeAction(
                          item.joke?.jokesId, item.info?.isLike != true);
                    },
                    onUnlike: () {
                      controller.unlikeJokeAction(
                          item.joke?.jokesId, item.info?.isUnlike != true);
                    },
                    onAttention: () {
                      bool noAttention = item.info?.isAttention != true;
                      controller.attentionUser(item.user?.userId, noAttention);
                    },
                    multiplexVideoPlayer:
                        Get.arguments?["multiplexVideoPlayer"] ?? true,
                    videoPlayHelper: controller.videoPlayHelper,
                    onComment: () {
                      // todo
                      // showSendCommentSheet(
                      //     GetInstance().find<FunCommentsController>(tag: tag));
                    })),
          ],
        ));
  }

  Widget _tabBar() {
    return TabBar(
      controller: controller.tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: false,
      indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(4.w),
          insets: EdgeInsets.symmetric(horizontal: 160.w),
          borderSide:
              BorderSide(width: 4.w, color: ColorPalette.instance.primary)),
      labelPadding: const EdgeInsets.all(0),
      labelColor: ColorPalette.instance.primary,
      unselectedLabelColor: ColorPalette.instance.secondText,
      labelStyle: TextStyle(fontSize: 36.w, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontSize: 32.w, fontWeight: FontWeight.normal),
      //未选中时标签的颜色
      onTap: (int index) {
        controller.jump2Page(index); //点击标签时切换页面
      },
      tabs: controller.tabs.map((tab) {
        return Container(
          height: 72.w,
          alignment: Alignment.center,
          child: Text(
            tab,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}
