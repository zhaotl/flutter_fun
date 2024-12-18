import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/nested_page.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/page/home/follow/recommend_user/recommend_user_page.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FollowPage extends NestedPage {
  FollowPage({super.key});

  @override
  Widget buildNestedHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 468.w,
            child: RecommendUserPage(),
          ),
          Container(
              color: ColorPalette.instance.divider,
              width: double.infinity,
              height: 12.w)
        ],
      ),
    );
  }

  @override
  Widget buildNestedBody(BuildContext context) {
    return Obx(() {
      // todo
      // return UserManager.instance.isLogin() ? CpnAttentionList() : _toLogin();
      return _toLogin();
    });
  }

  Widget _toLogin() {
    return Column(
      children: [
        SizedBox(height: 200.w),
        Image.asset(
          "ic_guide".webp,
          width: 192.w,
          height: 192.w,
          color: ColorPalette.instance.secondary,
        ),
        SizedBox(height: 48.w),
        Text("点击登录,获取关注推荐内容～",
            style: TextStyle(
                fontSize: 28.w, color: ColorPalette.instance.secondText)),
        SizedBox(height: 48.w),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AppRoutes.jumpToPage(AppRoutes.verifyCodeLoginPage);
          },
          child: Container(
              width: 320.w,
              height: 72.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
                    color: ColorPalette.instance.primary, width: 2.w)),
                borderRadius: BorderRadius.circular((36.w)),
              ),
              child: Text("去登录",
                  style: TextStyle(
                      color: ColorPalette.instance.primary,
                      fontSize: 32.w,
                      fontWeight: FontWeight.w500))),
        ),
      ],
    );
  }
}
