abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccessful extends SignUpState {
  const SignUpSuccessful();
}

class SignUpError extends SignUpState {
  final String errorMessage;

  const SignUpError(this.errorMessage);
}