
import 'package:saraih_app/model/redisterModel.dart';

class AuthState {}

final class AuthInitial extends AuthState {}
// final class LoginLoadingState extends AuthState {}
// final class LoginSuccessState extends AuthState {
//   final Register userModel;
//   LoginSuccessState(this.userModel);
// }
// final class LoginErrorState extends AuthState {
//   final String errorMessage;
//   LoginErrorState(this.errorMessage);
// }



final class registerLoadingState extends AuthState {}
final class registerSuccessState extends AuthState {
  final Register userModel;
  registerSuccessState(this.userModel);
}
final class registerErrorState extends AuthState {
  final String errorMessage;
  registerErrorState(this.errorMessage);
}
