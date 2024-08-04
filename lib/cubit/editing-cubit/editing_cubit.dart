// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/api.dart';
import 'package:saraih_app/cubit/editing-cubit/editing_state.dart';
import 'package:saraih_app/model/editing.dart';

class EditingCubit extends Cubit<EditingState> {
  EditingCubit(this.apiService) : super(EditingInitial());
  final ApiService apiService;

  editName({
    required String name,
  }) async {
    emit(EditingnameLoading());

    try {
      Response response = await apiService.editName(
        endPoint: '/user//profile/edit-name',
        name: name,
      );
      Editing userlogin = Editing.fromJson(response.data);
      print(userlogin);
      emit(EditingnameSuccess());
    } on DioException catch (e) {
      emit(EditingnameError(e.toString()));
    }
  }
  
  resetpassword({
    required String oldPassword,
    required String newPassword,
    required String newPassswordConfirmation,
  }) async {
    emit(EditingpasswordLoading());

    try {
      Response response = await apiService.resetPassword(
        endPoint: '/user/profile/reset-password',
        Oldpassword: oldPassword,
        Newpassword: newPassword,
        Conpassword: newPassswordConfirmation,
      );
      Editing userlogin = Editing.fromJson(response.data);
      print(userlogin);
      emit(EditingpasswordSuccess());
    } on DioException catch (e) {
      emit(EditingpasswordError(e.toString()));
    }
  }

}
