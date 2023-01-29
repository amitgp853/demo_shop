import 'package:demo_shop/utility/helpers/network_call.dart';
import 'package:dio/dio.dart';

class LoginRepo {
  Future login({required String username, required String password}) async {
    Dio netCall = await NetworkCall.getDio();
    await netCall.post('auth/login', data: {
      "username": username,
      "password": password,
    });
    return;
  }
}
