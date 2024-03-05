import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/recipient_cubit.dart'; // Import the recipient cubit
import 'package:bankestein/bloc/recipient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecipientDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController ibanController;
  final RecipientCubit recipientCubit; // Add recipientCubit as a parameter

  const AddRecipientDialog({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.ibanController,
    required this.recipientCubit, // Require recipientCubit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipientCubit, RecipientState>(
      listener: (context, state) {
        if (state is RecipientError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        scrollable: true,
        title: const Text('Add recipient'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ibanController,
                  decoration: const InputDecoration(
                    labelText: 'IBAN',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the IBAN';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Add"),
            onPressed: () {
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is AuthenticationAuthenticated &&
                  formKey.currentState!.validate()) {
                final name = nameController.text;
                final iban = ibanController.text;

                recipientCubit.addRecipient(
                  authState.accessToken,
                  name,
                  iban,
                );
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}
