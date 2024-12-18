import 'package:fun_fluter/page/home/follow/attention_list/attentions_controller.dart';
import 'package:fun_fluter/page/home/follow/recommend_user/recommend_user_controller.dart';
import 'package:fun_fluter/page/home/fresh/fresh_controller.dart';
import 'package:fun_fluter/page/home/fun_image/fun_image_controller.dart';
import 'package:fun_fluter/page/home/home_controller.dart';
import 'package:fun_fluter/page/home/pure_text/pure_text_controller.dart';
import 'package:fun_fluter/page/home/recommend/recommend_controller.dart';
import 'package:fun_fluter/page/index/index_controller.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => RecommendController());
    Get.lazyPut(() => FreshController());
    Get.lazyPut(() => PureTextController());
    Get.lazyPut(() => FunImageController());
    Get.lazyPut(() => RecommendUserController());
    Get.lazyPut(() => AttentionsController());
  }
}
