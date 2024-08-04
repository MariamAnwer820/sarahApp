import 'package:saraih_app/model/login.dart';

class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final Login userlogin;
  LoginSuccessState(this.userlogin);
}
final class LoginErrorState extends LoginState {
  final String errorMessage;
  LoginErrorState(this.errorMessage);
}