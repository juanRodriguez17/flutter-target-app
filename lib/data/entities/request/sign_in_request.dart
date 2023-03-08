class SignInRequest {
  final String email;
  final String password;

  SignInRequest(this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      "user": {
        "email": email,
        "password": password,
      },
    };
  }
}
