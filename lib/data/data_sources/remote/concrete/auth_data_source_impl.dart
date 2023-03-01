import 'package:dio/dio.dart';
import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/failure/failure_mapper.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/data/data_sources/remote/abstract/auth_data_source.dart';
import 'package:flutter_base_rootstrap/data/entities/request/sign_in_request.dart';
import 'package:flutter_base_rootstrap/data/network/config/network_constants.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final Dio _dio;

  AuthDataSourceImpl(this._dio);

  @override
  Future<ResultType<bool, Failure>> signIn(
    String email,
    String password,
  ) async {
    final request = SignInRequest(email, password).toMap();
    try {
      final response =
          await _dio.post(NetworkConstants.signInPath, data: request);
      if (response.statusCode == 200) {
        return TSuccess(true);
      }
      return TError(response.data);
    } on DioError catch (error) {
      return TError(error.toFailure());
    } catch (e) {
      return TError(UnexpectedFailure(e.toString()));
    }
  }
}
