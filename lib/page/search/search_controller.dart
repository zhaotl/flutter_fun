import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_fluter/page/search/result/search_result_controller.dart';
import 'package:fun_fluter/utils/keyboard_util.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final RxString _keyword = "".obs;
  String get keyword => _keyword.value;
  final searchResultController = Get.find<SearchResultController>();
  Timer? _delaySearchTimer;
  RxBool searchMode = false.obs;

  void updateKey(String value, {bool needDelay = false}) {
    _keyword.value = value;
    textEditingController.value = TextEditingValue(
        text: value,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: value.length)));
    _delaySearchTimer?.cancel();
    if (value.isNotEmpty) {
      if (needDelay) {
        _delaySearchTimer = Timer(const Duration(milliseconds: 1000), () {
          searchMode.value = true;
          hideKeyboard();
          searchResultController.updateKey(keyword);
        });
      } else {
        searchMode.value = true;
        hideKeyboard();
        searchResultController.updateKey(keyword);
      }
    } else {
      searchMode.value = false;
      searchResultController.updateKey(keyword);
    }
  }

  @override
  void dispose() {
    _delaySearchTimer?.cancel();
    super.dispose();
  }
}
