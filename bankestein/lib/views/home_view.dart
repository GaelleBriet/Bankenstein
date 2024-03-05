import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/transaction_cubit.dart';
import 'package:bankestein/widgets/Navigation_bar_top.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/Navigation_bar_bottom.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String pageName = 'home';

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);

    return BlocProvider<TransactionCubit>(
      create: (context) => TransactionCubit(authenticationCubit),
      child: Scaffold(
        appBar: const NavigationBarTop(title: 'Home'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    return Text(
                      'Welcome ${state.name} !',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    );
                  } else {
                    return const Text('Welcome!');
                  }
                },
              ),
              const SizedBox(height: 18),
              const Text(
                  'Use the navigation bar to go to your accounts or to transfer money.',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  final transactionCubit = BlocProvider.of<TransactionCubit>(context);
                  final userId =
                      (authenticationCubit.state as AuthenticationAuthenticated).id;
                  print('userId: $userId');
                  // if (userId != null) {
                  //   transactionCubit.getLastThreeTransactions(
                  //       (authenticationCubit.state as AuthenticationAuthenticated)
                  //           .accessToken,
                  //       userId);
                  // }
                  if (state is TransactionLoaded) {
                    return Column(
                      children: state.transactions.map((transaction) {
                        return ListTile(
                          title: Text(transaction.name),
                          subtitle: Text('Amount: ${transaction.amount}'),
                        );
                      }).toList(),
                    );
                  } else if (state is TransactionLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text('An error occurred');
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const NavigationBarBottom(selectedIndex: 0),
      ),
    );
  }
}
