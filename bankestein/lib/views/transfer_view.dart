import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';

import 'package:bankestein/widgets/Navigation_bar_top.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_cubit.dart';
import '../models/account.dart';
import '../widgets/Navigation_bar_bottom.dart';

class TransferView extends StatelessWidget {
  // const TransferView({super.key});
  TransferView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  static const String pageName = 'transfer';

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

    int? _selectedAccountId;

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
          // BlocProvider<TransactionCubit>(
          //   create: (context) => TransactionCubit(authenticationCubit),
          // ),
        ],
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
                          print(_selectedAccountId);
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
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'To Recipient*',
                          icon: Icon(Icons.verified_user_outlined),
                        ),
                        items: <String>['Benj', 'Alice', 'Company Inc.']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          // Handle change
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
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
                              String accountName = _selectedAccountId.toString();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Transfer en cours : $amountToTransfer € de $accountName vers ...'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _formKey.currentState!.reset();
                              _amountController.clear();
                              // BlocProvider.of<TransactionCubit>(context).transfer(
                              //   _selectedAccountId,
                              //   amountToTransfer,
                              // );
                              print('Selected account: $_selectedAccountId');
                              print('Amount to transfer: $amountToTransfer');
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
              print('Loading');
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountError) {
              print('Error');
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 3),
    );
  }
}
