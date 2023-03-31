class SignUpRequest {
  final String name;
  final String email;
  final String password;
  final String gender;

  SignUpRequest(
    this.name,
    this.email,
    this.password,
    this.gender,
  );

  Map<String, dynamic> toMap() {
    return {
      "user": {
        "first_name": name,
        "email": email,
        "password": password,
        "confirm_password": password,
        "gender": gender,
      },
    };
  }
}
