import 'dart:convert';

import 'package:flutter_base_rootstrap/data/models/user_sensible_info.dart';
import 'package:flutter_base_rootstrap/data/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesImpl extends Preferences {
  final SharedPreferences sharedPreferences;

  static const securityInfo = "security_info";
  static const session = "session";
  static const userId = "user_id";

  PreferencesImpl(this.sharedPreferences);

  @override
  UserSensibleInfo? getUserSensibleInfo() {
    final sensibleInfo = sharedPreferences.getString(securityInfo);

    if (sensibleInfo == null || sensibleInfo.isEmpty) {
      return null;
    }

    return UserSensibleInfo.fromMap(jsonDecode(sensibleInfo));
  }

  @override
  Future<bool> setUserSensibleInfo(UserSensibleInfo? userSensibleInfo) {
    return sharedPreferences.setString(
      securityInfo,
      jsonEncode(userSensibleInfo?.toMap()),
    );
  }

  @override
  int? getUserId() {
    final userId = sharedPreferences.getInt(PreferencesImpl.userId);
    if (userId == 0) return null;
    return userId;
  }

  @override
  Future<bool> setUserId(int? userId) {
    if (userId == null) {
      return sharedPreferences.setInt(PreferencesImpl.userId, 0);
    }
    return sharedPreferences.setInt(PreferencesImpl.userId, userId);
  }
}
