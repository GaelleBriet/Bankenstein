import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/recipient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipientDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController ibanController;
  final RecipientCubit recipientCubit;
  final String namePopUp;
  final bool isUpdate;
  final String? recipientName;
  final String? recipientIban;
  final int? recipientAccountId;

  const RecipientDialog({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.ibanController,
    required this.recipientCubit,
    required this.namePopUp,
    required this.isUpdate,
    this.recipientName,
    this.recipientIban,
    this.recipientAccountId,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      nameController.text = recipientName ?? '';
      ibanController.text = recipientIban ?? '';
    }
    return AlertDialog(
      scrollable: true,
      title: Text('$namePopUp recipient'),
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
          child: Text(namePopUp),
          onPressed: () {
            final authState = context.read<AuthenticationCubit>().state;
            if (authState is AuthenticationAuthenticated &&
                formKey.currentState!.validate()) {
              final name = nameController.text;
              final iban = ibanController.text;

              if (isUpdate) {
                recipientCubit.updateRecipient(
                  authState.accessToken,
                  name,
                  iban,
                  recipientAccountId,
                );
              } else {
                recipientCubit.addRecipient(
                  authState.accessToken,
                  name,
                  iban,
                );
              }
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
