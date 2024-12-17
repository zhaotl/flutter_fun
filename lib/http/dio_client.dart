import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fun_fluter/http/http_client.dart';
import 'package:fun_fluter/http/interceptor/params_interceptor.dart';
import 'package:fun_fluter/http/interceptor/token_expire_interceptor.dart';

class DioClient {
  static const int connect_timeout = 15000;
  static const int recieve_timeout = 15000;

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio _dio;

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: connect_timeout),
      receiveTimeout: const Duration(milliseconds: recieve_timeout),
      headers: {},
    );

    _dio = Dio(options);
    _dio.httpClientAdapter = IOHttpClientAdapter()
      ..createHttpClient = () {
        return HttpClient()
          ..badCertificateCallback = (cert, host, port) {
            return true;
          };
      };

    _dio.interceptors.add(ParamsInterceptor());
    _dio.interceptors.add(TokenExpireInterceptor());
    // _dio.interceptors.add(PrettyD)
  }
}
