import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';

import 'package:bankestein/widgets/Navigation_bar_top.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_cubit.dart';
import '../widgets/Navigation_bar_bottom.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  static const String pageName = 'transfer';

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

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
              print('Accounts loaded');
              List<String> accounts =
                  state.accounts.map((account) => account.toString()).toList();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'From Account*',
                          icon: Icon(Icons.verified_user_outlined),
                        ),
                        items: accounts.map((String value) {
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
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Amount to transfer*',
                          icon: Icon(Icons.account_balance_wallet),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
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
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a name for the transaction';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 50.0,
                        padding: const EdgeInsets.symmetric(horizontal: 128.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            // Implement submit logic
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
