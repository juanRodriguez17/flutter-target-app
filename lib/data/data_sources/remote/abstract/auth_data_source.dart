import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';

abstract class AuthDataSource {
  Future<ResultType<bool, Failure>> signIn(String email, String password);

  Future<ResultType<bool, Failure>> signUp(
    String name,
    String email,
    String password,
    String gender,
  );
}
