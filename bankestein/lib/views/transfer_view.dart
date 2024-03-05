import 'package:flutter/material.dart';

import 'package:bankestein/widgets/Navigation_bar_top.dart';

import '../widgets/Navigation_bar_bottom.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  static const String pageName = 'transfer';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NavigationBarTop(title: 'Transfer'),
      body: Center(
        child: Text('Transfer'),
      ),
      bottomNavigationBar: NavigationBarBottom(selectedIndex: 3),
    );
  }
}
