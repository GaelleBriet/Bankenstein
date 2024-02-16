import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/app_router.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Bankenstein';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (context) => AuthenticationCubit(),
      child: Builder(builder: (context) {
        return MaterialApp.router(
          title: title,
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF711CCC),
            ),
            // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            //   selectedItemColor:  Colors.white,
            //   unselectedItemColor: Colors.white,
            //   backgroundColor: Color(0xFF711CCC),
            // ),
            useMaterial3: false,
          ),
          routerConfig: AppRouter.routerOf(context),
        );
      }),
    );
  }
}
