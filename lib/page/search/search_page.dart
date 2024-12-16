import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/app_bar.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/page/search/search_controller.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final _searchController = Get.find<MySearchController>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (_searchController.searchMode.value) {
            _searchController.updateKey("");
            result = false;
          } else {
            Get.back();
            result = true;
          }
        },
        child: Scaffold(
            appBar: commonAppBar(
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 100.w),
                child: _searchBar(),
              ),
            ),
            body: const Center(child: Text("Search page"))));
  }

  Widget _searchBar() {
    return Container(
      height: 100.w,
      alignment: Alignment.center,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Get.back(),
            child: Container(
                padding: EdgeInsets.only(left: 32.w, right: 12.w),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "ic_back".webp,
                  width: 40.w,
                  height: 40.w,
                  color: ColorPalette.instance.firstIcon,
                )),
          ),
          Expanded(
            child: Container(
              height: 72.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorPalette.instance.inputBackground,
                borderRadius: BorderRadius.circular(36.w),
              ),
              child: Row(
                children: [
                  SizedBox(width: 24.w),
                  Hero(
                    tag: "ic_search",
                    child: Image.asset(
                      "ic_search".webp,
                      width: 32.w,
                      height: 32.w,
                      color: ColorPalette.instance.firstIcon,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController.textEditingController,
                      style: TextStyle(
                        fontSize: 28.w,
                        color: ColorPalette.instance.firstText,
                        letterSpacing: 1.1,
                      ),
                      maxLines: 1,
                      cursorColor: ColorPalette.instance.primary,
                      decoration: InputDecoration(
                        hintText: "搜索感兴趣的帖子吧",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 28.w,
                          color: ColorPalette.instance.secondText,
                        ),
                      ),
                      onChanged: (value) {
                        _searchController.updateKey(value, needDelay: true);
                      },
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: _searchController.keyword.value.isNotEmpty
                              ? Image.asset("ic_clear_input".webp,
                                  width: 32.w,
                                  height: 32.w,
                                  color: ColorPalette.instance.thirdIcon)
                              : SizedBox(width: 32.w)),
                      onTap: () => _searchController.updateKey(""),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (_searchController.searchMode.value) {
                _searchController.updateKey("");
              } else {
                Get.back();
              }
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 12.w, right: 24.w),
              child: Text(
                "取消",
                style: TextStyle(
                    color: ColorPalette.instance.secondText, fontSize: 28.w),
              ),
            ),
          )
        ],
      ),
    );
  }
}
