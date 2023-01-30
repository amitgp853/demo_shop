import 'package:demo_shop/constants/api_constants.dart';
import 'package:demo_shop/utility/helpers/network_call.dart';
import 'package:dio/dio.dart';

import '../../../models/user_dm.dart';

class ErrorWhileLogin implements Exception {}

class LoginRepo {
  //function for login by api call
  Future<void> login(
      {required String username, required String password}) async {
    Dio netCall = await NetworkCall.getDio();
    try {
      await netCall.post(loginPath, data: {
        usernameKey: username,
        passwordKey: password,
      });
    } catch (e) {
      throw ErrorWhileLogin();
    }
    return;
  }

  //function for get the current user by api call
  Future<UserDm> getCurrentUser(
      {required String username, required String password}) async {
    UserDm currentUserDm = UserDm();
    var users = [];
    Dio netCall = await NetworkCall.getDio();
    try {
      Response response = await netCall.get(usersPath);
      if (response.data != null) {
        users = response.data;

        for (var user in users) {
          UserDm userDm = UserDm.fromJson(user);
          if (userDm.username == username && userDm.password == password) {
            currentUserDm = userDm;
            break;
          }
        }
      }
    } catch (e) {
      throw ErrorWhileLogin();
    }
    return currentUserDm;
  }
}
