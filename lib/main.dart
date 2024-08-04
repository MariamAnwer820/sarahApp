import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/api.dart';
import 'package:saraih_app/api-service/cache_services.dart';
import 'package:saraih_app/cubit/Register-cubit/auth_cubit.dart';
import 'package:saraih_app/cubit/editing-cubit/editing_cubit.dart';
import 'package:saraih_app/cubit/login-cubit/login_cubit.dart';
import 'package:saraih_app/cubit/message-cubit/messages_cubit.dart';
import 'package:saraih_app/screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.initSharedPreference();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            ApiService(
              Dio(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            ApiService(
              Dio(),
            ),
          ),
        ),

        BlocProvider(
          create: (context) => MessagesCubit(
            ApiService(
              Dio(),
            ),
          ),
        ),

        BlocProvider(
          create: (context) => EditingCubit(
            ApiService(
              Dio(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
