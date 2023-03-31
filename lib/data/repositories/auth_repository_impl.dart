import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/data/data_sources/remote/abstract/auth_data_source.dart';
import 'package:flutter_base_rootstrap/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<ResultType<bool, Failure>> signIn(
    String email,
    String password,
  ) async {
    return await _authDataSource.signIn(email, password);
  }

  @override
  Future<ResultType<bool, Failure>> signUp(
    String name,
    String email,
    String password,
    String gender,
  ) async {
    return await _authDataSource.signUp(name, email, password, gender);
  }
}
