import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<ResultType<bool, Failure>> signIn(String email, String password) async {
    return await _authRepository.signIn(email, password);
  }
}