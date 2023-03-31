import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/failure/failure_mapper.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/data/data_sources/remote/abstract/auth_data_source.dart';
import 'package:flutter_base_rootstrap/data/entities/request/sign_in_request.dart';
import 'package:flutter_base_rootstrap/data/entities/request/sign_up_request.dart';
import 'package:flutter_base_rootstrap/data/models/user_sensible_info.dart';
import 'package:flutter_base_rootstrap/data/network/config/network_constants.dart';
import 'package:flutter_base_rootstrap/data/preferences/preferences.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final Dio _dio;
  final Preferences _preferences;

  AuthDataSourceImpl(
    this._dio,
    this._preferences,
  );

  @override
  Future<ResultType<bool, Failure>> signIn(
    String email,
    String password,
  ) async {
    final request = SignInRequest(email, password).toMap();
    try {
      final response =
          await _dio.post(NetworkConstants.signInPath, data: request);

      final accessToken = response.headers.value(NetworkConstants.authHeader);
      final client = response.headers.value(NetworkConstants.clientHeader);
      final uid = response.headers.value(NetworkConstants.uidHeader);

      if (accessToken == null || client == null || uid == null) {
        return TError(UnexpectedFailure());
      }

      final userSensibleInfo = UserSensibleInfo(
        accessToken: accessToken,
        client: client,
        uid: uid,
      );

      await _preferences.setUserId(response.data["user"]["id"]);
      await _preferences.setUserSensibleInfo(userSensibleInfo);

      return TSuccess(true);
    } on DioError catch (error) {
      return TError(error.toFailure());
    } catch (e) {
      log(e.toString());
      return TError(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<ResultType<bool, Failure>> signUp(
    String name,
    String email,
    String password,
    String gender,
  ) async {
    final request = SignUpRequest(name, email, password, gender).toMap();
    try {
      final response = await _dio.post(NetworkConstants.signUpPath, data: request);

      final accessToken = response.headers.value(NetworkConstants.authHeader);
      final client = response.headers.value(NetworkConstants.clientHeader);
      final uid = response.headers.value(NetworkConstants.uidHeader);

      if (accessToken == null || client == null || uid == null) {
        return TError(UnexpectedFailure());
      }

      final userSensibleInfo = UserSensibleInfo(
        accessToken: accessToken,
        client: client,
        uid: uid,
      );

      await _preferences.setUserId(response.data["user"]["id"]);
      await _preferences.setUserSensibleInfo(userSensibleInfo);

      return TSuccess(true);
    } on DioError catch (error) {
      return TError(error.toFailure());
    } catch (e) {
      return TError(UnexpectedFailure(e.toString()));
    }
  }
}
