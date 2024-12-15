import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends GetxService {
  Future<void> init() async {
    await Get.putAsync(() => SharedPreferences.getInstance());
    ColorPalette.instance.init();
  }
}
