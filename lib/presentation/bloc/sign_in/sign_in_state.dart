abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignInSuccessful extends SignInState {
  const SignInSuccessful();
}

class SignInError extends SignInState {
  final String errorMessage;

  const SignInError(this.errorMessage);
}
