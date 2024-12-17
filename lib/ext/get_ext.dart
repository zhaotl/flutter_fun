import 'package:fun_fluter/components/loading_dialog.dart';
import 'package:get/get.dart';

extension GetExt on GetInterface {
  showLoading() {
    if (Get.isDialogOpen != null && Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      const LoadingDialog(),
      transitionDuration: const Duration(milliseconds: 50),
      barrierDismissible: false,
    );
  }

  hideLoading() {
    if (Get.isDialogOpen != null && Get.isDialogOpen == true) {
      Get.back();
    }
  }

  hideBottomSheet() {
    if (Get.isBottomSheetOpen != null && Get.isBottomSheetOpen!) {
      Get.back();
    }
  }
}
