import 'package:dio/dio.dart';
import 'package:fun_fluter/log/fun_log.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:fun_fluter/utils/toast_util.dart';

class TokenExpireInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data['code'] == 202) {
      FunLog.e("登录过期");
      showToast("当前登录信息已过期，请重新登录");
      AppRoutes.jumpToPage(AppRoutes.verifyCodeLoginPage);
    }
    super.onResponse(response, handler);
  }
}
