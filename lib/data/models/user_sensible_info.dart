class UserSensibleInfo {
  final String accessToken;
  final String client;
  final String uid;

  UserSensibleInfo({
    required this.accessToken,
    required this.client,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      "accessToken": accessToken,
      "client": client,
      "uid": uid,
    };
  }

  factory UserSensibleInfo.fromMap(Map<String, dynamic> map) {
    return UserSensibleInfo(
      accessToken: map["accessToken"] as String,
      client: map["client"] as String,
      uid: map["uid"] as String,
    );
  }
}
