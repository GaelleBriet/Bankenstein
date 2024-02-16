import 'package:flutter/material.dart';

import '../widgets/Navigation_bar_bottom.dart';
import '../widgets/Navigation_bar_top.dart';

class AccountView extends StatelessWidget {
  final int id;

  const AccountView({super.key, required this.id});

  static const String pageName = 'account_details';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NavigationBarTop(title: 'Account details'),
      body: Center(
        child: Text('Account details'),
      ),
      bottomNavigationBar: NavigationBarBottom(selectedIndex: 1),
    );
  }
}
