import '../../models/user_dm.dart';

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal();

  static UserDm? _userDm;

  static UserDm? getCurrentUserDm() {
    return _userDm;
  }

  static void setCurrentUserDm(UserDm? userDm) {
    _userDm = userDm;
  }
}
