import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String pageName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text('Login',
            style: TextStyle(
              fontSize: 24,
            ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
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
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // Logique de connexion
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
