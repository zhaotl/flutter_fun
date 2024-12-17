import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fun_fluter/http/interceptor/params_interceptor.dart';
import 'package:fun_fluter/http/interceptor/token_expire_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static const int connect_timeout = 15000;
  static const int recieve_timeout = 15000;

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: connect_timeout),
      receiveTimeout: const Duration(milliseconds: recieve_timeout),
      headers: {},
    );

    dio = Dio(options);
    dio.httpClientAdapter = IOHttpClientAdapter()
      ..createHttpClient = () {
        return HttpClient()
          ..badCertificateCallback = (cert, host, port) {
            return true;
          };
      };

    dio.interceptors.add(ParamsInterceptor());
    dio.interceptors.add(TokenExpireInterceptor());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        compact: false));
  }
}
