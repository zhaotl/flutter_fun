import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_fluter/utils/keyboard_util.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final RxString _keyword = "".obs;
  String get keyword => _keyword.value;
  // final SearchResultLogic
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
          // todo
          // searchResultLogic.updateKey(keyword.value);
        });
      } else {
        searchMode.value = true;
        hideKeyboard();
        // searchResultLogic.updateKey(keyword.value);
      }
    } else {
      searchMode.value = false;
      // searchResultLogic.updateKey(keyword.value);
    }
  }

  @override
  void dispose() {
    _delaySearchTimer?.cancel();
    super.dispose();
  }
}
