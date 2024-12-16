import 'package:fun_fluter/view_state/view_state.dart';
import 'package:get/get.dart';

abstract class ViewStateController extends GetxController {
  final Rx<ViewState> viewState = ViewState().obs;

  void loadData();
}
