import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/recipient_state.dart';
import 'package:bankestein/bloc/settings_cubit.dart';
import 'package:bankestein/widgets/popup_recipient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recipient_cubit.dart';
import '../widgets/navigation_bar_bottom.dart';
import '../widgets/navigation_bar_top.dart';

class RecipientsView extends StatelessWidget {
  RecipientsView({Key? key}) : super(key: key) {
    _formKey = GlobalKey<FormState>();
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  static const String pageName = 'recipients';
  late final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final recipientCubit = BlocProvider.of<RecipientCubit>(context);

    return Scaffold(
      appBar: const NavigationBarTop(title: 'Recipients'),
      body: BlocBuilder<RecipientCubit, RecipientState>(
        builder: (context, state) {
          if (state is RecipientLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipientLoaded) {
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: state.recipients.length,
                  itemBuilder: (context, index) {
                    final recipient = state.recipients[index];
                    //final iban = state.recipients[index].accountId;
                    return Container(
                      color:
                          index.isEven ? Colors.grey[200] : Colors.transparent,
                      child: ListTile(
                        title: Text(recipient.name),
                        subtitle: Text(recipient.iban),
                        trailing: IconButton(
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
                      ),
                    );
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor:
                        context.watch<SettingCubit>().state.primaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddRecipientDialog(
                            formKey: _formKey,
                            nameController: _nameController,
                            ibanController: _ibanController,
                            recipientCubit: recipientCubit,
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          } else if (state is RecipientError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text('No recipients found ... '),
            );
          }
        },
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 3),
    );
  }
}
