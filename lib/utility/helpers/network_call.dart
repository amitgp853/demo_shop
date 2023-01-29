import 'package:dio/dio.dart';

class NetworkCall {
  static Future<Dio> getDio() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      connectTimeout: 40000,
      receiveTimeout: 40000,
      contentType: 'application/json',
    ));

    dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        request: true,
        requestHeader: true,
        responseHeader: true));
    return dio;
  }
}
