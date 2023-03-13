import 'package:flutter_base_rootstrap/data/models/user_sensible_info.dart';

abstract class Preferences {
  UserSensibleInfo? getUserSensibleInfo();
  Future<bool> setUserSensibleInfo(UserSensibleInfo? userSensibleInfo);
  int? getUserId();
  Future<bool> setUserId(int? userId);
}