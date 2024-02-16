import 'package:flutter/material.dart';

class NavigationBarTop extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;

  const NavigationBarTop(
      {super.key, required this.title, required this.userName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Logique pour 'Mon compte'
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
