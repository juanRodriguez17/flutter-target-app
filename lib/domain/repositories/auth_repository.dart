import 'package:flutter_base_rootstrap/core/failure/failure.dart';
import 'package:flutter_base_rootstrap/core/result_type.dart';

abstract class AuthRepository {
  Future<ResultType<bool, Failure>> signIn(String email, String password);
}
