import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';

import 'package:bankestein/widgets/Navigation_bar_top.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/account_cubit.dart';
import '../bloc/recipient_cubit.dart';
import '../bloc/recipient_state.dart';
import '../bloc/transaction_cubit.dart';
import '../models/account.dart';
import '../models/recipient.dart';
import '../widgets/Navigation_bar_bottom.dart';

class TransferView extends StatelessWidget {
  // const TransferView({super.key});
  TransferView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _transactionNameController = TextEditingController();

  static const String pageName = 'transfer';

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

    int? _selectedAccountId;
    int? _destinationAccountId;

    return Scaffold(
      appBar: const NavigationBarTop(title: 'Transfer'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AccountCubit>(
            create: (context) {
              final accountCubit = AccountCubit(authenticationCubit);
              String? accessToken;
              if (authenticationCubit.state is AuthenticationAuthenticated) {
                accessToken =
                    (authenticationCubit.state as AuthenticationAuthenticated)
                        .accessToken;
              }
              accountCubit.getAccounts(accessToken!);
              return accountCubit;
            },
          ),
          BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(authenticationCubit),
          ),
          BlocProvider<RecipientCubit>(
            create: (context) {
              final recipientCubit = RecipientCubit(authenticationCubit);
              String? accessToken;
              if (authenticationCubit.state is AuthenticationAuthenticated) {
                accessToken =
                    (authenticationCubit.state as AuthenticationAuthenticated)
                        .accessToken;
              }
              recipientCubit.getRecipients(accessToken!);
              return recipientCubit;
            },
          ),
        ],
        child: BlocListener<TransactionCubit, TransactionState>(
          listener: (context, state) {
            if (state is TransactionTransferSuccess) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //         'Transfer en cours : ${state.amountToTransfer} € de ${state.accountName} vers ${state.destinationAccount}'),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              _formKey.currentState!.reset();
              _amountController.clear();
              GoRouter.of(context).push('/accounts');
            }
          },
          child: BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              if (state is AccountsLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'From Account*',
                            icon: Icon(Icons.verified_user_outlined),
                          ),
                          items: state.accounts.map((Account account) {
                            return DropdownMenuItem<int>(
                              value: account.id,
                              child: Text(account.toString()),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Ce champ est obligatoire';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _selectedAccountId = value;
                            print('selectedAccountId: $_selectedAccountId');
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Amount to transfer*',
                            icon: Icon(Icons.account_balance_wallet),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an amount';
                            } else if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            } else if (double.parse(value) <= 0) {
                              return 'Please enter a number greater than 0';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<RecipientCubit, RecipientState>(
                          builder: (context, recipientState) {
                            if (recipientState is RecipientLoaded) {
                              return DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  labelText: 'To Recipient*',
                                  icon: Icon(Icons.verified_user_outlined),
                                ),
                                items: recipientState.recipients.map<DropdownMenuItem<int>>((
                                    Recipient recipient) {
                                  return DropdownMenuItem<int>(
                                    value: recipient.accountId,
                                    child: Text(recipient.name.toString()),
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Ce champ est obligatoire';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                   _destinationAccountId = value;
                                   print('destinationAccountId: $value');
                                },
                              );
                            } else if (recipientState is RecipientLoading) {
                              return DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'To Recipient*',
                                    icon: Icon(Icons.verified_user_outlined),
                                  ),
                                  items: const [],
                                  onChanged: null,
                              );
                            } else if (recipientState is RecipientError) {
                              return Center(
                                child: Text('Error: ${recipientState.errorMessage}'),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _transactionNameController,
                          decoration: const InputDecoration(
                            labelText: 'Transaction name',
                            icon: Icon(Icons.account_balance_wallet),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 100),
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                // si le formulaire n'est pas valide
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Une erreur est survenue'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              } else {
                                // si le formulaire est valide
                                double amountToTransfer =
                                    double.parse(_amountController.text);

                                String transactionName =
                                    _transactionNameController.text.trim();

                                // Account selectedAccount = state.accounts
                                //     .firstWhere((account) =>
                                //         account.id == _selectedAccountId);
                                //
                                // String accountName = selectedAccount.name;
                                //
                                // Account destinationAccount = state.accounts
                                //     .firstWhere((account) =>
                                //         account.id == _destinationAccountId);

                                BlocProvider.of<TransactionCubit>(context)
                                    .transfer(
                                  _selectedAccountId!,
                                  amountToTransfer,
                                  _destinationAccountId!,
                                  transactionName,
                                );
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is AccountLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AccountError) {
                return Center(
                  child: Text('Error: ${state.message}'),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 3),
    );
  }
}
