import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  // 单例实例
  static final PreferenceUtils _instance = PreferenceUtils._internal();

  // 私有构造函数，防止外部直接实例化
  PreferenceUtils._internal();

  // 获取单例实例的静态方法
  static PreferenceUtils get instance => _instance;

  // 保存字符串类型的偏好设置的方法
  void setString(String key, String value) =>
      Get.find<SharedPreferences>().setString(key, value);

  // 获取字符串类型的偏好设置的方法，若不存在返回null
  String getString(String key, [String defaultValue = '']) =>
      Get.find<SharedPreferences>().getString(key) ?? defaultValue;

  // 保存布尔类型的偏好设置的方法
  void setBool(String key, bool value) =>
      Get.find<SharedPreferences>().setBool(key, value);

  // 获取布尔类型的偏好设置的方法，若不存在返回false
  bool getBool(String key, [bool defaultValue = false]) =>
      Get.find<SharedPreferences>().getBool(key) ?? defaultValue;

  // 保存整数类型的偏好设置的方法
  void setInt(String key, int value) =>
      Get.find<SharedPreferences>().setInt(key, value);

  // 获取整数类型的偏好设置的方法，若不存在返回0
  int getInt(String key, [int defaultValue = 0]) =>
      Get.find<SharedPreferences>().getInt(key) ?? defaultValue;

  // 保存双精度浮点数类型的偏好设置的方法
  void setDouble(String key, double value) =>
      Get.find<SharedPreferences>().setDouble(key, value);

  // 获取双精度浮点数类型的偏好设置的方法，若不存在返回0.0
  double getDouble(String key, [double defaultValue = 0.0]) =>
      Get.find<SharedPreferences>().getDouble(key) ?? defaultValue;

  void setStringList(String key, List<String> value) =>
      Get.find<SharedPreferences>().setStringList(key, value);

  List<String> getStringList(String key,
          {List<String> defalutValue = const <String>[]}) =>
      Get.find<SharedPreferences>().getStringList(key) ?? [];

  // 删除指定键对应的偏好设置的方法
  void remove(String key) => Get.find<SharedPreferences>().remove(key);

  // 清除所有偏好设置的方法
  void clear() => Get.find<SharedPreferences>().clear();
}
