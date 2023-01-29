import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../repository/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo = LoginRepo();

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithUsername>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginRepo.login(
            username: event.username, password: event.password);
        emit(LoginSuccess());
      } catch (e) {
        debugPrint('Error while login: ${e.toString()}');
        emit(LoginFailed(errorMessage: 'Error Occurred'));
      }
    });
  }
}
