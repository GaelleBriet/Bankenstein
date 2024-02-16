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
    final settingsCubit = context.watch<SettingCubit>();
    return Scaffold(
      appBar: const NavigationBarTop(title: 'Settings', userName: userName),
      body: Center(
        child: CheckboxListTile(
          title: const Text('Activate dark theme '),
          value: settingsCubit.state.brightness == Brightness.dark,
          onChanged: (bool? value) {
            settingsCubit.toggleTheme();
          },
        ),
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 4),
    );
  }
}
