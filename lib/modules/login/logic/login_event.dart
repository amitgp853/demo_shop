part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithUsername extends LoginEvent {
  final String username;
  final String password;
  LoginWithUsername({required this.password, required this.username});
}
