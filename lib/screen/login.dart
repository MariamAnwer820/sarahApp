import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/cache_services.dart';
import 'package:saraih_app/cons.dart';
import 'package:saraih_app/cubit/login-cubit/login_cubit.dart';
import 'package:saraih_app/cubit/login-cubit/login_state.dart';
import 'package:saraih_app/functions/snack_bar.dart';
import 'package:saraih_app/screen/homepage.dart';
import 'package:saraih_app/screen/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.purple,
        title: Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.userlogin.status == 'true') {
              showSnackBar(context, "Login Successfully ");
              CacheService.saveData(
                key: 'token',
                value: state.userlogin.token,
              ).then(
                (value) {
                  print("login successfully");
                  token = CacheService.getData(key: 'token');
                  print(token);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => home_page()),
                  );
                },
              );
            } else {
              showSnackBar(context, "This user not found ");
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset(
                          'images/WhatsApp Image 2024-05-17 at 7.59.04 PM (1).jpeg'),
                      width: 300,
                      height: 240,
                    ),
                    Center(child: Text('CREATIVITY IS REQUIRED',style: TextStyle(color: colors.purple,fontSize: 25,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 20,),
                    
                        // Icon(Icons.email,
                        // color: Colors.black,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: colors.blue, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: colors.blue, width: 1.5),
                              ),
                              filled: true,
                              fillColor: colors.white,
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontFamily: 'Gabriela',
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              } else if (!value.endsWith('@gmail.com')) {
                                return 'Email must end with @gmail.com';
                              }
                              return null;
                            },
                          ),
                        ),
                      
                    
                        // Icon(Icons.password,
                        // color: Colors.black,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                               vertical: 10),
                          child: TextFormField(
                            maxLength: 20,
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: colors.blue, width: 1.5),
                              ),
                              filled: true,
                              fillColor: colors.white,
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 30,
                                fontFamily: 'Gabriela',
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              } //else if (!RegExp(passwordPattern).hasMatch(value)) {
                                //return 'Password not match';
                              //}
                              return null;
                            },
                          ),
                        ),
                      
                    //SizedBox(height: 20),
                    Material(
                      elevation: 5,
                      child: ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              BlocProvider.of<LoginCubit>(context).loguser(
                                userEmail: emailController.text,
                                userPassword: passwordController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.blue,
                            minimumSize: const Size(80, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                              width: 1.5,
                              color: Colors.white,
                            ),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: 'Gabriela',
                            ),
                          ),
                        ),
                        fallback: (context) => const CircularProgressIndicator(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: GestureDetector(
                        child: Text(
                          "don't have account, create account",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
