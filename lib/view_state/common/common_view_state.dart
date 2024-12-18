import 'package:flutter/material.dart';
import 'package:fun_fluter/components/default_view.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:fun_fluter/view_state/view_state.dart';
import 'package:fun_fluter/view_state/view_state_controller.dart';
import 'package:get/get.dart';

abstract class CommonViewState<T extends ViewStateController>
    extends StatelessWidget {
  final bool bindViewState;
  final String? tag;

  const CommonViewState({super.key, this.bindViewState = true, this.tag});

  T get controller => GetInstance().find<T>(tag: tag);

  void preInit();

  bool autoLoadData() => false;

  AppBar? buildAppBar() => null;

  Widget buildBody(BuildContext context);

  Widget? buildCustomEmptyWidget() => null;

  Widget? buildCustomErrorWidget() => null;

  Widget? buildCustomLoadingWidget() => null;

  Widget? buildCustomFailWidget() => null;

  bool useScaffold() => true;

  bool resizeToAvoidBottomInset() => true;

  Color backgroundColor() => ColorPalette.instance.background;

  @override
  Widget build(BuildContext context) {
    preInit();
    if (!autoLoadData()) {
      controller.loadData();
    }
    return Obx(() {
      ViewState viewState = controller.viewState.value;
      Widget child;
      if (bindViewState) {
        if (viewState.isSuccess()) {
          child = buildBody(context);
        } else if (viewState.isEmpty()) {
          child = buildCustomEmptyWidget() ??
              defaultEmptyWidget(() {
                controller.loadData();
              });
        } else if (viewState.isError()) {
          child = buildCustomErrorWidget() ??
              defaultErrorWidget(
                viewState.errorCode,
                viewState.errorMessage,
                () {
                  controller.loadData();
                },
              );
        } else if (viewState.isFail()) {
          child = buildCustomFailWidget() ??
              defaultFailWidget(
                viewState.errorCode,
                viewState.errorMessage,
                () {
                  controller.loadData();
                },
              );
        } else {
          child = buildCustomLoadingWidget() ?? defaultLoadingWidget();
        }
      } else {
        child = buildBody(context);
      }

      return useScaffold()
          ? Scaffold(
              appBar: buildAppBar(),
              resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
              backgroundColor: backgroundColor(),
              body: child)
          : child;
    });
  }
}
