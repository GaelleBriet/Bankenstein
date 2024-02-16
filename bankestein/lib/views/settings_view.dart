import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_cubit.dart';
import '../widgets/Navigation_bar_bottom.dart';
import '../widgets/Navigation_bar_top.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const String pageName = 'settings';
  static const String userName = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavigationBarTop(title: 'Settings', userName: userName),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Toggle Theme'),
          onPressed: () {
            final settingsCubit = context.read<SettingCubit>();
            settingsCubit.toggleTheme();
          },
        ),
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 4),
    );
  }
}
