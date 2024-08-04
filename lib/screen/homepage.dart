import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/api-service/cache_services.dart';
import 'package:saraih_app/cons.dart';
import 'package:saraih_app/cubit/message-cubit/messages_cubit.dart';
import 'package:saraih_app/cubit/message-cubit/messages_state.dart';
import 'package:saraih_app/functions/snack_bar.dart';
import 'package:saraih_app/screen/editName.dart';
import 'package:saraih_app/screen/login.dart';
import 'package:saraih_app/screen/profile.dart';
import 'package:saraih_app/screen/resetPassword.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.purple,
        title: const Text(
          'Creativity is Required',
          style: TextStyle(color: Colors.black, fontSize: 23,fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: colors.purple,
              ),
              child: Text('user name'),
            ),
            ListTile(
              leading:Icon(
                Icons.home,
               color: Colors.black,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20),
              ),
              
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => home_page()),
                ); 
              },
            ),
            ListTile(
              title: const Text('Profile', style: TextStyle(fontSize: 20)),
              leading:Icon(
                Icons.person,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<MessagesCubit>(context).Getmessage();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>profile() ),
                );
              },
            ),
            ListTile(
              title:
                  const Text('Reset password', style: TextStyle(fontSize: 20)),
                 leading:Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop();
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPassword()),
                );
              },
            ),
            ListTile(
              title: const Text('Edit name', style: TextStyle(fontSize: 20)),
              leading:Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop();
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditName()),
                );
              },
            ),
            ListTile(
              title: const Text('Logout', style: TextStyle(fontSize: 20)),
              leading:Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onTap: () { 
                CacheService.removeData(key: 'token');
                          print("$token is deleted");
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (context){
                        return LoginScreen();
                      }
                      
                      ));
              },
            ),
          ],
        ),
      ),
      body: BlocConsumer<MessagesCubit, MessagesState>(
        listener: (context, state) {
          if (state is MessagessuccessState) {
            emailController.clear();
            messageController.clear();
            showSnackBar(context, "Messge Sended Succefully");
          } else if (state is MessageserrorState) {
            showSnackBar(context, "Error, try again");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Send To:',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
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
                        horizontal: 18, vertical: 20),
                    child: TextFormField(
                      controller: messageController,
                      maxLines: 15,
                      maxLength: 400,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        filled: true,
                        fillColor: colors.white,
                        labelText: 'messsage',
                        labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30,
                          fontFamily: 'Gabriela',
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Material(
                    elevation: 5,
                    child: ConditionalBuilder(
                      condition: state is! MessagesloadingState,
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<MessagesCubit>(context).sendMassage(
                              email: emailController.text,
                              message: messageController.text,
                            );
                          }
                          ;
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: 'Gabriela'),
                        ),
                        style: ElevatedButton.styleFrom(
                            // ignore: deprecated_member_use
                            backgroundColor: colors.blue,
                            minimumSize: const Size(170, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                              width: 1.5,
                              color: Colors.white,
                            )),
                      ),
                      fallback: (context) => const CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

