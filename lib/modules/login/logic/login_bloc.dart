import 'package:bloc/bloc.dart';
import 'package:demo_shop/services/singleton/user_singleton.dart';
import 'package:flutter/material.dart';

import '../../../constants/string_constants.dart';
import '../../../models/user_dm.dart';
import '../repository/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo = LoginRepo();

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithUsername>((event, emit) async {
      emit(LoginLoading());
      try {
        //to call the login
        await loginRepo.login(
            username: event.username, password: event.password);

        //to get the current user details
        UserDm userDm = await loginRepo.getCurrentUser(
            username: event.username, password: event.password);

        //save user details in singleton
        UserSingleton.setCurrentUserDm(userDm);

        emit(LoginSuccess());
      } on ErrorWhileLogin {
        emit(LoginFailed(errorMessage: errorOccurredWhileLogin));
      } catch (e) {
        debugPrint('Error while login: ${e.toString()}');
        emit(LoginFailed(errorMessage: errorOccurredWhileLogin));
      }
    });
  }
}
