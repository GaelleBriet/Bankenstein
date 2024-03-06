import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/widgets/Navigation_bar_top.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/Navigation_bar_bottom.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String pageName = 'home';

  @override
  Widget build(BuildContext context) {
    // final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);

    return Scaffold(
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
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 0),
    );
  }
}
