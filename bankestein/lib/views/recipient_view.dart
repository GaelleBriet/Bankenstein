import 'package:bankestein/widgets/Navigation_bar_top.dart';
import 'package:flutter/material.dart';

import '../widgets/Navigation_bar_bottom.dart';

class RecipientsView extends StatelessWidget {
  const RecipientsView({super.key});

  static const String pageName = 'recipients';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NavigationBarTop(title: 'Recipients'),
      body: Center(
        child: Text('Recipients'),
      ),
      bottomNavigationBar: NavigationBarBottom(selectedIndex: 2),
    );
  }
}
