import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/cubit/editing-cubit/editing_cubit.dart';
import 'package:saraih_app/cubit/editing-cubit/editing_state.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text('Reset Password'),
      content: BlocConsumer<EditingCubit, EditingState>(
        listener: (context, state) {
          if (state is EditingpasswordSuccess) {
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset successful')),
            );
          } else if (state is EditingpasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error resetting password')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  Text('Enter your new password:'),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Old Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocBuilder<EditingCubit, EditingState>(
          builder: (context, state) {
            return ConditionalBuilder(
              condition: state is! EditingpasswordLoading,
              builder: (context) => ElevatedButton(
                child: Text('Reset'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    BlocProvider.of<EditingCubit>(context).resetpassword(
                      oldPassword: oldPasswordController.text,
                      newPassword: newPasswordController.text,
                      newPassswordConfirmation: confirmPasswordController.text,
                    );
                  }
                },
              ),
              fallback: (context) => const CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
