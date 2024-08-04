import 'package:saraih_app/cubit/Register-cubit/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/api.dart';
import 'package:saraih_app/model/redisterModel.dart';
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.apiService) : super(AuthInitial());
  final ApiService apiService;
  
  Reguser({
     required String username,
    required String userPassword,
    required String userEmail,
    required String age,
  }) async {
    emit(registerLoadingState());

    try {
      Response response = await apiService.RegUser(
        endPoint: '/user/register',
        name: username,
        email: userEmail,
        password: userPassword,
        age: age,
      );
      Register userModel = Register.fromJson(response.data);
      print(userModel);
      emit(registerSuccessState(userModel));
    } on DioException catch (e) {
      emit(registerErrorState(e.toString()));
    }
  }



}

