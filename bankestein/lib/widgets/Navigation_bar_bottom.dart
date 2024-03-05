import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/settings_cubit.dart';

class NavigationBarBottom extends StatelessWidget {
  const NavigationBarBottom({super.key, this.selectedIndex});

  final int? selectedIndex;

  void onTap(BuildContext context, int index) {
    if (index != selectedIndex) {
      if (index == 0) {
        GoRouter.of(context).push('/home');
      }
      if (index == 1) {
        GoRouter.of(context).push('/accounts');
      }
      if (index == 2) {
        GoRouter.of(context).push('/recipients');
      }
      if (index == 3) {
        GoRouter.of(context).push('/transfer');
      }
      if (index == 4) {
        GoRouter.of(context).push('/settings');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: selectedIndex == 0
              ? Transform.translate(
                  offset: const Offset(0, -5), child: const Icon(Icons.home))
              : const Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 1
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.account_balance_wallet))
              : const Icon(Icons.account_balance_wallet),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 2
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.supervisor_account))
              : const Icon(Icons.supervisor_account),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 3
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.compare_arrows))
              : const Icon(Icons.compare_arrows),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 4
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.settings))
              : const Icon(Icons.settings),
          label: '',
        ),
      ],
      currentIndex: selectedIndex ?? 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: context.watch<SettingCubit>().state.primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) => onTap(context, index),
    );
  }
}
