import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/api_constants.dart';

class NetworkCall {
  static Future<Dio> getDio() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 40000,
      receiveTimeout: 40000,
      contentType: contentType,
    ));

    dio.interceptors.add(LogInterceptor(
        requestBody: !kReleaseMode,
        responseBody: !kReleaseMode,
        request: !kReleaseMode,
        requestHeader: !kReleaseMode,
        responseHeader: !kReleaseMode));
    return dio;
  }
}
