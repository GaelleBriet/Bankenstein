import 'package:bankestein/bloc/authentication_cubit.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckboxListTile(
                title: const Text('Activate dark theme '),
                value: settingsCubit.state.brightness == Brightness.dark,
                onChanged: (bool? value) {
                  settingsCubit.toggleTheme();
                },
              ),
              const Spacer(),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationCubit>().logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme
                          .of(context)
                          .primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Log Out'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarBottom(selectedIndex: 4),
    );
  }
}
