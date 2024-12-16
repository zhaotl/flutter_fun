import 'dart:convert';

import 'package:fun_fluter/utils/preference_utils.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final String searchHistoryKey = "historySearch";
  RxList<String> historyKes = <String>[].obs;
  RxBool editMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    String localJson = PreferenceUtils.instance.getString(searchHistoryKey);
    if (localJson.isNotEmpty) {
      List<String> localHistory = jsonDecode(localJson).cast<String>();
      historyKes.addAll(localHistory);
    }
  }

  void add(String key) {
    historyKes.remove(key);
    historyKes.insert(0, key);
    if (historyKes.length > 10) {
      historyKes.value = historyKes.sublist(0, 10);
    }
    historyKes.refresh();
    String json = jsonEncode(historyKes);
    PreferenceUtils.instance.setString(searchHistoryKey, json);
  }

  void remove(String key) {
    historyKes.remove(key);
    historyKes.refresh();
    String json = jsonEncode(historyKes);
    PreferenceUtils.instance.setString(searchHistoryKey, json);
  }

  void removeAll() {
    historyKes.clear();
    historyKes.refresh();
    editMode.value = false;
    PreferenceUtils.instance.setString(searchHistoryKey, "");
  }
}
