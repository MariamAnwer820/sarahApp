import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/api.dart';
import 'package:saraih_app/cubit/login-cubit/login_state.dart';
import 'package:saraih_app/model/login.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.apiService) : super(LoginInitial());
   final ApiService apiService;
  loguser({
    required String userEmail,
    required String userPassword,
  }) async {
    emit(LoginLoadingState());

    try {
      Response response = await apiService.logUser(
        endPoint: '/user/login',
        email: userEmail,
        password: userPassword,
      );
      Login userlogin = Login.fromJson(response.data);
      print(userlogin.token);
      emit(LoginSuccessState(userlogin));
    } on DioException catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
