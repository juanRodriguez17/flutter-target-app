import 'package:flutter_base_rootstrap/core/result_type.dart';
import 'package:flutter_base_rootstrap/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_base_rootstrap/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;

  SignInCubit(this._signInUseCase) : super(const SignInInitial());

  void resetInputs() {
    emit(const SignInInitial());
  }

  Future<void> signIn(String email, String password) async {
    emit(const SignInLoading());
    final result = await _signInUseCase.signIn(email, password);
    result.when(
      onSuccess: (_) {
        emit(const SignInSuccessful());
      },
      onError: (error) {
        emit(SignInError(error.message.toString()));
      },
    );
  }
}
