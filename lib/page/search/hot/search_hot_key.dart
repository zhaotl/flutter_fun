import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/view_state/common/common_view_state.dart';
import 'package:fun_fluter/page/search/hot/search_hot_key_controller.dart';
import 'package:fun_fluter/page/search/search_controller.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

class SearchHotKey extends CommonViewState<SearchHotKeyController> {
  SearchHotKey({super.key});

  final List<Color> keywordsColors = [
    const Color(0xffe35454),
    const Color(0xff549A3A),
    const Color(0xff34856E),
    const Color(0xffB59B42),
    const Color(0xff9B4BAA),
    const Color(0xff4966B1),
  ];

  final searchController = Get.find<MySearchController>();

  @override
  bool autoLoadData() {
    return true;
  }

  @override
  bool useScaffold() {
    return false;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.w),
            child: Text(
              "热门搜索",
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalette.instance.secondText),
            ),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(controller.hotKeys.length, (index) {
              var item = controller.hotKeys[index];
              return _keyItem(item, index);
            }),
          )
        ],
      ),
    );
  }

  @override
  void preInit() {}

  Widget _keyItem(String key, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        searchController.updateKey(key);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 64.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(
                        color: ColorPalette.instance.divider, width: 2.w),
                  ),
                  borderRadius: BorderRadius.circular(32.w),
                  color: keywordsColors[index % keywordsColors.length]),
              child: Text(
                key,
                style: TextStyle(
                    fontSize: 28.w,
                    color: ColorPalette.instance.pure,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
