import 'package:dio/dio.dart';

import 'failure.dart';

extension FailureMapper on DioError {
  Failure toFailure() {
    switch (type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return SocketTimeOutFailure(message);
      case DioErrorType.response:
        return HttpFailure(response?.data["error"], response?.statusCode);
      case DioErrorType.cancel:
      case DioErrorType.other:
        return UnexpectedFailure(message);
    }
  }
}
