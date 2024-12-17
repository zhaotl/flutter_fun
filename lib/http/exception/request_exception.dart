import 'package:dio/dio.dart';

class RequestException implements Exception {
  static const int unknownError = 101;
  static const int netWorkError = 102;

  final String? message;
  final int? code;

  RequestException({this.message, this.code});

  @override
  String toString() {
    return "$code:$message";
  }

  factory RequestException.create(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return RequestException(code: -1, message: "请求失败");
        case DioExceptionType.connectionError:
          return RequestException(code: netWorkError, message: "连接超时");
        case DioExceptionType.sendTimeout:
          return RequestException(code: netWorkError, message: "请求超时");
        case DioExceptionType.receiveTimeout:
          return RequestException(code: netWorkError, message: "响应超时");
        case DioExceptionType.badResponse:
          try {
            int? errorCode = error.response?.statusCode;
            String? errorMsg = error.response?.statusMessage;
            if (errorMsg != null && errorMsg.isNotEmpty) {
              return RequestException(code: errorCode, message: errorMsg);
            }
            switch (errorCode) {
              case 400:
                errorMsg = "请求语法错误";
                break;
              case 401:
                errorMsg = "没有权限";
                break;
              case 403:
                errorMsg = "服务器拒绝执行";
                break;
              case 404:
                errorMsg = "无法连接服务器";
                break;
              case 405:
                errorMsg = "请求方法被禁止";
                break;
              case 500:
                errorMsg = "服务器内部错误";
                break;
              case 502:
                errorMsg = "无效的请求";
                break;
              case 503:
                errorMsg = "服务器宕机";
                break;
              case 505:
                errorMsg = "不支持Http协议请求";
                break;
            }
            return RequestException(code: errorCode, message: errorMsg);
          } on Exception catch (_) {
            return RequestException(code: unknownError, message: "未知错误");
          }
        default:
          return RequestException(code: netWorkError, message: "网络连接异常");
      }
    } else {
      return RequestException(code: unknownError, message: "未知错误");
    }
  }
}
