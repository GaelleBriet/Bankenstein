import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/recipient_cubit.dart';
import 'package:bankestein/models/recipient.dart';
import 'package:bankestein/widgets/recipient_dialog.dart';
import 'package:bankestein/bloc/settings_cubit.dart';

class RecipientList extends StatelessWidget {
  final List<Recipient> recipients;
  final RecipientCubit recipientCubit;
  final AuthenticationState authState;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RecipientList({
    Key? key,
    required this.recipients,
    required this.recipientCubit,
    required this.authState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: recipients.length,
            itemBuilder: (context, index) {
              final recipient = recipients[index];
              return Container(
                color: index.isEven ? Colors.grey[200] : Colors.transparent,
                child: ListTile(
                  title: Text(recipient.name),
                  subtitle: Text(recipient.iban),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RecipientDialog(
                                formKey: _formKey,
                                nameController: _nameController,
                                ibanController: _ibanController,
                                recipientCubit: recipientCubit,
                                isUpdate: true,
                                namePopUp: "Modify",
                                recipientName: recipient.name,
                                recipientIban: recipient.iban,
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          final authState =
                              context.read<AuthenticationCubit>().state;
                          if (authState is AuthenticationAuthenticated) {
                            recipientCubit.deleteRecipient(
                              authState.accessToken,
                              recipient.id,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: context.watch<SettingCubit>().state.primaryColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipientDialog(
                    formKey: _formKey,
                    nameController: _nameController,
                    ibanController: _ibanController,
                    recipientCubit: recipientCubit,
                    isUpdate: false,
                    namePopUp: "Add",
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
