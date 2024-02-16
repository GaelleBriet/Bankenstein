import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_cubit.dart';
import '../widgets/Navigation_bar_bottom.dart';
import '../widgets/Navigation_bar_top.dart';

class AccountsListView extends StatelessWidget {
  const AccountsListView({super.key});

  static const String pageName = 'accounts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavigationBarTop(title: 'Accounts'),
      body: BlocBuilder<AccountCubit, AccountState>(builder: (context, state) {
        if (state is AccountLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AccountLoaded) {
          return ListView.builder(
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              final account = state.accounts[index];
              final balanceInEuros = account.balance / 100;
              return Container(
                color: index.isEven
                    ? Colors.grey[200]
                    : Colors.transparent, // Un fond gris pour les lignes paires
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(account.name),
                      Text("${balanceInEuros.toStringAsFixed(2)}€"),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is AccountError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('No accounts found ... '),
          );
        }
      }),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 1),
    );
  }
}
