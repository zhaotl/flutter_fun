import 'package:fun_fluter/page/fun_detail/comment/comments_controller.dart';
import 'package:fun_fluter/page/fun_detail/fun_detail_controller.dart';
import 'package:get/get.dart';

class FunDetailBinding extends Bindings {
  final String? tag;

  FunDetailBinding({this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => FunDetailController(tag: tag), tag: tag);
    Get.lazyPut(() => FunCommentsController(), tag: tag);
  }
}
