import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<ResultType<bool, Failure>> signUp(
    String name,
    String email,
    String password,
    String gender,
  ) async {
    return await _authRepository.signUp(name, email, password, gender);
  }
}
