import 'package:dio/dio.dart';
import 'package:saraih_app/cons.dart';
class ApiService {
  final Dio dio;
  ApiService(this.dio);
  final String baseUrl = 'https://saraha-gqxi.onrender.com/api';
//////////////////////////////////////////
//login
  Future<Response> RegUser({
    required String endPoint,
    required String name,
    required String email,
    required String password,
    required String age,
  }) async {
    try {
      Response response = await dio.post(
        '$baseUrl$endPoint',
        data: {
          'name':name,
          'password':password,
          'email': email,
          'age': age,
        },
      );

      return response;
    } on DioException catch (e) {
      print(e);
      throw Exception(e.toString());
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }



  Future<Response> logUser({
    required String endPoint,
     String? name,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        '$baseUrl$endPoint',
        data: {
          'password':password,
          'email': email,
        },
      );
      return response;
    } on DioException catch (e) {
      print(e);
      throw Exception(e.toString());
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }



   Future<Response> sendMassage({
    required String endPoint,
    required String email,
    required String message,
  }) async {
    try {
      Response response = await dio.post(
        '$baseUrl$endPoint',
        data: {
          'message':message,
          'email': email,
        },
      );

      return response;
    } on DioException catch (e) {
      print(e);
      throw Exception(e.toString());
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }



Future<Response> resetPassword({
    required String endPoint,
    required String Oldpassword,
    required String Newpassword,
    required String Conpassword,
  }) async {
    try {
      Response response = await dio.put(
        '$baseUrl$endPoint',
        data: {
          'oldPassword':Oldpassword,
          'newPassword':Newpassword,
          'newPassswordConfirmation':Conpassword
        },
      );

      return response;
    } on DioException catch (e) {
      print(e);
      throw Exception(e.toString());
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }


  Future<Response> editName({
    required String endPoint,
    required String name,
  }) async {
    try {
      Response response = await dio.put(
        '$baseUrl$endPoint',
        data: {
          'name':name,
          
        },
      );

      return response;
    } on DioException catch (e) {
      print(e);
      throw Exception(e.toString());
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
  Future<Response> Getmessage({
    required String endPoint,
  }) async {
    try {
      Response response = await dio.get(
        '$baseUrl$endPoint',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e);
      throw Exception(e.toString());
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

}