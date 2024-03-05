import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/account_cubit.dart';
import '../bloc/authentication_cubit.dart';
import '../bloc/transaction_cubit.dart';

import '../widgets/Navigation_bar_bottom.dart';
import '../widgets/Navigation_bar_top.dart';

class AccountsListView extends StatelessWidget {
  const AccountsListView({super.key});

  static const String pageName = 'accounts';

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

    return Scaffold(
      appBar: const NavigationBarTop(title: 'Accounts'),
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
        ],
        child:
            BlocBuilder<AccountCubit, AccountState>(builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AccountsLoaded) {
            return ListView.builder(
              itemCount: state.accounts.length,
              itemBuilder: (context, index) {
                final account = state.accounts[index];
                final balanceInEuros = account.balance / 100;
                return Container(
                  color: index.isEven ? Colors.grey[200] : Colors.transparent,
                  // Un fond gris pour les lignes paires
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(account.name),
                        Text("${balanceInEuros.toStringAsFixed(2)} €"),
                      ],
                    ),
                    onTap: () {
                      final accountCubit = context.read<AccountCubit>();
                      final transactionCubit = context.read<TransactionCubit>();
                      final accessToken = accountCubit.accessToken;
                      transactionCubit.getAccountTransactions(
                          accessToken!, account.id);
                      GoRouter.of(context).push('/accounts/${account.id}');
                    },
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
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 1),
    );
  }
}
