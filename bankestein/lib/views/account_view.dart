import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/account_cubit.dart';
import '../bloc/transaction_cubit.dart';
import '../widgets/Navigation_bar_bottom.dart';
import '../widgets/Navigation_bar_top.dart';

class AccountView extends StatelessWidget {
  final int id;

  const AccountView({super.key, required this.id});

  static const String pageName = 'account_details';

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);
    String? accessToken;
    if (authenticationCubit.state is AuthenticationAuthenticated) {
      accessToken = (authenticationCubit.state as AuthenticationAuthenticated)
          .accessToken;
    }
    final accountCubit = BlocProvider.of<AccountCubit>(context);
    final transactionCubit = BlocProvider.of<TransactionCubit>(context);
    accountCubit.getAccount(accessToken!, id);
    transactionCubit.getAccountTransactions(accessToken!, id);

    return Scaffold(
      appBar: const NavigationBarTop(title: 'Account details'),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, accountState) {
          return BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, transactionState) {
              if (accountState is AccountLoading || transactionState is TransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (accountState is AccountLoaded && transactionState is TransactionLoaded) {
                final balanceInEuros = accountState.accounts[0].balance / 100;
                return Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.black,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.download,
                                color: Color(0xFF711CCC),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'GetRIB',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            'Total Balance: ${balanceInEuros.toStringAsFixed(2)}€',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Last transactions',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transactionState.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactionState.transactions[index];
                          final balanceInEuros = transaction.amount / 100;
                          return ListTile(
                            title: Text(transaction.name),
                            subtitle: Text(DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(transaction.date))),
                            trailing: Text(
                              "${balanceInEuros.toStringAsFixed(2)} €",
                              style: TextStyle(
                                color: balanceInEuros >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No transactions found'));
              }
            },
          );
        },
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 1),
    );
  }
}