import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(const SignUpInitial());

  Future<void> signUp(
    String name,
    String email,
    String password,
    String gender,
  ) async {
    emit(const SignUpLoading());
    final result = await _signUpUseCase.signUp(name, email, password, gender);
    result.when(
      onSuccess: (_) {
        emit(const SignUpSuccessful());
      },
      onError: (error) {
        emit(SignUpError(error.message.toString()));
      },
    );
  }
}
