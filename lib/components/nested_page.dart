import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:fun_fluter/components/no_over_scroll_behavior.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:get/get.dart';

abstract class NestedPage<T extends GetxController> extends StatelessWidget {
  final String? tag;

  NestedPage({super.key, this.tag});

  final ScrollController scrollController = ScrollController();

  T get controller => Get.find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    preInit();
    return Scaffold(
        backgroundColor: ColorPalette.instance.background,
        body: ScrollConfiguration(
          behavior: NoOverScrollBehavior(),
          child: ExtendedNestedScrollView(
              controller: scrollController,
              onlyOneScrollInBody: true,
              headerSliverBuilder: (context, value) {
                return [buildNestedHeader(context)];
              },
              pinnedHeaderSliverHeightBuilder: () {
                return pinnedHeaderHeight(context);
              },
              body: buildNestedBody(context)),
        ));
  }

  double pinnedHeaderHeight(BuildContext context) => 0.0;

  Widget buildNestedHeader(BuildContext context);

  Widget buildNestedBody(BuildContext context);

  void preInit() {}
}
