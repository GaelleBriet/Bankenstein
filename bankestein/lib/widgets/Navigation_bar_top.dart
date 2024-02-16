import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavigationBarTop extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NavigationBarTop({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: title != 'Home'
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                GoRouter.of(context).go('/home');
                // if (Navigator.of(context).canPop())
                // {
                //   Navigator.of(context).pop();
                //   // todo : trouver pourquoi ça ne marche pas
                // }
              },
            )
          : null,
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
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return Text(
                    state.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  );
                } else {
                  return const Text('');
                }
              },
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
