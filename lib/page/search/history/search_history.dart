import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/common/common.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/page/search/history/search_history_controller.dart';
import 'package:fun_fluter/page/search/search_controller.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

class SearchHistory extends StatelessWidget {
  SearchHistory({super.key});
  final _historyController = Get.find<HistoryController>();
  final _searchController = Get.find<MySearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<String> historyKes = _historyController.historyKes;
      if (historyKes.isNotEmpty) {
        return Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              Wrap(
                spacing: 16.w,
                runSpacing: 16.w,
                children: historyKes.map((key) => _keyItem(key)).toList(),
              )
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _keyItem(String key) {
    var index = _historyController.historyKes.indexOf(key) + 4;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_historyController.editMode.value) {
          _historyController.remove(key);
        } else {
          _searchController.updateKey(key);
        }
      },
      child: Container(
        height: 64.w,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        decoration: BoxDecoration(
          color: keywordsColors[index % keywordsColors.length],
          borderRadius: BorderRadius.all(Radius.circular(32.w)),
          border: Border.fromBorderSide(
            BorderSide(
              color: ColorPalette.instance.divider,
              width: 2.w,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              key,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.w,
                color: ColorPalette.instance.pure,
              ),
            ),
            SizedBox(width: 8.w),
            _historyController.editMode.value
                ? Image.asset(
                    "ic_delete_circle_shape".webp,
                    width: 32.w,
                    height: 32.w,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "历史搜索",
              style: TextStyle(
                  fontSize: 28.w,
                  color: ColorPalette.instance.firstText,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _historyController.editMode.value
              ? Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _historyController.removeAll(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 18.w),
                        child: Text(
                          "全部删除",
                          style: TextStyle(
                            fontSize: 24.w,
                            color: ColorPalette.instance.secondText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w, height: 32.w),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _historyController.editMode.value = false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.w),
                        child: Text(
                          "完成",
                          style: TextStyle(
                            fontSize: 24.w,
                            color: ColorPalette.instance.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _historyController.editMode.value = true,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, top: 16.w, bottom: 16.w),
                    child: Image.asset(
                      "ic_delete".webp,
                      width: 32.w,
                      height: 32.w,
                      color: ColorPalette.instance.secondIcon,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
