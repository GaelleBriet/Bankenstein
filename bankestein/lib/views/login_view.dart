import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bankestein/bloc/authentication_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  static const String pageName = 'login';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_balance,
                color: Color(0xFF711CCC),
                size: 64,
              ),
              const Text('Bankenstein',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF711CCC),
                  )),
              const SizedBox(height: 48),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // Logique pour 'Mot de passe oublié'
                },
                child: const Text('Forgot Password'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme
                      .of(context)
                      .primaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        4.0), // Bord arrondi spécifique à Material 2
                  ),
                  minimumSize: const Size.fromHeight(50),
                  elevation: 4.0,
                  // backgroundColor: Theme.of(context).primaryColor,
                  // foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Logique de connexion
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  print(
                      'Login button pressed with email: $email and password: $password');
                  context.read<AuthenticationCubit>().login(email, password);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
