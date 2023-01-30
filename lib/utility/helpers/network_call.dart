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

    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody: true,
          request: true,
          requestHeader: true,
          responseHeader: true));
    }
    return dio;
  }
}
