import 'package:fun_fluter/http/api/api_service.dart';
import 'package:fun_fluter/http/dio_client.dart';

class HttpGo {
  HttpGo._();
  static HttpGo? _instance;
  static HttpGo get instance => _getInstance();

  static HttpGo _getInstance() {
    _instance ??= HttpGo._();
    return _instance!;
  }

  ApiService apiService = ApiService(DioClient().dio);
}
