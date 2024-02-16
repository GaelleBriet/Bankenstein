import 'package:flutter/material.dart';

class NavigationBarBottom extends StatefulWidget {
  const NavigationBarBottom({super.key});

  @override
  _NavigationBarBottomState createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _selectedIndex == 0
              ? Transform.translate(
                  offset: const Offset(0, -5), child: const Icon(Icons.home))
              : const Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.account_balance_wallet))
              : const Icon(Icons.account_balance_wallet),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.supervisor_account))
              : const Icon(Icons.supervisor_account),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 3
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.compare_arrows))
              : const Icon(Icons.compare_arrows),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 4
              ? Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(Icons.settings))
              : const Icon(Icons.settings),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: const Color(0xFF711CCC),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
    );
  }
}
