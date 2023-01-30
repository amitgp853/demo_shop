import 'package:demo_shop/constants/api_constants.dart';
import 'package:demo_shop/utility/helpers/network_call.dart';
import 'package:dio/dio.dart';

class ErrorWhileLogin implements Exception {}

class UsernamePasswordNotCorrect implements Exception {}

class LoginRepo {
  //function for login by api call
  Future<void> login(
      {required String username, required String password}) async {
    Dio netCall = await NetworkCall.getDio();
    try {
      await netCall.post(loginPath, data: {
        usernameKey: username,
        passwordKey: password,
      }).then((response) {
        if (response.data.toString() == responseUsernamePasswordIncorrect) {
          throw UsernamePasswordNotCorrect();
        }
      });
    } catch (e) {
      throw ErrorWhileLogin();
    }
    return;
  }
}
