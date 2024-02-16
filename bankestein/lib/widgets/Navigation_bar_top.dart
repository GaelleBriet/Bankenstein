import 'package:flutter/material.dart';

class NavigationBarTop extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;

  const NavigationBarTop(
      {super.key, required this.title, required this.userName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
      ),
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
              icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
              ),
              onPressed: () {
                // Logique pour 'Mon compte'
              },
            ),
          ],
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
