import 'package:flutter/material.dart';
import 'package:fun_fluter/page/index/index_binding.dart';
import 'package:fun_fluter/page/index/index_page.dart';
import 'package:fun_fluter/page/search/search_binding.dart';
import 'package:fun_fluter/page/search/search_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static RxString curPage = indexPage.obs;
  static final prePage = Rxn<String>();

  static const indexPage = "/";
  static const publishPage = "/publish_page";
  static const searchPage = "/search_page";
  static const verifyCodeLoginPage = "/verify_code_login_page";
  static const userCenterPage = "/user_center_page";
  static const userEditCenterPage = "/edit_center_page";
  static const userEditNicknamePage = "/edit_nickname_page";
  static const userEditSignaturePage = "/edit_signature_page";
  static const userEditCropAvatarPage = "/edit_crop_avatar_page";
  static const fansPage = "/fans_page";
  static const experiencePage = "/experience_page";
  static const picPreviewPage = "/pic_preview_page";
  static const jokeDetailPage = "/joke_detail_page";
  static const commentDetailPage = "/comment_detail_page";
  static const settingPage = "/setting_page";

  static final routerPages = [
    GetPage(name: indexPage, page: () => IndexPage(), binding: IndexBinding()),
    GetPage(
        name: searchPage,
        page: () => SearchPage(),
        binding: SearchBinding(),
        transition: Transition.fadeIn),
  ];

  static Future<T?>? jumpToPage<T>(String page,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      bool needLogin = false,
      String? tag}) {
    if (needLogin) {
      // todo needs (needLogin && !UserManager.instance.isLogin()
      // return Get.toNamed(verifyCodeLoginPage);
    } else {
      tag = tag ?? DateTime.now().millisecondsSinceEpoch.toString();
      switch (page) {
        case userCenterPage:
          return Get.to(const Placeholder());
        default:
          return Get.toNamed(page,
              arguments: arguments,
              id: id,
              preventDuplicates: false,
              parameters: parameters);
      }
    }
  }
}
