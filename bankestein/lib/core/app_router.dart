import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:bankestein/views/login_view.dart';

import '../views/home_view.dart';
import 'go_router_fresh_stream.dart';

abstract class AppRouter {
  static GoRouter? _router;

  static List<String> _publicPages = [
    '/login',
  ];

  static GoRouter routerOf(BuildContext context) => _router ??= GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            name: LoginView.pageName,
            // builder: (context, state) => const LoginView(),
            pageBuilder: (context, state) => NoTransitionPage(
              child: LoginView(),
            ),
          ),
          GoRoute(
            path: '/home',
            name: HomeView.pageName,
            // builder: (context, state) => const LoginView(),
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeView(),
            ),
          ),
          GoRoute(
            path: '/settings',
            name: SettingsView.pageName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsView(),
            ),
          )
        ],
        refreshListenable: GoRouterRefreshStream(
          context.read<AuthenticationCubit>().stream,
        ),
        redirect: (context, state) {
          final authState = context.read<AuthenticationCubit>().state;

          if (authState is AuthenticationUnauthenticated) {
            if (!_publicPages.contains(state.uri.toString())) {
              return '/login';
            }
          }
          if (authState is AuthenticationAuthenticated) {
            if (_publicPages.contains(state.uri.toString())) {
              return '/home';
            }
          }
          return null;
        },
      );
}
