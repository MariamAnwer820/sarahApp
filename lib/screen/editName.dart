import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saraih_app/cubit/editing-cubit/editing_cubit.dart';
import 'package:saraih_app/cubit/editing-cubit/editing_state.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final TextEditingController newNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text('Edit Name'),
      content: BlocConsumer<EditingCubit, EditingState>(
        listener: (context, state) {
          if (state is EditingnameSuccess) {
            newNameController.clear();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Name changed successfully')),
            );
          } else if (state is EditingnameError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error changing name')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  Text('Enter your new name:'),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: newNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
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
            return ElevatedButton(
              child: Text('Edit'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  BlocProvider.of<EditingCubit>(context).editName(
                    name: newNameController.text,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
