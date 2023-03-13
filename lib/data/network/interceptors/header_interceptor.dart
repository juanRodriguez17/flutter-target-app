import 'package:dio/dio.dart';
import 'package:flutter_base_rootstrap/data/network/config/network_constants.dart';

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      NetworkConstants.acceptHeader: NetworkConstants.typesOfContentAccepted,
    });

    return super.onRequest(options, handler);
  }
}
