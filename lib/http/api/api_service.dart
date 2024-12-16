import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://tools.cretinzp.com/jokes/")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;
}
