import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_rootstrap/data/network/interceptors/header_interceptor.dart';
import 'network_constants.dart';

class NetworkConfig {
  static Dio provideDio(HeaderInterceptor headerInterceptor) {
    final options = BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      connectTimeout: NetworkConstants.connectTimeout,
      receiveTimeout: NetworkConstants.receiveTimeout,
    );
    final dio = Dio(options);
    if (kDebugMode) dio.interceptors.add(dioLoggerInterceptor);
    dio.interceptors.addAll([
      headerInterceptor,
      dioLoggerInterceptor,
    ]);
    return dio;
  }
}
