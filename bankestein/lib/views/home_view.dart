import 'package:bankestein/widgets/Navigation_bar_top.dart';
import 'package:flutter/material.dart';

import '../widgets/Navigation_bar_bottom.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String pageName = 'home';
  static const String userName = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NavigationBarTop(title: 'Home', userName: userName),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome $userName!',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 18),
            Text(
                'Use the navigation bar to go to your accounts or to transfer money.',
                style: TextStyle(
                  fontSize: 12,
                )),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarBottom(selectedIndex: 0),
    );
  }
}
