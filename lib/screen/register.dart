import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/cache_services.dart';
import 'package:saraih_app/cons.dart';
import 'package:saraih_app/cubit/Register-cubit/auth_cubit.dart';
import 'package:saraih_app/cubit/Register-cubit/auth_state.dart';
import 'package:saraih_app/functions/snack_bar.dart';
import 'package:saraih_app/screen/login.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.purple,
        title: Center(
            child: Text(
          'Register',
          style: TextStyle(
              color: colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        )),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
           if (state is registerSuccessState) {
            showSnackBar(context, "Registered Successfully");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            CacheService.saveData(
                key: 'name',
                value: nameController.text,
              );
          print('$name');
          } else if (state is registerErrorState) {
            showSnackBar(context, "Error, try again");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                            'images/WhatsApp Image 2024-05-17 at 7.59.04 PM (1).jpeg'),
                        width: 300,
                        height: 180,
                      ),
                        textfieldItem(controller: nameController, hint:"Name"),
                      Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 10),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 10),
                            child: TextFormField(
                              //maxLength: 20,
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
                      textfieldItem(controller: ageController, hint:"Age"),
                      SizedBox(height: 20),
                      Material(
                        elevation: 5,
                        child: ConditionalBuilder(
                              condition: state is! registerLoadingState,
                              builder: (context) => ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    BlocProvider.of<AuthCubit>(context).Reguser(
                                      username: nameController.text,
                                      userEmail: emailController.text,
                                      userPassword: passwordController.text,
                                      age: ageController.text
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
                                  'Register',
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
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: GestureDetector(
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
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

Widget textfieldItem(
    {bool? secure,
    required TextEditingController controller,
    required String hint}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
    child: TextFormField(
      controller: controller,
      obscureText: secure ?? false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.blue, width: 1.5),
        ),
        filled: true,
        fillColor: colors.white,
        labelText: hint,
        labelStyle: TextStyle(
          color: Colors.blueGrey,
          fontSize: 30,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field is required';
        }
        return null;
      },
    ),
  );
}
